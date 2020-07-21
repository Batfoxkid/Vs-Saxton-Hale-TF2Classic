#define BOSS_CBS	3

static const char BossModel[] = "models/player/saxton_hale/cbs_v6.mdl";
static const TFClassType BossClass = TFClass_Sniper;
static const int RageDamage = 2900;

static const char Downloads[][] =
{
	"materials/models/player/saxton_hale/sniper_lens.vtf",
	"materials/models/player/saxton_hale/sniper_lens.vmt",
	"materials/models/player/saxton_hale/sniper_red.vtf",
	"materials/models/player/saxton_hale/sniper_red.vmt",
	"materials/models/player/saxton_hale/eyeball_l.vmt",
	"materials/models/player/saxton_hale/sniper_head_red.vmt",
	"materials/models/player/saxton_hale/eyeball_r.vmt",
	"materials/models/player/saxton_hale/sniper_head.vtf",

	"models/player/saxton_hale/cbs_v6.dx80.vtx",
	"models/player/saxton_hale/cbs_v6.dx90.vtx",
	"models/player/saxton_hale/cbs_v6.mdl",
	"models/player/saxton_hale/cbs_v6.phy",
	"models/player/saxton_hale/cbs_v6.sw.vtx",
	"models/player/saxton_hale/cbs_v6.vvd",

	"sound/saxton_hale/the_millionaires_holiday.mp3"
};

static const char BGMusic[] = "#saxton_hale/the_millionaires_holiday.mp3";
static const char SoundIntro[] = "vo/sniper_specialweapon08.wav";
static const char SoundJump[] = "vo/taunts/sniper_taunts23.wav";

static const char SoundDeath[][] =
{
	"vo/sniper_paincrticialdeath02.wav",
	"vo/sniper_paincrticialdeath03.wav",
	"vo/sniper_paincrticialdeath04.wav",
	"vo/sniper_paincrticialdeath01.wav"
};

static const char SoundSpree[][] =
{
	"vo/taunts/sniper_taunts02.wav",
	"vo/sniper_award01.wav",
	"vo/sniper_award02.wav",
	"vo/sniper_award03.wav",
	"vo/sniper_award04.wav",
	"vo/sniper_award05.wav",
	"vo/sniper_award06.wav",
	"vo/sniper_award07.wav",
	"vo/sniper_award08.wav",
	"vo/sniper_award09.wav",
	"vo/sniper_award10.wav",
	"vo/sniper_award11.wav",
	"vo/sniper_award12.wav",
	"vo/sniper_award13.wav",
	"vo/sniper_award14.wav",
	"vo/sniper_specialweapon08.wav"
};

static const char SoundRage[][] =
{
	"vo/taunts/sniper_taunts02.wav",
	"vo/taunts/sniper_taunts15.wav",
	"vo/taunts/sniper_taunts16.wav"
};

void CBS_Precache(Function &func)
{
	func = CBS_Info;

	PrecacheModel(BossModel, true);
	PrecacheSound(BGMusic, true);
	PrecacheSound(SoundIntro, true);
	PrecacheSound(SoundJump, true);

	for(int i; i<sizeof(SoundDeath); i++)
	{
		PrecacheSound(SoundDeath[i], true);
	}

	for(int i; i<sizeof(SoundSpree); i++)
	{
		PrecacheSound(SoundSpree[i], true);
	}

	for(int i; i<sizeof(SoundRage); i++)
	{
		PrecacheSound(SoundRage[i], true);
	}

	int table = FindStringTable("downloadables");
	bool save = LockStringTables(false);
	for(int i; i<sizeof(Downloads); i++)
	{
		if(!FileExists(Downloads[i], true))
		{
			LogError("Missing file: '%s'", Downloads[i]);
			continue;
		}

		AddToStringTable(table, Downloads[i]);
	}
	LockStringTables(save);
}

public void CBS_Info(int client, char[] name, char[] desc, bool setup)
{
	strcopy(name, 64, "Christian Brutal Sniper");
	if(setup)
	{
		Hale[client].RoundIntro = CBS_Intro;
		Hale[client].RoundStart = CBS_RoundStart;

		Hale[client].PlayerSpawn = CBS_Spawn;
		Hale[client].PlayerVoice = CBS_OnVoice;
		Hale[client].PlayerCommand = CBS_Think;

		Hale[client].PlayerKill = CBS_Kill;
		Hale[client].PlayerDeath = CBS_Death;

		Hale[client].PlayerTakeDamage = Default_TakeDamage;
		Hale[client].PlayerDealDamage = CBS_DealDamage;

		Hale[client].MiscTheme = CBS_Theme;
		Hale[client].MiscDesc = CBS_Desc;

		TF2_SetPlayerClass(client, BossClass);
	}
	else
	{
		strcopy(desc, 512, "Christian Brutal Sniper\nBrave Jump: 5 sec cooldown, x1.1 height, x0.9 distance\nWeighdown: 3 sec cooldown, x6.0 gravity\n \nRage: 2900 damage\nTimed Weapon: Up to 16 seconds\nSentry Stun: 5 seconds\n \nLoadouts: Primary & Melee\nThe Fishwhacker: Deals 100%% more damage\n ");
	}
}

public void CBS_RoundStart(int client)
{
	TF2_SetPlayerClass(client, BossClass);
	CBS_Spawn(client);
}

public Action CBS_OnVoice(int client)
{
	if(!IsPlayerAlive(client) || Hale[client].Rage<RageDamage)
		return Plugin_Continue;

	char arg1[4], arg2[4];
	GetCmdArg(1, arg1, sizeof(arg1));
	GetCmdArg(2, arg2, sizeof(arg2));
	if(StringToInt(arg1) || StringToInt(arg2))
		return Plugin_Continue;

	Hale[client].Rage = 0;
	Hale[client].RageFor = GetEngineTime()+5.0;

	TF2_RemoveCondition(client, TFCond_RestrictToMelee);

	static float position[3];
	GetEntPropVector(client, Prop_Send, "m_vecOrigin", position);

	int players;
	int var1 = GetClientTeam(client);
	int var2 = GetRandomInt(0, sizeof(SoundRage)-1);
	if(!Client[client].NoVoice)
		ClientCommand(client, "playgamesound %s", SoundRage[var2]);

	for(int target=1; target<=MaxClients; target++)
	{
		if(target==client || !IsClientInGame(target))
			continue;

		if(IsPlayerAlive(target) && var1!=GetClientTeam(target))
			players++;

		if(Client[target].NoVoice)
			continue;

		EmitSoundToClient(target, SoundRage[var2], client, _, SNDLEVEL_TRAFFIC, _, _, _, client, position);
		EmitSoundToClient(target, SoundRage[var2], client, _, SNDLEVEL_TRAFFIC, _, _, _, client, position);
		EmitSoundToClient(target, SoundRage[var2], client, _, SNDLEVEL_TRAFFIC, _, _, _, client, position);
	}

	if(players > 9)
		players = 9;

	Hale[client].JumpReadyAt = Hale[client].RageFor+(players*1.25);
	ClientCommand(client, "slot1");
	return Plugin_Handled;
}

public void CBS_Intro()
{
	for(int i=1; i<=MaxClients; i++)
	{
		if(!IsClientInGame(i) || Client[i].NoVoice)
			continue;

		ClientCommand(i, "playgamesound \"%s\"", SoundIntro);
		ClientCommand(i, "playgamesound \"%s\"", SoundIntro);
	}
}

public void CBS_Spawn(int client)
{
	SetVariantString(BossModel);
	AcceptEntityInput(client, "SetCustomModel");
	SetEntProp(client, Prop_Send, "m_bUseClassAnimations", 1);

	TF2_RemoveWeaponSlot(client, 1);
	TF2_RemoveWeaponSlot(client, 3);
	TF2_RemoveWeaponSlot(client, 4);
	TF2_RemoveWeaponSlot(client, 5);
	TF2_AddCondition(client, TFCond_RestrictToMelee);
}

public Action CBS_Kill(int client, int victim, char[] logname, char[] iconname)
{
	float engineTime = GetEngineTime();
	if(Hale[client].SpreeFor < engineTime)
	{
		Hale[client].SpreeNext = false;
		Hale[client].SpreeFor = engineTime+4.0;
		return Plugin_Continue;
	}

	Hale[client].SpreeFor = engineTime+4.0;
	if(!Hale[client].SpreeNext)
	{
		Hale[client].SpreeNext = true;
		return Plugin_Continue;
	}

	Hale[client].SpreeFor = 0.0;
	int sound = GetRandomInt(0, sizeof(SoundSpree)-1);
	for(int i=1; i<=MaxClients; i++)
	{
		if(!IsClientInGame(i) || Client[i].NoVoice)
			continue;

		ClientCommand(i, "playgamesound \"%s\"", SoundSpree[sound]);
		ClientCommand(i, "playgamesound \"%s\"", SoundSpree[sound]);
	}
	return Plugin_Continue;
}

public Action CBS_Death(int client, int attacker, char[] logname, char[] iconname)
{
	int sound = GetRandomInt(0, sizeof(SoundDeath)-1);
	for(int i=1; i<=MaxClients; i++)
	{
		if(!IsClientInGame(i) || Client[i].NoVoice)
			continue;

		ClientCommand(i, "playgamesound \"%s\"", SoundDeath[sound]);
		ClientCommand(i, "playgamesound \"%s\"", SoundDeath[sound]);
	}
	return Plugin_Continue;
}

public Action CBS_DealDamage(int client, int victim, int &inflictor, float &damage, int &damagetype, int &weapon, float damageForce[3], float damagePosition[3], int damagecustom)
{
	if(weapon<=MaxClients || !IsValidEntity(weapon) || !HasEntProp(weapon, Prop_Send, "m_iItemDefinitionIndex") || GetEntProp(weapon, Prop_Send, "m_iItemDefinitionIndex")!=3003)
	{
		if(!TF2_IsPlayerInCondition(victim, TFCond_Kritzkrieged))
		{
			damage *= 3.0;
			return Plugin_Changed;
		}
	}
	else
	{
		damage *= TF2_IsPlayerInCondition(victim, TFCond_Kritzkrieged) ? 1.54 : 4.62;
		return Plugin_Changed;
	}
	return Plugin_Continue;
}

public Action CBS_Think(int client, int &buttons)
{
	if(!IsPlayerAlive(client))
		return Plugin_Continue;

	SetEntityHealth(client, Hale[client].Health);
	SetEntPropFloat(client, Prop_Send, "m_flMaxspeed", 350.0+0.7*(100-Hale[client].Health*100/Hale[client].MaxHealth));

	static float eyeAngles[3];
	float engineTime = GetEngineTime();
	float chargePercent = 0.0;
	if(Hale[client].JumpReadyAt < engineTime)
	{
		TF2_AddCondition(client, TFCond_RestrictToMelee);
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
					Hale[client].JumpReadyAt = engineTime+5.0;
					Hale[client].WeighReadyAt = engineTime+3.0;

					// taken from default_abilities, modified only lightly
					static float position[3], velocity[3];
					GetEntPropVector(client, Prop_Send, "m_vecOrigin", position);
					GetEntPropVector(client, Prop_Data, "m_vecVelocity", velocity);

					velocity[2] = (750 + (chargePercent / 3.75) * 13.0);
					if(Hale[client].JumpDuper)
					{
						velocity[2] += 2000;
						Hale[client].JumpDuper = false;
					}

					SetEntProp(client, Prop_Send, "m_bJumping", 1);
					velocity[0] *= (1 + Sine((chargePercent / 4.25) * FLOAT_PI / 50));
					velocity[1] *= (1 + Sine((chargePercent / 4.25) * FLOAT_PI / 50));

					TeleportEntity(client, NULL_VECTOR, NULL_VECTOR, velocity);

					for(int i=1; i<=MaxClients; i++)
					{
						if(!IsClientInGame(i) || Client[i].NoVoice)
							continue;

						EmitSoundToClient(i, SoundJump, client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, position, NULL_VECTOR, true, 0.0);
						EmitSoundToClient(i, SoundJump, client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, position, NULL_VECTOR, true, 0.0);

						if(i == client)
							continue;

						EmitSoundToClient(i, SoundJump, client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, position, NULL_VECTOR, true, 0.0);
						EmitSoundToClient(i, SoundJump, client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, position, NULL_VECTOR, true, 0.0);
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

		if(Hale[client].Rage >= RageDamage)
		{
			SetHudTextParams(-1.0, 0.83, HUD_INTERVAL+HUD_LINGER, HUD_R_ERROR, HUD_G_ERROR, HUD_B_ERROR, HUD_ALPHA);
			ShowSyncHudText(client, MainHud, "Call for medic to activate your \"RAGE\" ability!");
		}
		else
		{
			SetHudTextParams(-1.0, 0.83, HUD_INTERVAL+HUD_LINGER, HUD_R_OK, HUD_G_OK, HUD_B_OK, HUD_ALPHA);
			ShowSyncHudText(client, MainHud, "Rage is %d percent ready", RoundToFloor(Hale[client].Rage*100.0/RageDamage));
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

	if(buttons & IN_ATTACK2)
	{
		buttons &= ~IN_ATTACK2;
		return Plugin_Changed;
	}
	return Plugin_Continue;
}

public void CBS_Theme(int client)
{
	strcopy(Client[client].Theme, sizeof(Client[].Theme), BGMusic);
	Client[client].ThemeAt = GetEngineTime()+131.0;
	PrintToChat(client, "%sNow Playing: Combustible Edison - The Millionaire's Holiday", PREFIX);
}

public void CBS_Desc(int client, char[] buffer)
{
	strcopy(buffer, 512, "Christian Brutal Sniper\n \nBrave Jump: Hold ALT-FIRE, look up, and release ALT-FIRE\nWeighdown: Look down and DUCK\nTimed Weapon: Call for a medic when rage is ready\nLoadout: Your loadout effects this boss\n ");
}