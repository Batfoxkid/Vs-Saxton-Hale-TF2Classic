// don't like the angles for jump/teleport/weighdown? change them here.
#define JUMP_TELEPORT_MAX_ANGLE -45.0
#define WEIGHDOWN_MIN_ANGLE 60.0 // first went with 45 but it mistriggered in ways I'd never done.

#pragma semicolon 1
#include <sourcemod>
#include <clientprefs>
#include <sdkhooks>
#include <sdktools>
#include <tf2c>
#pragma newdecls required

#define MAJOR_REVISION	"1"
#define MINOR_REVISION	"2"
#define STABLE_REVISION	"0"
#define PLUGIN_VERSION	MAJOR_REVISION..."."...MINOR_REVISION..."."...STABLE_REVISION

public Plugin myinfo =
{
	name		=	"Versus Saxton Hale",
	author		=	"Batfoxkid",
	description	=	"VSH for Team Fortress 2 Classic",
	version		=	PLUGIN_VERSION
};

#define FAR_FUTURE	100000000.0
#define PREFIX		"\x04[VSH]\x01 "

#define CHARGE_BUTTON	IN_ATTACK2
#define HUD_Y		0.88
#define HUD_INTERVAL	0.2
#define HUD_LINGER	0.01
#define HUD_ALPHA	192
#define HUD_R_OK	255
#define HUD_G_OK	255
#define HUD_B_OK	255
#define HUD_R_ERROR	255
#define HUD_G_ERROR 	64
#define HUD_B_ERROR	64

#define DEFAULTCLASS	TFClass_Soldier

static const int ClassLimit[] =
{
	0,	// Blank
	3,	// Scout
	10,	// Sniper
	0,	// Soldier
	0,	// Demoman
	0,	// Medic
	0,	// Heavy
	3,	// Pyro
	4,	// Spy
	4,	// Engineer
	0	// Cilvilian
};

enum struct ClientEnum
{
	int Damage;
	int Queue;
	int LastWeapon;

	float HudAt;
	float StunFor;
	float GlowFor;

	char Theme[PLATFORM_MAX_PATH];
	float ThemeAt;
}

enum struct HaleEnum
{
	bool Enabled;
	bool Respawning;
	int MaxHealth;
	int Health;

	int Rage;
	float RageFor;

	bool SpreeNext;
	float SpreeFor;

	bool JumpDuper;
	float JumpReadyAt;
	float JumpChargeFrom;

	float WeighReadyAt;
	float WeighNormalizeAt;

	char Name[64];

	Function RoundIntro;	// void()
	Function RoundStart;	// void(int client)
	Function RoundLastman;	// void()
	Function RoundEnd;	// void(int client)
	Function RoundWin;	// void()

	Function PlayerSpawn;	// void(int client)
	Function PlayerSound;	// Action(int clients[MAXPLAYERS], int &numClients, char sound[PLATFORM_MAX_PATH], int &client, int &channel, float &volume, int &level, int &pitch, int &flags, char soundEntry[PLATFORM_MAX_PATH], int &seed)
	Function PlayerVoice;	// void(int client)
	Function PlayerCommand;	// void(int client, int &buttons)

	Function PlayerKill;	// void(int client, int victim)
	Function PlayerDeath;	// void(int client, int attacker)

	Function PlayerTakeDamage;	// Action(int client, int &attacker, int &inflictor, float &damage, int &damagetype, int &weapon, float damageForce[3], float damagePosition[3], int damagecustom)
	Function PlayerDealDamage;	// Action(int client, int victim, int &inflictor, float &damage, int &damagetype, int &weapon, float damageForce[3], float damagePosition[3], int damagecustom)

	Function MiscDestory;	// void(int client)
	Function MiscTheme;	// void(int client)
	Function MiscDesc;	// void(int client)
}

bool Enabled;
int RoundMode;
int LeaderHale;
int AlivePlayers;

const int BossTeam = view_as<int>(TFTeam_Blue);
const int MercTeam = view_as<int>(TFTeam_Red);

ClientEnum Client[MAXPLAYERS+1];
HaleEnum Hale[MAXPLAYERS+1];

Cookie Cookies;

ConVar CvarSpec;
ConVar CvarBonus;
//ConVar CvarCheats;

Handle PlayerHud;
Handle MainHud;

#tryinclude "cvsh/modules/menu.sp"

public void OnPluginStart()
{
	#if defined MODULE_MENU
	Menu_PluginStart();
	#endif

	RegAdminCmd("sm_stun", Command_Stun, ADMFLAG_RCON, "Usage: sm_stun <target>");
	RegAdminCmd("ff2_addpoints", Command_AddPoints, ADMFLAG_CHEATS, "Usage: ff2_addpoints <target> [amount]");

	HookEvent("player_spawn", OnPlayerSpawn);
	//HookEvent("player_changeclass", OnPlayerChangeClass);
	HookEvent("player_hurt", OnPlayerHurt, EventHookMode_Pre);
	HookEvent("player_death", OnPlayerDeath, EventHookMode_PostNoCopy);

	HookEvent("object_deflected", OnObjectDeflected, EventHookMode_Pre);
	HookEvent("object_destroyed", OnObjectDestroyed, EventHookMode_Pre);
	HookEvent("arena_win_panel", OnWinPanel, EventHookMode_Pre);

	HookEvent("teamplay_round_start", OnRoundSetup, EventHookMode_PostNoCopy);
	HookEvent("arena_round_start", OnRoundStart, EventHookMode_PostNoCopy);
	HookEvent("teamplay_round_win", OnRoundEnd, EventHookMode_Post);

	LoadTranslations("common.phrases");

	Cookies = new Cookie("ff2_cookies_mk2", "You joined VSH after Vagineer was made!", CookieAccess_Protected);

	AddCommandListener(OnVoiceMenu, "voicemenu");
	AddCommandListener(OnJoinTeam, "jointeam");
	//AddCommandListener(OnAutoTeam, "autoteam");
	AddCommandListener(OnJoinClass, "joinclass");
	AddCommandListener(BlockHaleCommand, "kill");
	AddCommandListener(BlockHaleCommand, "explode");

	AddNormalSoundHook(HookSound);

	Enabled = false;
	RoundMode = -1;

	CvarSpec = FindConVar("mp_allowspectators");
	CvarBonus = FindConVar("mp_bonusroundtime");
	//CvarCheats = FindConVar("sv_cheats");
	//CvarCheats.Flags &= ~FCVAR_NOTIFY;

	PlayerHud = CreateHudSynchronizer();
	MainHud = CreateHudSynchronizer();

	for(int client=1; client<=MaxClients; client++)
	{
		if(IsClientInGame(client))
			OnClientPostAdminCheck(client);
	}
}

public void OnMapEnd()
{
	Enabled = false;
	RoundMode = -1;
}

public void OnPluginEnd()
{
	for(int client=1; client<=MaxClients; client++)
	{
		if(IsClientInGame(client))
			OnClientDisconnect(client);
	}
}

public void OnClientPostAdminCheck(int client)
{
	Client[client].ThemeAt = GetEngineTime()+2.0;
	SDKHook(client, SDKHook_OnTakeDamage, OnTakeDamage);
	if(!AreClientCookiesCached(client))
	{
		Client[client].Queue = 0;
		return;
	}

	static char buffer[8];
	Cookies.Get(client, buffer, sizeof(buffer));
	Client[client].Queue = StringToInt(buffer);
}

public Action Command_Stun(int client, int args)
{
	if(!args)
	{
		ReplyToCommand(client, "[SM] Usage: sm_stun <target>");
		return Plugin_Handled;
	}

	char pattern[PLATFORM_MAX_PATH], targetName[MAX_TARGET_LENGTH];
	int targets[MAXPLAYERS], matches;
	bool targetNounIsMultiLanguage;

	GetCmdArgString(pattern, sizeof(pattern));
	if((matches=ProcessTargetString(pattern, client, targets, sizeof(targets), COMMAND_FILTER_NO_IMMUNITY, targetName, sizeof(targetName), targetNounIsMultiLanguage)) < 1)
	{
		ReplyToTargetError(client, matches);
		return Plugin_Handled;
	}

	float engineTime = GetEngineTime()+5.0;
	for(int target; target<matches; target++)
	{
		if(IsClientSourceTV(targets[target]) || IsClientReplay(targets[target]))
			continue;

		Client[targets[target]].LastWeapon = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
		Client[targets[target]].StunFor = engineTime;
	}
	return Plugin_Handled;
}

public Action Command_AddPoints(int client, int args)
{
	if(args!=1 && args!=2)
	{
		ReplyToCommand(client, "[SM] Usage: ff2_addpoints <target> [amount]");
		return Plugin_Handled;
	}

	char pattern[PLATFORM_MAX_PATH], targetName[MAX_TARGET_LENGTH];
	int targets[MAXPLAYERS], matches;
	bool targetNounIsMultiLanguage;

	GetCmdArg(1, pattern, sizeof(pattern));
	if((matches=ProcessTargetString(pattern, client, targets, sizeof(targets), COMMAND_FILTER_NO_IMMUNITY, targetName, sizeof(targetName), targetNounIsMultiLanguage)) < 1)
	{
		ReplyToTargetError(client, matches);
		return Plugin_Handled;
	}

	GetCmdArg(2, pattern, sizeof(pattern));
	int queue = StringToInt(pattern);
	for(int target; target<matches; target++)
	{
		if(IsClientSourceTV(targets[target]) || IsClientReplay(targets[target]))
			continue;

		if(args == 1)
		{
			ReplyToCommand(client, "[SM] %N has %d queue points", targets[target], Client[targets[target]].Queue);
			continue;
		}

		Client[targets[target]].Queue = queue;
	}
	return Plugin_Handled;
}

public Action OnVoiceMenu(int client, const char[] command, int args)
{
	if(!Hale[client].Enabled || !IsPlayerAlive(client))
		return Plugin_Continue;

	if(Hale[client].PlayerVoice == INVALID_FUNCTION)
		return Plugin_Continue;

	Call_StartFunction(null, Hale[client].PlayerVoice);
	Call_PushCell(client);
	Action action;
	Call_Finish(action);
	return action;
}

/*public Action Timer_EnableBuilding(Handle timer, any sentryid)
{
	int sentry = EntRefToEntIndex(sentryid);
	if(sentry > MaxClients)
	{
		PrintToConsoleAll("[VSH] Unstunning sentry %d (%d)", sentry, sentryid);
		SetEntProp(sentry, Prop_Send, "m_bDisabled", 0);
		SetEntProp(sentry, Prop_Send, "m_iState", 1);
	}

	return Plugin_Continue;
}*/

public Action OnJoinTeam(int client, const char[] command, int args)
{
	if(!client || !Enabled)
		return Plugin_Continue;

	static char buffer[10];
	GetCmdArg(1, buffer, sizeof(buffer));
	if(!buffer[0])
		return Plugin_Continue;

	if(StrEqual(buffer, "red", false) || StrEqual(buffer, "blue", false) || StrEqual(buffer, "auto", false))
	{
		if(GetClientTeam(client) <= view_as<int>(TFTeam_Spectator))
		{
			if(Hale[client].Enabled)
			{
				ChangeClientTeam(client, BossTeam);
			}
			else
			{
				ChangeClientTeam(client, MercTeam);
				if(GetEntProp(client, Prop_Send, "m_iDesiredPlayerClass") == view_as<int>(TFClass_Unknown))
					SetEntProp(client, Prop_Send, "m_iDesiredPlayerClass", view_as<int>(DEFAULTCLASS));
			}
		}
	}
	else if(!Hale[client].Enabled && CvarSpec.BoolValue && StrEqual(buffer, "spectate", false))
	{
		ChangeClientTeam(client, view_as<int>(TFTeam_Spectator));
	}
	return Plugin_Handled;
}

public Action OnJoinClass(int client, const char[] command, int args)
{
	if(!client || !Enabled)
		return Plugin_Continue;

	if(Hale[client].Enabled)
		return Plugin_Handled;

	if(RoundMode)
		return Plugin_Continue;

	static char buffer[32];
	GetCmdArg(1, buffer, sizeof(buffer));
	TFClassType class = GetClassFromName(buffer);
	if(class==TFClass_Unknown || ClassLimit[class]<1 || TF2_GetPlayerClass(client)==class)
		return Plugin_Continue;

	int clients, classes;
	for(int i=1; i<=MaxClients; i++)
	{
		if(!IsClientInGame(i) || GetClientTeam(i)!=MercTeam)
			continue;

		clients++;
		if(TF2_GetPlayerClass(i) == class)
			classes++;
	}

	int limit = ClassLimit[class];
	if(clients > 32)
		limit += RoundToCeil(ClassLimit[class]*((clients-32.0)/32.0));

	if(classes < limit)
		return Plugin_Continue;

	PrintCenterText(client, "There's too many players on this class!");
	return Plugin_Handled;
}

public Action BlockHaleCommand(int client, const char[] command, int args)
{
	return (Hale[client].Enabled && RoundMode!=2) ? Plugin_Handled : Plugin_Continue;
}

public void OnRoundSetup(Event event, const char[] name, bool dontBroadcast)
{
	RoundMode = 0;
	if(!Enabled)
		return;

	for(int i=1; i<=MaxClients; i++)
	{
		if(!IsClientInGame(i) || GetClientTeam(i)<=view_as<int>(TFTeam_Spectator))
			continue;

		if(Hale[i].Enabled)
		{
			Client[i].Queue = 0;
			if(GetClientTeam(i) != BossTeam)
			{
				ChangeClientTeam(i, BossTeam);
				continue;
			}

			if(Hale[i].PlayerSpawn != INVALID_FUNCTION)
			{
				LogMessage("%d::PlayerSpawn", i);
				Call_StartFunction(null, Hale[i].PlayerSpawn);
				Call_PushCell(i);
				Call_Finish();
			}

			if(Hale[i].MiscDesc == INVALID_FUNCTION)
				continue;

			Call_StartFunction(null, Hale[i].MiscDesc);
			Call_PushCell(i);
			Call_Finish();
		}
		else if(GetClientTeam(i) != MercTeam)
		{
			ChangeClientTeam(i, MercTeam);
		}
	}

	CreateTimer(GetConVarFloat(FindConVar("tf_arena_preround_time"))/2.857, StartResponseTimer, _, TIMER_FLAG_NO_MAPCHANGE);
}

public Action StartResponseTimer(Handle timer)
{
	if(Hale[LeaderHale].RoundIntro == INVALID_FUNCTION)
		return Plugin_Continue;

	Call_StartFunction(null, Hale[LeaderHale].RoundIntro);
	Call_Finish();
	return Plugin_Continue;
}

public void OnRoundStart(Event event, const char[] name, bool dontBroadcast)
{
	RoundMode = 1;
	if(!Enabled)
		return;

	float engineTime = GetEngineTime();

	int clients;
	int[] client = new int[MaxClients];
	for(int i=1; i<=MaxClients; i++)
	{
		if(!IsClientInGame(i))
			continue;

		Client[i].ThemeAt = engineTime+1.5;
		if(GetClientTeam(i) <= view_as<int>(TFTeam_Spectator))
		{
			Client[i].HudAt = engineTime+10.5;
			continue;
		}

		client[clients++] = i;
		if(Hale[i].Enabled)
		{
			if(GetClientTeam(i) != BossTeam)
				ChangeClientTeam(i, BossTeam);

			if(Hale[i].RoundStart == INVALID_FUNCTION)
				continue;

			LogMessage("%d::RoundStart", i);
			Call_StartFunction(null, Hale[i].RoundStart);
			Call_PushCell(i);
			Call_Finish();
		}
		else if(GetClientTeam(i) != MercTeam)
		{
			Client[i].HudAt = engineTime+10.5;
			ChangeClientTeam(i, MercTeam);
		}
	}

	if(IsClientInGame(LeaderHale))
	{
		Hale[LeaderHale].Health = RoundFloat((Pow((758.8+clients)*(clients-1), 1.0341)+1046.0));
		Hale[LeaderHale].MaxHealth = Hale[LeaderHale].Health;

		SetHudTextParams(-1.0, 0.2, 10.0, 255, 255, 255, 255);
		for(int i; i<clients; i++)
		{
			ShowSyncHudText(client[i], MainHud, "%N became %s\nwith %d HP", LeaderHale, Hale[LeaderHale].Name, Hale[LeaderHale].Health);
		}
	}

	RequestFrame(CheckAlivePlayers);

	SetControlPoint(false);
	//SetArenaCapEnableTime(0.0);
}

public void OnRoundEnd(Event event, const char[] name, bool dontBroadcast)
{
	float bonusRoundTime = CvarBonus.FloatValue-0.5;
	RoundMode = 2;
	if(Enabled)
	{
		int top[3];
		int clients;
		int[] client = new int[MaxClients];
		for(int i=1; i<=MaxClients; i++)
		{
			if(!IsClientInGame(i))
				continue;

			if(Client[i].Theme[0])
			{
				StopSound(i, SNDCHAN_STATIC, Client[i].Theme);
				Client[i].Theme[0] = 0;
				Client[i].ThemeAt = FAR_FUTURE;
			}

			client[clients++] = i;
			if(Hale[i].Enabled)
			{
				if(Hale[i].RoundEnd != INVALID_FUNCTION)
				{
					Call_StartFunction(null, Hale[i].RoundEnd);
					Call_PushCell(i);
					Call_Finish();
				}
				continue;
			}

			if(Client[i].Damage < 1)
				continue;

			if(Client[i].Damage >= Client[top[0]].Damage)
			{
				top[2] = top[1];
				top[1] = top[0];
				top[0] = i;
			}
			else if(Client[i].Damage >= Client[top[1]].Damage)
			{
				top[2] = top[1];
				top[1] = i;
			}
			else if(Client[i].Damage >= Client[top[2]].Damage)
			{
				top[2] = i;
			}
		}

		if(top[0] > 9000)
			CreateTimer(1.0, WeHadToKeepThis, _, TIMER_FLAG_NO_MAPCHANGE);

		bool won = event.GetInt("team")==BossTeam;

		char buffer[256];
		if(IsClientInGame(LeaderHale) && IsPlayerAlive(LeaderHale))
			FormatEx(buffer, sizeof(buffer), "%s (%N) %s with %d HP left", Hale[LeaderHale].Name, LeaderHale, won ? "won" : "lost", Hale[LeaderHale].Health);

		if(top[2] > 0)
		{
			Format(buffer, sizeof(buffer), "%s\n \nTop Damage:\n1) %N - %d\n2) %N - %d\n3) %N - %d", buffer, top[0], Client[top[0]].Damage, top[1], Client[top[1]].Damage, top[2], Client[top[2]].Damage);
		}
		else if(top[1] > 0)
		{
			Format(buffer, sizeof(buffer), "%s\n \n \n%N dealt %d damage\n%N dealt %d damage", buffer, top[0], Client[top[0]].Damage, top[1], Client[top[1]].Damage);
		}
		else if(top[0] > 0)
		{
			Format(buffer, sizeof(buffer), "%s\n \n \n%N dealt %d damage", buffer, top[0], Client[top[0]].Damage);
		}
		else
		{
			Format(buffer, sizeof(buffer), "%s\n \n \nNo one dealt any damage...", buffer);
		}

		if(won)
		{
			if(Hale[LeaderHale].RoundWin != INVALID_FUNCTION)
			{
				LogMessage("%d::RoundWin", LeaderHale);
				Call_StartFunction(null, Hale[LeaderHale].RoundWin);
				Call_Finish();
			}
		}

		SetHudTextParams(-1.0, 0.25, bonusRoundTime, 255, 255, 255, 255);
		for(int i; i<clients; i++)
		{
			if(LeaderHale == client[i])
			{
				ShowSyncHudText(client[i], MainHud, "%s\n \n%s", buffer, won ? "Congratulations! You won!" : "Oh no, you lost!\nDon't worry, there's always next time");
			}
			else if(top[2] < 1)
			{
				ShowSyncHudText(client[i], MainHud, buffer);
				Client[client[i]].Queue += 20;
			}
			else
			{
				ShowSyncHudText(client[i], MainHud, "%s\n \nYou dealt %d damage this round", buffer, Client[client[i]].Damage);
				Client[client[i]].Queue += 10;
			}
		}
	}
	else
	{
		Enabled = true;
	}

	CreateTimer(bonusRoundTime, OnRoundPre, _, TIMER_FLAG_NO_MAPCHANGE);
}

public Action WeHadToKeepThis(Handle timer)
{
	for(int client=1; client<=MaxClients; client++)
	{
		if(!IsClientInGame(client))
			continue;

		ClientCommand(client, "playgamesound saxton_hale/9000.wav");
		ClientCommand(client, "playgamesound saxton_hale/9000.wav");
	}
	return Plugin_Continue;
}

public void OnPlayerSpawn(Event event, const char[] name, bool dontBroadcast)
{
	if(!Enabled)
		return;

	int client = GetClientOfUserId(event.GetInt("userid"));
	if(!client || Hale[client].Enabled)
		return;

	SetVariantString("");
	AcceptEntityInput(client, "SetCustomModel");
	SetEntityGravity(client, 1.0);

	#if defined MODULE_MENU
	if(RoundMode!=0 || !IsVoteInProgress())
		Menu_InfoClass(client, view_as<int>(TF2_GetPlayerClass(client)));
	#endif
}

public void OnPlayerDeath(Event event, const char[] name, bool dontBroadcast)
{
	if(!Enabled || RoundMode!=1)
		return;

	RequestFrame(CheckAlivePlayers);

	int userid = event.GetInt("userid");
	int client = GetClientOfUserId(userid);
	if(!client)
		return;

	int attacker = GetClientOfUserId(event.GetInt("attacker"));
	if(Hale[client].Enabled)
	{
		if(Hale[client].PlayerDeath != INVALID_FUNCTION)
		{
			LogMessage("%d::PlayerDeath", client);
			Call_StartFunction(null, Hale[client].PlayerDeath);
			Call_PushCell(client);
			Call_PushCell(attacker);
			Call_Finish();
		}
	}
	else if(TF2_GetPlayerClass(client) == TFClass_Engineer)
	{
		static char classname[32];
		for(int entity=2047; entity>MaxClients; entity--)
		{
			if(IsValidEntity(entity))
			{
				GetEntityClassname(entity, classname, sizeof(classname));
				if(!StrContains(classname, "obj_sentrygun") && (GetEntPropEnt(entity, Prop_Send, "m_hBuilder")==client))
				{
					SetVariantInt(GetEntPropEnt(entity, Prop_Send, "m_iMaxHealth")+1);
					AcceptEntityInput(entity, "RemoveHealth");

					Event boom = CreateEvent("object_removed", true);
					boom.SetInt("userid", userid);
					boom.SetInt("index", entity);
					boom.Fire();
					AcceptEntityInput(entity, "kill");
				}
			}
		}
	}

	if(Hale[attacker].Enabled && Hale[attacker].PlayerKill!=INVALID_FUNCTION)
	{
		LogMessage("%d::PlayerKill", attacker);
		Call_StartFunction(null, Hale[attacker].PlayerKill);
		Call_PushCell(attacker);
		Call_PushCell(client);
		Call_Finish();
	}
}

public void OnClientDisconnect(int client)
{
	if(client && AreClientCookiesCached(client))
	{
		static char buffer[8];
		IntToString(Client[client].Queue, buffer, sizeof(buffer));
		Cookies.Set(client, buffer);
	}

	if(Enabled && RoundMode==1)
		RequestFrame(CheckAlivePlayers);
}

public Action OnPlayerHurt(Event event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(event.GetInt("userid"));
	if(!Hale[client].Enabled)
		return Plugin_Continue;

	int damage = event.GetInt("damageamount");
	int attacker = GetClientOfUserId(event.GetInt("attacker"));
	if(attacker>0 && attacker<=MaxClients)
	{
		Client[attacker].Damage += damage;
	}
	else if(damage > 999)
	{
		Hale[client].Rage += 500;
		Hale[client].Health -= 999;
		if(Hale[client].Health > 0)
			SetEntityHealth(client, Hale[client].Health);

		return Plugin_Continue;
	}

	Hale[client].Rage += damage;
	Hale[client].Health -= damage;
	return Plugin_Continue;
}

public Action OnObjectDeflected(Event event, const char[] name, bool dontBroadcast)
{
	if(!Enabled || event.GetInt("weaponid"))  // 0 means that the client was airblasted, which is what we want
		return Plugin_Continue;

	int client = GetClientOfUserId(event.GetInt("ownerid"));
	if(Hale[client].Enabled)
		Hale[client].Rage += 200;

	return Plugin_Continue;
}

public Action OnObjectDestroyed(Event event, const char[] name, bool dontBroadcast)
{
	if(!Enabled || RoundMode!=1)
		return Plugin_Continue;
	
	int client = GetClientOfUserId(event.GetInt("attacker"));
	if(!Hale[client].Enabled || Hale[client].MiscDestory==INVALID_FUNCTION)
		return Plugin_Continue;

	LogMessage("%d::MiscDestory", client);
	Call_StartFunction(null, Hale[client].MiscDestory);
	Call_PushCell(client);
	Call_Finish();
	return Plugin_Continue;
}

public Action OnWinPanel(Event event, const char[] name, bool dontBroadcast)
{
	return Enabled ? Plugin_Handled : Plugin_Continue;
}

public Action HookSound(int clients[MAXPLAYERS], int &numClients, char sound[PLATFORM_MAX_PATH], int &client, int &channel, float &volume, int &level, int &pitch, int &flags, char soundEntry[PLATFORM_MAX_PATH], int &seed)
{
	if(!Enabled || client<1 || client>MaxClients || !Hale[client].Enabled || Hale[client].PlayerSound==INVALID_FUNCTION)
		return Plugin_Continue;

	Call_StartFunction(null, Hale[client].PlayerSound);
	Call_PushArrayEx(clients, MAXPLAYERS, SM_PARAM_COPYBACK);
	Call_PushCellRef(numClients);
	Call_PushStringEx(sound, PLATFORM_MAX_PATH, SM_PARAM_STRING_UTF8, SM_PARAM_COPYBACK);
	Call_PushCellRef(client);
	Call_PushCellRef(channel);
	Call_PushFloatRef(volume);
	Call_PushCellRef(level);
	Call_PushCellRef(pitch);
	Call_PushCellRef(flags);
	Call_PushStringEx(soundEntry, PLATFORM_MAX_PATH, SM_PARAM_STRING_UTF8, SM_PARAM_COPYBACK);
	Call_PushCellRef(seed);

	Action action;
	Call_Finish(action);
	return action;
}

/*public void OnEntityCreated(int entity, const char[] classname)
{
	if(StrContains(classname, "item_healthkit")!=-1 || StrContains(classname, "item_ammopack")!=-1 || StrEqual(classname, "tf_ammo_pack"))
		SDKHook(entity, SDKHook_Spawn, OnItemSpawned);
}*/

public void TF2_OnConditionRemoved(int client, TFCond cond)
{
	if(cond == TFCond_Taunting)
		TF2_AddCondition(client, TFCond_CritCanteen, 4.0);
}

public Action OnPlayerRunCmd(int client, int &buttons)
{
	if(!Enabled || RoundMode!=1)
		return Plugin_Continue;

	float engineTime = GetEngineTime();
	bool alive = IsPlayerAlive(client);
	if(alive)
		SetEntProp(client, Prop_Send, "m_bGlowEnabled", (AlivePlayers==1 || Client[client].GlowFor>engineTime) ? 1 : 0);

	if(Client[client].ThemeAt < engineTime)
	{
		if(Hale[LeaderHale].MiscTheme == INVALID_FUNCTION)
		{
			Client[client].ThemeAt = FAR_FUTURE;
		}
		else
		{
			Call_StartFunction(null, Hale[LeaderHale].MiscTheme);
			Call_PushCell(client);
			Call_Finish();
			if(!Client[client].Theme[0])
			{
				Client[client].ThemeAt = FAR_FUTURE;
			}
			else
			{
				if(Client[client].ThemeAt < engineTime)
					Client[client].ThemeAt = FAR_FUTURE;

				EmitSoundToClient(client, Client[client].Theme, _, SNDCHAN_STATIC);
			}
		}
	}

	if(Hale[client].Enabled && Hale[client].PlayerCommand!=INVALID_FUNCTION)
	{
		Call_StartFunction(null, Hale[client].PlayerCommand);
		Call_PushCell(client);
		Call_PushCellRef(buttons);

		Action action;
		Call_Finish(action);
		return action;
	}

	if(Client[client].StunFor)
	{
		if(alive && Client[client].StunFor>engineTime)
		{
			SetEntPropEnt(client, Prop_Send, "m_hActiveWeapon", -1);
			SetEntPropFloat(client, Prop_Send, "m_flNextAttack", FAR_FUTURE);
			switch(TF2_GetPlayerClass(client))	// Base HU ^ 0.95
			{
				case TFClass_Scout:
					SetEntPropFloat(client, Prop_Send, "m_flMaxspeed", 296.45378);

				case TFClass_Soldier:
					SetEntPropFloat(client, Prop_Send, "m_flMaxspeed", 182.473869);

				case TFClass_DemoMan, TFClass_Civilian:
					SetEntPropFloat(client, Prop_Send, "m_flMaxspeed", 211.25166);

				case TFClass_Heavy:
					SetEntPropFloat(client, Prop_Send, "m_flMaxspeed", 175.243309);

				case TFClass_Medic:
					SetEntPropFloat(client, Prop_Send, "m_flMaxspeed", 239.82391);

				default:
					SetEntPropFloat(client, Prop_Send, "m_flMaxspeed", 225.561613);
			}
			return Plugin_Continue;
		}

		Client[client].StunFor = 0.0;
		if(alive)
		{
			SetEntPropEnt(client, Prop_Send, "m_hActiveWeapon", Client[client].LastWeapon);
			SetEntPropFloat(client, Prop_Send, "m_flNextAttack", 0.0);
		}
	}

	if(!(buttons & IN_SCORE) && Client[client].HudAt<engineTime && (alive || IsClientObserver(client)))
	{
		SetHudTextParams(-1.0, 0.83, HUD_INTERVAL+HUD_LINGER, 90, 255, 255, 255, 0, 0.35, 0.0, 0.1);
		ShowSyncHudText(client, MainHud, "%s: %d HP", Hale[LeaderHale].Name, Hale[LeaderHale].Health);
		Client[client].HudAt = engineTime+HUD_INTERVAL;

		int target;
		if(alive)
		{
			target = GetClientAimTarget(client, true);
			if(target<1 || target==client || GetClientTeam(client)!=GetClientTeam(target))
			{
				target = 0;
			}
			else
			{
				static float position[3], position2[3];
				GetEntPropVector(client, Prop_Send, "m_vecOrigin", position);
				GetEntPropVector(target, Prop_Send, "m_vecOrigin", position2);
				if(GetVectorDistance(position, position2) > 600)
					target = 0;
			}
		}
		else
		{
			target = GetEntPropEnt(client, Prop_Send, "m_hObserverTarget");
			if(target<1 || target>MaxClients || target==client || Hale[target].Enabled)
				target = 0;
		}

		SetHudTextParams(-1.0, 0.88, HUD_INTERVAL+HUD_LINGER, 90, 255, 90, 255, 0, 0.35, 0.0, 0.1);
		if(target)
		{
			ShowSyncHudText(client, PlayerHud, "Damage: %d | %N's Damage: %d", Client[client].Damage, target, Client[target].Damage);
		}
		else
		{
			ShowSyncHudText(client, PlayerHud, "Damage: %d", Client[client].Damage);
		}
	}

	if(alive)
	{
		if(AlivePlayers == 1)
		{
			TF2_AddCondition(client, TFCond_HalloweenCritCandy, 0.08);
			return Plugin_Continue;
		}

		if(TF2_IsPlayerInCondition(client, TFCond_Ubercharged))
		{
			TF2_AddCondition(client, TFCond_HalloweenCritCandy, 0.08);
			return Plugin_Continue;
		}

		int index = -1;
		int weapon = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
		if(weapon>MaxClients && IsValidEntity(weapon) && HasEntProp(weapon, Prop_Send, "m_iItemDefinitionIndex"))
			index = GetEntProp(weapon, Prop_Send, "m_iItemDefinitionIndex");

		switch(index)
		{
			case 0, 1, 2, 3, 5, 6, 7, 8, 32, 37, 3003, 3005, 3008:
				TF2_AddCondition(client, TFCond_HalloweenCritCandy, 0.08);
		}
	}
	return Plugin_Continue;
}

public Action OnTakeDamage(int client, int &attacker, int &inflictor, float &damage, int &damagetype, int &weapon, float damageForce[3], float damagePosition[3], int damagecustom)
{
	if(!Enabled || !IsValidEntity(attacker))
		return Plugin_Continue;

	bool changed;
	if(Hale[client].Enabled && Hale[client].PlayerTakeDamage!=INVALID_FUNCTION)
	{
		Call_StartFunction(null, Hale[client].PlayerTakeDamage);
		Call_PushCell(client);
		Call_PushCellRef(attacker);
		Call_PushCellRef(inflictor);
		Call_PushFloatRef(damage);
		Call_PushCellRef(damagetype);
		Call_PushCellRef(weapon);
		Call_PushArrayEx(damageForce, 3, SM_PARAM_COPYBACK);
		Call_PushArrayEx(damagePosition, 3, SM_PARAM_COPYBACK);
		Call_PushCell(damagecustom);

		Action action;
		Call_Finish(action);
		if(action >= Plugin_Handled)
			return action;

		changed = action!=Plugin_Continue;
	}

	if((damagetype & DMG_FALL) && (attacker<1 || client==attacker))
	{
		int boots = GetPlayerWeaponSlot(client, TFWeaponSlot_Primary);
		if(boots>MaxClients && IsValidEntity(boots) && HasEntProp(boots, Prop_Send, "m_iItemDefinitionIndex") && GetEntProp(boots, Prop_Send, "m_iItemDefinitionIndex")==133)
		{
			damage /= 5.0;
			return Plugin_Changed;
		}

		boots = GetPlayerWeaponSlot(client, TFWeaponSlot_Secondary);
		if(boots>MaxClients && IsValidEntity(boots) && HasEntProp(boots, Prop_Send, "m_iItemDefinitionIndex") && GetEntProp(boots, Prop_Send, "m_iItemDefinitionIndex")==133)
		{
			damage /= 5.0;
			return Plugin_Changed;
		}
	}
	else if((damagetype & DMG_CRIT) && TF2_IsPlayerInCondition(client, TFCond_Kritzkrieged))
	{
		damagetype &= ~DMG_CRIT;
		changed = true;
	}

	if(Hale[attacker].Enabled && Hale[attacker].PlayerDealDamage!=INVALID_FUNCTION)
	{
		Call_StartFunction(null, Hale[attacker].PlayerDealDamage);
		Call_PushCell(attacker);
		Call_PushCell(client);
		Call_PushCellRef(inflictor);
		Call_PushFloatRef(damage);
		Call_PushCellRef(damagetype);
		Call_PushCellRef(weapon);
		Call_PushArrayEx(damageForce, 3, SM_PARAM_COPYBACK);
		Call_PushArrayEx(damagePosition, 3, SM_PARAM_COPYBACK);
		Call_PushCell(damagecustom);

		Action action;
		Call_Finish(action);
		if(action != Plugin_Continue)
			return action;
	}
	return changed ? Plugin_Changed : Plugin_Continue;
}

public Action OnRoundPre(Handle timer)
{
	for(int i; i<=MAXPLAYERS; i++)
	{
		Hale[i].Enabled = false;
		Hale[i].Health = 200;
		Hale[i].MaxHealth = 200;
		Hale[i].Rage = 0;
		Client[i].GlowFor = 0.0;
	}

	int[] client = new int[MaxClients];
	int hale, points, clients;
	for(int i=1; i<=MaxClients; i++)
	{
		if(!IsClientInGame(i) || GetClientTeam(i)<=view_as<int>(TFTeam_Spectator))
			continue;

		client[clients++] = i;
		if(Client[i].Queue < points)
			continue;

		hale = i;
		points = Client[i].Queue;
	}

	if(!hale)
	{
		Enabled = false;
		return Plugin_Continue;
	}

	LeaderHale = hale;
	SetupHale(hale);
	Hale[hale].Enabled = true;
	ChangeClientTeam(hale, BossTeam);

	int[][] class = new int[11][clients];
	int classes[11];
	for(int i; i<clients; i++)
	{
		if(client[i] == hale)
			continue;

		ChangeClientTeam(client[i], MercTeam);
		int current = GetEntProp(client[i], Prop_Send, "m_iDesiredPlayerClass");
		if(current == view_as<int>(TFClass_Unknown))
			SetEntProp(client[i], Prop_Send, "m_iDesiredPlayerClass", view_as<int>(DEFAULTCLASS));

		if(current < 11)
			class[current][classes[current]++] = client[i];
	}

	for(int i; i<11; i++)
	{
		if(ClassLimit[i]<1 || !classes[i])
			continue;

		int limit = ClassLimit[i];
		if(clients > 32)
			limit += RoundToCeil(ClassLimit[i]*((clients-32.0)/32.0));

		while(classes[i] > limit)
		{
			hale = 0;
			points = 0;
			for(int a; a<classes[i]; a++)
			{
				if(!class[i][a] || (points && Client[class[i][a]].Damage>points))
					continue;

				hale = a;
				points = Client[class[i][a]].Damage;
			}

			if(!hale)
				break;

			PrintCenterText(class[i][hale], "Your class was changed because of class limits!");
			SetEntProp(class[i][hale], Prop_Send, "m_iDesiredPlayerClass", view_as<int>(DEFAULTCLASS));
			class[i][hale] = 0;
			limit--;
		}
	}

	for(int i; i<=MAXPLAYERS; i++)
	{
		Client[i].Damage = 0;
	}
	return Plugin_Continue;
}

public void CheckAlivePlayers()
{
	bool last = AlivePlayers==1;

	int players;
	AlivePlayers = 0;
	for(int i=1; i<=MaxClients; i++)
	{
		if(!IsClientInGame(i) || GetClientTeam(i)!=MercTeam)
			continue;

		players++;
		if(IsPlayerAlive(i))
			AlivePlayers++;
	}

	if(!Enabled || RoundMode!=1)
		return;

	if(players > 32)
	{
		players = 4+((players-32)/8);
	}
	else
	{
		players = 4;
	}

	if(AlivePlayers < players)
		SetControlPoint(true);

	if(last || AlivePlayers!=1 || Hale[LeaderHale].RoundLastman==INVALID_FUNCTION)
		return;

	LogMessage("%d::RoundLastman", LeaderHale);
	Call_StartFunction(null, Hale[LeaderHale].RoundLastman);
	Call_Finish();
}

/*public void OnItemSpawned(int entity)
{
	SDKHook(entity, SDKHook_StartTouch, OnPickup);
	SDKHook(entity, SDKHook_Touch, OnPickup);
}

public Action OnPickup(int entity, int client)
{
	if(Enabled && client>0 && client<=MaxClients && Hale[client].Enabled)
		return Plugin_Handled;

	return Plugin_Continue;
}*/

public int EmptyMenuH(Menu menu, MenuAction action, int client, int selection)
{
	if(action == MenuAction_End)
		delete menu;
}

stock void SetControlPoint(bool enable)
{
	int controlPoint = MaxClients+1;
	while((controlPoint=FindEntityByClassname(controlPoint, "team_control_point"))!=-1)
	{
		if(controlPoint>MaxClients && IsValidEntity(controlPoint))
		{
			AcceptEntityInput(controlPoint, (enable ? "ShowModel" : "HideModel"));
			SetVariantInt(enable ? 0 : 1);
			AcceptEntityInput(controlPoint, "SetLocked");
		}
	}
}

stock void SetArenaCapEnableTime(float time)
{
	int entity = -1;
	if((entity=FindEntityByClassname(-1, "tf_logic_arena"))!=-1 && IsValidEntity(entity))
	{
		static char timeString[32];
		FloatToString(time, timeString, sizeof(timeString));
		DispatchKeyValue(entity, "CapEnableDelay", timeString);
	}
}

stock float fmin(float n1, float n2)
{
	return n1 < n2 ? n1 : n2;
}

stock TFClassType GetClassFromName(const char[] classname)
{
	if(StrEqual(classname, "scout", false))
	{
		return TFClass_Scout;
	}
	else if(StrEqual(classname, "sniper", false))
	{
		return TFClass_Sniper;
	}
	else if(StrEqual(classname, "soldier", false))
	{
		return TFClass_Sniper;
	}
	else if(StrEqual(classname, "demoman", false))
	{
		return TFClass_DemoMan;
	}
	else if(StrEqual(classname, "medic", false))
	{
		return TFClass_Medic;
	}
	else if(StrEqual(classname, "heavyweapons", false))
	{
		return TFClass_Heavy;
	}
	else if(StrEqual(classname, "pyro", false))
	{
		return TFClass_Pyro;
	}
	else if(StrEqual(classname, "spy", false))
	{
		return TFClass_Spy;
	}
	else if(StrEqual(classname, "engineer", false))
	{
		return TFClass_Engineer;
	}
	else if(StrEqual(classname, "cilvilian", false))
	{
		return TFClass_Civilian;
	}
	return TFClass_Unknown;
}

/*
	Setup Hale Files Here
*/

#include "cvsh/default.sp"
#include "cvsh/hale.sp"
#tryinclude "cvsh/vagineer.sp"
#tryinclude "cvsh/cbs.sp"

public void OnMapStart()
{
	Hale_MapStart();

	#if defined BOSS_VAG
	Vag_MapStart();
	#endif

	#if defined BOSS_CBS
	CBS_MapStart();
	#endif
}

void SetupHale(int i)
{
	Hale[i].RoundIntro = INVALID_FUNCTION;
	Hale[i].RoundStart = INVALID_FUNCTION;
	Hale[i].RoundLastman = INVALID_FUNCTION;
	Hale[i].RoundEnd = INVALID_FUNCTION;
	Hale[i].RoundWin = INVALID_FUNCTION;

	Hale[i].PlayerSpawn = INVALID_FUNCTION;
	Hale[i].PlayerSound = INVALID_FUNCTION;
	Hale[i].PlayerVoice = INVALID_FUNCTION;
	Hale[i].PlayerCommand = INVALID_FUNCTION;

	Hale[i].PlayerKill = INVALID_FUNCTION;
	Hale[i].PlayerDeath = INVALID_FUNCTION;

	Hale[i].PlayerTakeDamage = INVALID_FUNCTION;
	Hale[i].PlayerDealDamage = INVALID_FUNCTION;

	Hale[i].MiscDestory = INVALID_FUNCTION;
	Hale[i].MiscTheme = INVALID_FUNCTION;
	Hale[i].MiscDesc = INVALID_FUNCTION;

	switch(GetRandomInt(0, 14))
	{
		#if defined BOSS_VAG
		case 1:
			Vag_Setup(i);
		#endif

		#if defined BOSS_CBS
		case 2:
			CBS_Setup(i);
		#endif

		default:
			Hale_Setup(i);
	}
}