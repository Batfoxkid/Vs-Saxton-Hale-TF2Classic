#define BOSS_HALE	0

#define HALEMODEL	"models/player/saxton_hale_jungle_inferno/saxton_hale.mdl"
#define HALECLASS	TFClass_Soldier
#define HALERAGEDAMAGE	2800

static const char HaleDownload[][] =
{
	"materials/models/player/hwm_saxton_hale/saxton_belt.vmt",
	"materials/models/player/hwm_saxton_hale/saxton_belt_high.vmt",
	"materials/models/player/hwm_saxton_hale/saxton_belt_high.vtf",
	"materials/models/player/hwm_saxton_hale/saxton_belt_high_normal.vtf",
	"materials/models/player/hwm_saxton_hale/saxton_body.vmt",
	"materials/models/player/hwm_saxton_hale/saxton_body.vtf",
	"materials/models/player/hwm_saxton_hale/saxton_body_alt.vmt",
	"materials/models/player/hwm_saxton_hale/saxton_body_exp.vtf",
	"materials/models/player/hwm_saxton_hale/saxton_body_normal.vtf",
	"materials/models/player/hwm_saxton_hale/saxton_body_saxxy.vmt",
	"materials/models/player/hwm_saxton_hale/saxton_body_saxxy.vtf",
	"materials/models/player/hwm_saxton_hale/saxton_hat_color.vmt",
	"materials/models/player/hwm_saxton_hale/saxton_hat_color.vtf",
	"materials/models/player/hwm_saxton_hale/saxton_hat_saxxy.vmt",
	"materials/models/player/hwm_saxton_hale/saxton_hat_saxxy.vtf",
	"materials/models/player/hwm_saxton_hale/tongue_saxxy.vmt",
	"materials/models/player/hwm_saxton_hale/hwm/saxton_head.vmt",
	"materials/models/player/hwm_saxton_hale/hwm/saxton_head.vtf",
	"materials/models/player/hwm_saxton_hale/hwm/saxton_head_exponent.vtf",
	"materials/models/player/hwm_saxton_hale/hwm/saxton_head_normal.vtf",
	"materials/models/player/hwm_saxton_hale/hwm/saxton_head_saxxy.vmt",
	"materials/models/player/hwm_saxton_hale/hwm/saxton_head_saxxy.vtf",
	"materials/models/player/hwm_saxton_hale/hwm/tongue.vmt",
	"materials/models/player/hwm_saxton_hale/hwm/tongue.vtf",
	"materials/models/player/hwm_saxton_hale/shades/eye.vtf",
	"materials/models/player/hwm_saxton_hale/shades/eyeball_l.vmt",
	"materials/models/player/hwm_saxton_hale/shades/eyeball_r.vmt",
	"materials/models/player/hwm_saxton_hale/shades/eyeball_saxxy.vmt",
	"materials/models/player/hwm_saxton_hale/shades/eye-extra.vtf",
	"materials/models/player/hwm_saxton_hale/shades/eye-saxxy.vtf",
	"materials/models/player/hwm_saxton_hale/shades/inv.vmt",
	"materials/models/player/hwm_saxton_hale/shades/null.vtf",

	"models/player/saxton_hale_jungle_inferno/saxton_hale.dx80.vtx",
	"models/player/saxton_hale_jungle_inferno/saxton_hale.dx90.vtx",
	"models/player/saxton_hale_jungle_inferno/saxton_hale.mdl",
	"models/player/saxton_hale_jungle_inferno/saxton_hale.phy",
	"models/player/saxton_hale_jungle_inferno/saxton_hale.sw.vtx",
	"models/player/saxton_hale_jungle_inferno/saxton_hale.vvd",

	"sound/saxton_hale/9000.wav",
	"sound/saxton_hale/saxton_hale_responce_start1.wav",
	"sound/saxton_hale/saxton_hale_responce_start2.wav",
	"sound/saxton_hale/saxton_hale_responce_start3.wav",
	"sound/saxton_hale/saxton_hale_responce_start4.wav",
	"sound/saxton_hale/saxton_hale_responce_start5.wav",
	"sound/saxton_hale/saxton_hale_132_start_1.wav",
	"sound/saxton_hale/saxton_hale_132_start_2.wav",
	"sound/saxton_hale/saxton_hale_132_start_3.wav",
	"sound/saxton_hale/saxton_hale_132_start_4.wav",
	"sound/saxton_hale/saxton_hale_132_start_5.wav",
	"sound/saxton_hale/saxton_hale_responce_rage1.wav",
	"sound/saxton_hale/saxton_hale_responce_rage2.wav",
	"sound/saxton_hale/saxton_hale_responce_rage3.wav",
	"sound/saxton_hale/saxton_hale_responce_rage4.wav",
	"sound/saxton_hale/saxton_hale_132_jump_1.wav",
	"sound/saxton_hale/saxton_hale_132_jump_2.wav",
	"sound/saxton_hale/saxton_hale_responce_jump1.wav",
	"sound/saxton_hale/saxton_hale_responce_jump2.wav",
	"sound/saxton_hale/saxton_hale_responce_win1.wav",
	"sound/saxton_hale/saxton_hale_responce_win2.wav",
	"sound/saxton_hale/saxton_hale_responce_fail1.wav",
	"sound/saxton_hale/saxton_hale_responce_fail2.wav",
	"sound/saxton_hale/saxton_hale_responce_fail3.wav",
	"sound/saxton_hale/saxton_hale_132_last.wav",
	"sound/saxton_hale/saxton_hale_responce_2.wav",
	"sound/saxton_hale/saxton_hale_responce_lastman1.wav",
	"sound/saxton_hale/saxton_hale_responce_lastman2.wav",
	"sound/saxton_hale/saxton_hale_responce_lastman3.wav",
	"sound/saxton_hale/saxton_hale_responce_lastman4.wav",
	"sound/saxton_hale/saxton_hale_responce_lastman5.wav",
	"sound/saxton_hale/saxton_hale_132_kill_scout.wav",
	"sound/saxton_hale/saxton_hale_132_kill_w_and_m1.wav",
	"sound/saxton_hale/saxton_hale_132_kill_demo.wav",
	"sound/saxton_hale/saxton_hale_132_kill_heavy.wav",
	"sound/saxton_hale/saxton_hale_132_kill_engie_1.wav",
	"sound/saxton_hale/saxton_hale_132_kill_engie_2.wav",
	"sound/saxton_hale/saxton_hale_responce_kill_eggineer1.wav",
	"sound/saxton_hale/saxton_hale_responce_kill_eggineer2.wav",
	"sound/saxton_hale/saxton_hale_responce_kill_medic.wav",
	"sound/saxton_hale/saxton_hale_132_kill_toy.wav",
	"sound/saxton_hale/saxton_hale_responce_kill_medic.wav",
	"sound/saxton_hale/saxton_hale_responce_kill_sniper1.wav",
	"sound/saxton_hale/saxton_hale_responce_kill_sniper2.wav",
	"sound/saxton_hale/saxton_hale_132_kill_spie.wav",
	"sound/saxton_hale/saxton_hale_responce_kill_spy1.wav",
	"sound/saxton_hale/saxton_hale_responce_kill_spy2.wav",
	"sound/saxton_hale/saxton_hale_132_kill_toy.wav",
	"sound/saxton_hale/saxton_hale_responce_spree1.wav",
	"sound/saxton_hale/saxton_hale_responce_spree2.wav",
	"sound/saxton_hale/saxton_hale_responce_spree3.wav",
	"sound/saxton_hale/saxton_hale_responce_spree4.wav",
	"sound/saxton_hale/saxton_hale_responce_spree5.wav",
	"sound/saxton_hale/saxton_hale_responce_3.wav",
	"sound/saxton_hale/saxton_hale_132_kspree_1.wav",
	"sound/saxton_hale/saxton_hale_132_kspree_2.wav",
	"sound/saxton_hale/saxton_hale_132_stub_1.wav",
	"sound/saxton_hale/saxton_hale_132_stub_2.wav",
	"sound/saxton_hale/saxton_hale_132_stub_3.wav",
	"sound/saxton_hale/saxton_hale_132_stub_4.wav"
};

static const char HaleIntro[][] =
{
	"saxton_hale/saxton_hale_responce_start1.wav",
	"saxton_hale/saxton_hale_responce_start2.wav",
	"saxton_hale/saxton_hale_responce_start3.wav",
	"saxton_hale/saxton_hale_responce_start4.wav",
	"saxton_hale/saxton_hale_responce_start5.wav",
	"saxton_hale/saxton_hale_132_start_1.wav",
	"saxton_hale/saxton_hale_132_start_2.wav",
	"saxton_hale/saxton_hale_132_start_3.wav",
	"saxton_hale/saxton_hale_132_start_4.wav",
	"saxton_hale/saxton_hale_132_start_5.wav"
};

static const char HaleRage[][] =
{
	"saxton_hale/saxton_hale_responce_rage1.wav",
	"saxton_hale/saxton_hale_responce_rage2.wav",
	"saxton_hale/saxton_hale_responce_rage3.wav",
	"saxton_hale/saxton_hale_responce_rage4.wav"
};

static const char HaleJump[][] =
{
	"saxton_hale/saxton_hale_132_jump_1.wav",
	"saxton_hale/saxton_hale_132_jump_2.wav",
	"saxton_hale/saxton_hale_responce_jump1.wav",
	"saxton_hale/saxton_hale_responce_jump2.wav"
};

static const char HaleWin[][] =
{
	"saxton_hale/saxton_hale_responce_win1.wav",
	"saxton_hale/saxton_hale_responce_win2.wav"
};

static const char HaleDeath[][] =
{
	"saxton_hale/saxton_hale_responce_fail1.wav",
	"saxton_hale/saxton_hale_responce_fail2.wav",
	"saxton_hale/saxton_hale_responce_fail3.wav"
};

static const char HaleLast[][] =
{
	"saxton_hale/saxton_hale_132_last.wav",
	"saxton_hale/saxton_hale_responce_2.wav",
	"saxton_hale/saxton_hale_responce_lastman1.wav",
	"saxton_hale/saxton_hale_responce_lastman2.wav",
	"saxton_hale/saxton_hale_responce_lastman3.wav",
	"saxton_hale/saxton_hale_responce_lastman4.wav",
	"saxton_hale/saxton_hale_responce_lastman5.wav"
};

#define HALEKILLSCOUT	"saxton_hale/saxton_hale_132_kill_scout.wav"
#define HALEKILLSOLDIER	"saxton_hale/saxton_hale_responce_spree3.wav"
#define HALEKILLPYRO	"saxton_hale/saxton_hale_132_kill_w_and_m1.wav"
#define HALEKILLDEMO	"saxton_hale/saxton_hale_132_kill_demo.wav"
#define HALEKILLHEAVY	"saxton_hale/saxton_hale_132_kill_heavy.wav"
#define HALEKILLMEDIC	"saxton_hale/saxton_hale_responce_kill_medic.wav"
#define HALEKILLCIVIL	"saxton_hale/saxton_hale_132_kspree_1.wav"
#define HALEKILLBUILD	"saxton_hale/saxton_hale_132_kill_toy.wav"

static const char HaleKillEngi[][] =
{
	"saxton_hale/saxton_hale_132_kill_engie_1.wav",
	"saxton_hale/saxton_hale_132_kill_engie_2.wav",
	"saxton_hale/saxton_hale_responce_kill_eggineer1.wav",
	"saxton_hale/saxton_hale_responce_kill_eggineer2.wav"
};

static const char HaleKillSniper[][] =
{
	"saxton_hale/saxton_hale_responce_kill_sniper1.wav",
	"saxton_hale/saxton_hale_responce_kill_sniper2.wav"
};

static const char HaleKillSpy[][] =
{
	"saxton_hale/saxton_hale_132_kill_spie.wav",
	"saxton_hale/saxton_hale_responce_kill_spy1.wav",
	"saxton_hale/saxton_hale_responce_kill_spy2.wav"
};

static const char HaleKspree[][] =
{
	"saxton_hale/saxton_hale_responce_spree1.wav",
	"saxton_hale/saxton_hale_responce_spree2.wav",
	"saxton_hale/saxton_hale_responce_spree4.wav",
	"saxton_hale/saxton_hale_responce_spree5.wav",
	"saxton_hale/saxton_hale_responce_3.wav",
	"saxton_hale/saxton_hale_132_kspree_2.wav"
};

static const char HaleStab[][] =
{
	"saxton_hale/saxton_hale_132_stub_1.wav",
	"saxton_hale/saxton_hale_132_stub_2.wav",
	"saxton_hale/saxton_hale_132_stub_3.wav",
	"saxton_hale/saxton_hale_132_stub_4.wav"
};

void Hale_Precache(Function &func)
{
	func = Hale_Info;

	PrecacheModel(HALEMODEL, true);
	PrecacheSound(HALEKILLSCOUT, true);
	PrecacheSound(HALEKILLSOLDIER, true);
	PrecacheSound(HALEKILLPYRO, true);
	PrecacheSound(HALEKILLDEMO, true);
	PrecacheSound(HALEKILLHEAVY, true);
	PrecacheSound(HALEKILLMEDIC, true);
	PrecacheSound(HALEKILLCIVIL, true);
	PrecacheSound(HALEKILLBUILD, true);

	for(int i; i<sizeof(HaleRage); i++)
	{
		PrecacheSound(HaleRage[i], true);
	}

	for(int i; i<sizeof(HaleJump); i++)
	{
		PrecacheSound(HaleJump[i], true);
	}

	for(int i; i<sizeof(HaleKillEngi); i++)
	{
		PrecacheSound(HaleKillEngi[i], true);
	}

	for(int i; i<sizeof(HaleKillSniper); i++)
	{
		PrecacheSound(HaleKillSniper[i], true);
	}

	for(int i; i<sizeof(HaleKillSpy); i++)
	{
		PrecacheSound(HaleKillSpy[i], true);
	}

	for(int i; i<sizeof(HaleStab); i++)
	{
		PrecacheSound(HaleStab[i], true);
	}

	int table = FindStringTable("downloadables");
	bool save = LockStringTables(false);
	for(int i; i<sizeof(HaleDownload); i++)
	{
		if(!FileExists(HaleDownload[i], true))
		{
			LogError("Missing file: '%s'", HaleDownload[i]);
			continue;
		}

		AddToStringTable(table, HaleDownload[i]);
	}
	LockStringTables(save);
}

public void Hale_Info(int client, char[] name, char[] desc, bool setup)
{
	strcopy(name, 64, "Saxton Hale");
	if(setup)
	{
		Hale[client].RoundIntro = Hale_Intro;
		Hale[client].RoundStart = Hale_RoundStart;
		Hale[client].RoundLastman = Hale_Lastman;
		Hale[client].RoundWin = Hale_Win;

		Hale[client].PlayerSpawn = Hale_Spawn;
		Hale[client].PlayerSound = Default_Sound;
		Hale[client].PlayerVoice = Hale_OnRage;
		Hale[client].PlayerCommand = Hale_Think;

		Hale[client].PlayerKill = Hale_Kill;
		Hale[client].PlayerDeath = Hale_Death;

		Hale[client].PlayerTakeDamage = Hale_TakeDamage;

		Hale[client].MiscDestory = Hale_Destory;
		Hale[client].MiscDesc = Hale_Desc;

		TF2_SetPlayerClass(client, HALECLASS);
	}
	else
	{
		strcopy(desc, 512, "Saxton Hale\nBrave Jump: 6 sec cooldown, x1.0 height, x1.0 distance\nWeighdown: 3 sec cooldown, x6.0 gravity\nAnchor: unlimited use\n \nRage: 2800 damage\nPlayer Stun: 5 seconds, x1.0 range\nSentry Stun: 7 seconds\n ");
	}
}

public void Hale_RoundStart(int client)
{
	TF2_SetPlayerClass(client, HALECLASS);
	Hale_Spawn(client);
}

public Action Hale_OnRage(int client)
{
	if(!IsPlayerAlive(client) || Hale[client].Rage<HALERAGEDAMAGE)
		return Plugin_Continue;

	char arg1[4], arg2[4];
	GetCmdArg(1, arg1, sizeof(arg1));
	GetCmdArg(2, arg2, sizeof(arg2));
	if(StringToInt(arg1) || StringToInt(arg2))
		return Plugin_Continue;

	Hale[client].Rage = 0;

	static float position[3];
	GetEntPropVector(client, Prop_Send, "m_vecOrigin", position);

	float engineTime = GetEngineTime()+5.0;
	Hale[client].RageFor = engineTime+2.0;

	int team = GetClientTeam(client);
	bool friendlyFire = GetConVarBool(FindConVar("mp_friendlyfire"));
	int sound = GetRandomInt(0, sizeof(HaleRage)-1);
	if(!Client[client].NoVoice)
		ClientCommand(client, "playgamesound %s", HaleRage[sound]);

	for(int target=1; target<=MaxClients; target++)
	{
		if(target==client || !IsClientInGame(target))
			continue;

		if(!Client[target].NoVoice)
		{
			EmitSoundToClient(target, HaleRage[sound], client, _, SNDLEVEL_TRAFFIC, _, _, _, client, position);
			EmitSoundToClient(target, HaleRage[sound], client, _, SNDLEVEL_TRAFFIC, _, _, _, client, position);
			EmitSoundToClient(target, HaleRage[sound], client, _, SNDLEVEL_TRAFFIC, _, _, _, client, position);
		}

		if(!IsPlayerAlive(target) || TF2_IsPlayerInCondition(target, TFCond_Ubercharged) || (!friendlyFire && GetClientTeam(target)==team))
			continue;

		static float position2[3];
		GetEntPropVector(target, Prop_Send, "m_vecOrigin", position2);
		if(GetVectorDistance(position, position2) > 800)
			continue;

		Client[target].LastWeapon = GetEntPropEnt(target, Prop_Send, "m_hActiveWeapon");
		Client[target].StunFor = engineTime;
	}

	/*int sentry;
	while((sentry=FindEntityByClassname(sentry, "obj_sentrygun")) != -1)
	{
		if((friendlyFire || (GetEntProp(sentry, Prop_Send, "m_nSkin") % 2)!=(team % 2)) && !GetEntProp(sentry, Prop_Send, "m_bCarried") && !GetEntProp(sentry, Prop_Send, "m_bPlacing"))
		{
			GetEntPropVector(sentry, Prop_Send, "m_vecOrigin", position2);
			if(GetVectorDistance(position, position2) < 999)
			{
				SetEntProp(sentry, Prop_Send, "m_bDisabled", 1);
				CreateTimer(7.0, Timer_EnableBuilding, EntIndexToEntRef(sentry), TIMER_FLAG_NO_MAPCHANGE);
			}
		}
	}*/
	return Plugin_Handled;
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

public void Hale_Intro()
{
	int sound = GetRandomInt(0, sizeof(HaleIntro)-1);
	for(int i=1; i<=MaxClients; i++)
	{
		if(!IsClientInGame(i) || Client[i].NoVoice)
			continue;

		ClientCommand(i, "playgamesound \"%s\"", HaleIntro[sound]);
		ClientCommand(i, "playgamesound \"%s\"", HaleIntro[sound]);
	}
}

public void Hale_Spawn(int client)
{
	SetVariantString(HALEMODEL);
	AcceptEntityInput(client, "SetCustomModel");
	SetEntProp(client, Prop_Send, "m_bUseClassAnimations", 1);

	for(int i; i<6; i++)
	{
		if(i != TFWeaponSlot_Melee)
			TF2_RemoveWeaponSlot(client, i);
	}

	TF2_AddCondition(client, TFCond_RestrictToMelee);

	int weapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Melee);
	if(weapon<=MaxClients || !IsValidEntity(weapon))
		return;

	SetEntityRenderMode(weapon, RENDER_TRANSCOLOR);
	SetEntityRenderColor(weapon, 255, 255, 255, 0);
}

public Action Hale_Kill(int attacker, int client, char[] logname, char[] iconname)
{
	strcopy(logname, 32, "fists");
	strcopy(iconname, 32, "fists");
	if(AlivePlayers < 3)
		return Plugin_Changed;

	float engineTime = GetEngineTime();
	if(Hale[attacker].SpreeFor > engineTime)
	{
		Hale[attacker].SpreeFor = engineTime+4.0;
		if(!Hale[attacker].SpreeNext)
		{
			Hale[attacker].SpreeNext = true;
			return Plugin_Changed;
		}

		Hale[attacker].SpreeFor = 0.0;
		int sound = GetRandomInt(0, sizeof(HaleKspree)-1);
		for(int i=1; i<=MaxClients; i++)
		{
			if(!IsClientInGame(i) || Client[i].NoVoice)
				continue;

			ClientCommand(i, "playgamesound \"%s\"", HaleKspree[sound]);
			ClientCommand(i, "playgamesound \"%s\"", HaleKspree[sound]);
		}
		return Plugin_Changed;
	}

	Hale[attacker].SpreeNext = false;
	Hale[attacker].SpreeFor = engineTime+4.0;

	static char buffer[128];
	switch(TF2_GetPlayerClass(client))
	{
		case TFClass_Scout:
			strcopy(buffer, sizeof(buffer), HALEKILLSCOUT);

		case TFClass_Soldier:
			strcopy(buffer, sizeof(buffer), HALEKILLSOLDIER);

		case TFClass_Pyro:
			strcopy(buffer, sizeof(buffer), HALEKILLPYRO);

		case TFClass_DemoMan:
			strcopy(buffer, sizeof(buffer), HALEKILLDEMO);

		case TFClass_Heavy:
			strcopy(buffer, sizeof(buffer), HALEKILLHEAVY);

		case TFClass_Engineer:
			strcopy(buffer, sizeof(buffer), HaleKillEngi[GetRandomInt(0, sizeof(HaleKillEngi)-1)]);

		case TFClass_Medic:
			strcopy(buffer, sizeof(buffer), HALEKILLMEDIC);

		case TFClass_Sniper:
			strcopy(buffer, sizeof(buffer), HaleKillSniper[GetRandomInt(0, sizeof(HaleKillSniper)-1)]);

		case TFClass_Spy:
			strcopy(buffer, sizeof(buffer), HaleKillSpy[GetRandomInt(0, sizeof(HaleKillSpy)-1)]);

		case TFClass_Civilian:
			strcopy(buffer, sizeof(buffer), HALEKILLCIVIL);

		default:
			return Plugin_Changed;
	}

	if(!Client[client].NoVoice)
	{
		ClientCommand(client, "playgamesound \"%s\"", buffer);
		ClientCommand(client, "playgamesound \"%s\"", buffer);
	}

	for(int i=1; i<=MaxClients; i++)
	{
		if(i==client || !IsClientInGame(i) || Client[i].NoVoice)
			continue;

		EmitSoundToClient(i, buffer, attacker, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, attacker, _, NULL_VECTOR, true, 0.0);
		EmitSoundToClient(i, buffer, attacker, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, attacker, _, NULL_VECTOR, true, 0.0);
	}
	return Plugin_Changed;
}

public Action Hale_Death(int client, int attacker, char[] logname, char[] iconname)
{
	int sound = GetRandomInt(0, sizeof(HaleDeath)-1);
	for(int i=1; i<=MaxClients; i++)
	{
		if(!IsClientInGame(i) || Client[i].NoVoice)
			continue;

		ClientCommand(i, "playgamesound \"%s\"", HaleDeath[sound]);
		ClientCommand(i, "playgamesound \"%s\"", HaleDeath[sound]);
	}
	return Plugin_Continue;
}

public void Hale_Destory(int client)
{
	/*if(GetRandomInt(0, 2))
		return;

	for(int i=1; i<=MaxClients; i++)
	{
		if(!IsClientInGame(i) || Client[i].NoVoice)
			continue;

		EmitSoundToAll(HALEKILLBUILD, client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, _, NULL_VECTOR, true, 0.0);
		EmitSoundToAll(HALEKILLBUILD, client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, _, NULL_VECTOR, true, 0.0);
	}*/
}

public Action Hale_Think(int client, int &buttons)
{
	if(!IsPlayerAlive(client))
		return Plugin_Continue;

	SetEntityHealth(client, Hale[client].Health);

	if(GetEntProp(client, Prop_Send, "m_bDucked") && (GetEntityFlags(client) & FL_ONGROUND))
	{
		SetEntPropFloat(client, Prop_Send, "m_flMaxspeed", 520.0);
	}
	else
	{
		SetEntPropFloat(client, Prop_Send, "m_flMaxspeed", 340.0+0.7*(100-Hale[client].Health*100/Hale[client].MaxHealth));
	}

	static float eyeAngles[3];
	float engineTime = GetEngineTime();
	float chargePercent = 0.0;
	if(Hale[client].JumpReadyAt < engineTime)
	{
		if(Hale[client].JumpChargeFrom)
		{
			chargePercent = fmin((engineTime - Hale[client].JumpChargeFrom) / 1.5, 1.0) * 100.0;

			// has key been released?
			if(!(buttons & CHARGE_BUTTON))
			{
				// is user's eye angle valid? if so, perform the jump
				GetClientEyeAngles(client, eyeAngles);
				if(eyeAngles[0] <= JUMP_TELEPORT_MAX_ANGLE)
				{
					// unlike the original, I'm managing cooldown myself. so lets do it.
					// also doing it now to completely avoid that rare double SJ glitch I've seen
					Hale[client].JumpReadyAt = engineTime+6.0;
					Hale[client].WeighReadyAt = engineTime+3.0;

					// taken from default_abilities, modified only lightly
					static float position[3], velocity[3];
					GetEntPropVector(client, Prop_Send, "m_vecOrigin", position);
					GetEntPropVector(client, Prop_Data, "m_vecVelocity", velocity);

					velocity[2] = (750 + (chargePercent / 4) * 13.0);
					if(Hale[client].JumpDuper)
					{
						velocity[2] += 2000;
						Hale[client].JumpDuper = false;
					}

					SetEntProp(client, Prop_Send, "m_bJumping", 1);
					velocity[0] *= (1 + Sine((chargePercent / 4) * FLOAT_PI / 50));
					velocity[1] *= (1 + Sine((chargePercent / 4) * FLOAT_PI / 50));

					TeleportEntity(client, NULL_VECTOR, NULL_VECTOR, velocity);

					int sound = GetRandomInt(0, sizeof(HaleJump)-1);
					for(int i=1; i<=MaxClients; i++)
					{
						if(!IsClientInGame(i) || Client[i].NoVoice)
							continue;

						EmitSoundToClient(i, HaleJump[sound], client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, position, NULL_VECTOR, true, 0.0);
						EmitSoundToClient(i, HaleJump[sound], client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, position, NULL_VECTOR, true, 0.0);

						if(i == client)
							continue;

						EmitSoundToClient(i, HaleJump[sound], client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, position, NULL_VECTOR, true, 0.0);
						EmitSoundToClient(i, HaleJump[sound], client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, position, NULL_VECTOR, true, 0.0);
					}
				}

				// regardless of outcome, cancel the charge.
				Hale[client].JumpChargeFrom = 0.0;
			}
		}
		// do we start the charging now?
		else if(buttons & CHARGE_BUTTON)
		{
			Hale[client].JumpChargeFrom = engineTime;
		}
	}
		
	// draw the HUD if it's time
	if(engineTime > Client[client].HudAt)
	{
		if(Hale[client].JumpDuper)
		{
			static bool flash;
			if(flash)
			{
				SetHudTextParams(-1.0, HUD_Y, HUD_INTERVAL+HUD_LINGER, HUD_R_ERROR, HUD_G_ERROR, HUD_B_ERROR, HUD_ALPHA);
			}
			else
			{
				SetHudTextParams(-1.0, HUD_Y, HUD_INTERVAL+HUD_LINGER, HUD_R_OK, HUD_G_OK, HUD_B_OK, HUD_ALPHA);
			}
			ShowSyncHudText(client, PlayerHud, "SUPER Brave Jump is ready.\nLook up, press and release ALT-FIRE.");
		}
		else if(Hale[client].JumpReadyAt < engineTime)
		{
			SetHudTextParams(-1.0, HUD_Y, HUD_INTERVAL+HUD_LINGER, HUD_R_OK, HUD_G_OK, HUD_B_OK, HUD_ALPHA);
			ShowSyncHudText(client, PlayerHud, "Brave Jump is ready. %.0f percent charged.\nLook up, press and release ALT-FIRE.", chargePercent);
		}
		else
		{
			SetHudTextParams(-1.0, HUD_Y, HUD_INTERVAL+HUD_LINGER, HUD_R_ERROR, HUD_G_ERROR, HUD_B_ERROR, HUD_ALPHA);
			ShowSyncHudText(client, PlayerHud, "Brave Jump is not ready. %.1f seconds remaining.", Hale[client].JumpReadyAt-engineTime);
		}

		if(Hale[client].Rage >= HALERAGEDAMAGE)
		{
			SetHudTextParams(-1.0, 0.83, HUD_INTERVAL+HUD_LINGER, HUD_R_ERROR, HUD_G_ERROR, HUD_B_ERROR, HUD_ALPHA);
			ShowSyncHudText(client, MainHud, "Call for medic to activate your \"RAGE\" ability!");
		}
		else
		{
			SetHudTextParams(-1.0, 0.83, HUD_INTERVAL+HUD_LINGER, HUD_R_OK, HUD_G_OK, HUD_B_OK, HUD_ALPHA);
			ShowSyncHudText(client, MainHud, "Rage is %d percent ready", RoundToFloor(Hale[client].Rage*100.0/HALERAGEDAMAGE));
		}

		Client[client].HudAt = engineTime+HUD_INTERVAL;
	}

	if(engineTime > Hale[client].WeighNormalizeAt)
	{
		SetEntityGravity(client, 1.0);
		Hale[client].WeighNormalizeAt = FAR_FUTURE;
	}

	if(Hale[client].WeighReadyAt < engineTime)
	{
		if(buttons & IN_DUCK)
		{
			GetClientEyeAngles(client, eyeAngles);
			if(eyeAngles[0] >= WEIGHDOWN_MIN_ANGLE)
			{
				SetEntityGravity(client, 6.0);
				Hale[client].WeighReadyAt = engineTime+3.0;
				Hale[client].WeighNormalizeAt = engineTime+1.0;
			}
		}
	}

	return Plugin_Continue;
}

public Action Hale_TakeDamage(int client, int &attacker, int &inflictor, float &damage, int &damagetype, int &weapon, float damageForce[3], float damagePosition[3], int damagecustom)
{
	if((damagetype & DMG_FALL) && (attacker<1 || client==attacker))
		return Plugin_Handled;

	if(attacker<1 || attacker>MaxClients)
	{
		static char classname[64];
		if(GetEntityClassname(attacker, classname, sizeof(classname)) && StrEqual(classname, "trigger_hurt", false))
		{
			Hale[client].JumpDuper = true;
			Hale[client].JumpReadyAt = 0.0;
		}
		return Plugin_Continue;
	}

	if(damagecustom == TF_CUSTOM_BACKSTAB)
	{
		damage = 195.0+(Hale[client].MaxHealth/90.0);
		damagetype |= DMG_CRIT|DMG_PREVENT_PHYSICS_FORCE;

		int sound = GetRandomInt(0, sizeof(HaleStab)-1);
		ClientCommand(attacker, "playgamesound \"%s\"", HaleStab[sound]);
		ClientCommand(attacker, "playgamesound \"%s\"", HaleStab[sound]);
		for(int i=1; i<=MaxClients; i++)
		{
			if(i==attacker || !IsClientInGame(i))
				continue;

			EmitSoundToClient(i, HaleStab[sound], client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, _, NULL_VECTOR, true, 0.0);
			EmitSoundToClient(i, HaleStab[sound], client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, _, NULL_VECTOR, true, 0.0);
		}

		EmitSoundToClient(client, "player/crit_received3.wav", _, _, _, _, 0.7, _, _, _, _, false);
		EmitSoundToClient(attacker, "player/crit_received3.wav", _, _, _, _, 0.7, _, _, _, _, false);
		SetEntPropFloat(weapon, Prop_Send, "m_flNextPrimaryAttack", GetGameTime()+1.5);
		SetEntProp(weapon, Prop_Send, "m_bLandedCrit", 1);
		SetEntPropFloat(attacker, Prop_Send, "m_flNextAttack", GetGameTime()+1.5);
		SetEntPropFloat(attacker, Prop_Send, "m_flStealthNextChangeTime", GetGameTime()+1.0);

		PrintHintText(attacker, "You backstabed Saxton Hale!");
		PrintHintText(client, "You got backstabed by %N!", attacker);
		return Plugin_Changed;
	}
	else if((damagetype & DMG_CRUSH) && damage==1000.0 && !IsValidEntity(weapon))
	{
		damage = 3000.34;
		damagetype |= DMG_CRIT|DMG_PREVENT_PHYSICS_FORCE;

		PrintHintTextToAll("Saxton Hale got telefragged!");
		PrintHintText(attacker, "You telefragged Saxton Hale!");
		PrintHintText(client, "You got telefragged by %N!", attacker);
		return Plugin_Changed;
	}

	bool changed = (GetEntProp(client, Prop_Send, "m_bDucked") && (GetEntityFlags(client) & FL_ONGROUND));
	if(changed)
		damagetype |= DMG_PREVENT_PHYSICS_FORCE;

	if(!Hale[attacker].Enabled)
	{
		float engineTime = GetEngineTime();
		if(weapon>MaxClients && IsValidEntity(weapon) && HasEntProp(weapon, Prop_Send, "m_iItemDefinitionIndex"))
		{
			int index = GetEntProp(weapon, Prop_Send, "m_iItemDefinitionIndex");
			switch(index)
			{
				case 0, 1, 2, 3, 5, 6, 7, 8, 32, 37, 3003, 3005, 3008:	// Melee weapons
				{
					damagetype |= DMG_CRIT;
					return Plugin_Changed;
				}
				case 9, 10, 11, 12, 3001:	// Shotguns, R.P.G
				{
					if(!(damagetype & DMG_CRIT))
					{
						damage *= 1.35;
						return Plugin_Changed;
					}
				}
				case 14:	// Sniper Rifle
				{
					if(Client[client].GlowFor < engineTime)
					{
						Client[client].GlowFor = engineTime+6.0;
					}
					else if(Client[client].GlowFor != FAR_FUTURE)
					{
						Client[client].GlowFor += 5.0;
						if(Client[client].GlowFor > engineTime+20.0)
							Client[client].GlowFor = engineTime+20.0;
					}

					if(!(damagetype & DMG_CRIT))
					{
						damage *= 1.5;
						return Plugin_Changed;
					}
				}
				case 16:	// SMG
				{
					if(!(damagetype & DMG_CRIT))
					{
						damage *= 2.0;
						return Plugin_Changed;
					}
				}
				case 17:	// Syringe Gun
				{
					int medigun = GetPlayerWeaponSlot(attacker, TFWeaponSlot_Secondary);
					if(medigun>MaxClients && IsValidEntity(medigun) && HasEntProp(medigun, Prop_Send, "m_flChargeLevel"))
						SetEntPropFloat(medigun, Prop_Send, "m_flChargeLevel", GetEntPropFloat(medigun, Prop_Send, "m_flChargeLevel")+0.01);

					if(!(damagetype & DMG_CRIT))
					{
						damage *= 1.35;
						return Plugin_Changed;
					}
				}
				case 21:	// Flamethrower
				{
					if(!(damagetype & DMG_CRIT) && damage>5)
					{
						damage *= 2.0;
						return Plugin_Changed;
					}
				}
				case 22, 23, 24:	// Pistols, Revolver
				{
					if(!(damagetype & DMG_CRIT))
					{
						damage *= 1.5;
						return Plugin_Changed;
					}
				}
				case 39:	// Flaregun
				{
					if(damage > 5)
					{
						damage *= 2.0;
						return Plugin_Changed;
					}
				}
				case 56:	// Huntsman
				{
					if(!(damagetype & DMG_CRIT))
					{
						damage *= 2.0;
						return Plugin_Changed;
					}
				}
				case 3002:	// Hunting Revolver
				{
					if(Client[client].GlowFor < engineTime)
					{
						Client[client].GlowFor = engineTime+3.0;
					}
					else if(Client[client].GlowFor != FAR_FUTURE)
					{
						Client[client].GlowFor += 2.5;
						if(Client[client].GlowFor > engineTime+20.0)
							Client[client].GlowFor = engineTime+20.0;
					}

					if(!(damagetype & DMG_CRIT))
					{
						damage *= 1.5;
						return Plugin_Changed;
					}
				}
			}
		}
		else if(Hale[client].RageFor > engineTime)
		{
			return Plugin_Handled;
		}
	}
	return changed ? Plugin_Changed : Plugin_Continue;
}

public void Hale_Lastman()
{
	int sound = GetRandomInt(0, sizeof(HaleLast)-1);
	for(int i=1; i<=MaxClients; i++)
	{
		if(IsClientInGame(i))
			ClientCommand(i, "playgamesound \"%s\"", HaleLast[sound]);
	}
}

public void Hale_Win()
{
	int sound = GetRandomInt(0, sizeof(HaleWin)-1);
	for(int i=1; i<=MaxClients; i++)
	{
		if(IsClientInGame(i))
			ClientCommand(i, "playgamesound \"%s\"", HaleWin[sound]);
	}
}

public void Hale_Desc(int client, char[] buffer)
{
	strcopy(buffer, 512, "Saxton Hale\n \nBrave Jump: Hold ALT-FIRE, look up, and release ALT-FIRE\nWeighdown: Look down and DUCK\nAnchor: Hold DUCK on the ground\nStun: Call for a medic when rage is ready\n ");
}