#define BOSS_H413	6

static const char BossModel[] = "models/bots/saxtron/bot_saxtron_v2.mdl";
static const TFClassType BossClass = TFClass_Soldier;
static const int RageDamage = 2800;

static const char Downloads[][] =
{
	"materials/models/bots/saxtronv2/bot_saxtron_hat_blue.vmt",
	"materials/models/bots/saxtronv2/bot_saxtron_hat_blue.vtf",
	"materials/models/bots/saxtronv2/saxtron_bot_blue.vmt",
	"materials/models/bots/saxtronv2/saxtron_bot_blue.vtf",
	"materials/models/bots/saxtronv2/saxtron_bot_head.vmt",
	"materials/models/bots/saxtronv2/saxtron_bot_head.vtf",
	"materials/models/bots/saxtronv2/saxtron_buckle.vmt",
	"materials/models/bots/saxtronv2/saxtron_buckle.vtf",

	"models/bots/saxtron/bot_saxtron_v2.dx80.vtx",
	"models/bots/saxtron/bot_saxtron_v2.dx90.vtx",
	"models/bots/saxtron/bot_saxtron_v2.mdl",
	"models/bots/saxtron/bot_saxtron_v2.phy",
	"models/bots/saxtron/bot_saxtron_v2.sw.vtx",
	"models/bots/saxtron/bot_saxtron_v2.vvd",

	"sound/saxtron2/saxton_hale_responce_start1.wav",
	"sound/saxtron2/saxton_hale_responce_start2.wav",
	"sound/saxtron2/saxton_hale_responce_start3.wav",
	"sound/saxtron2/saxton_hale_responce_start4.wav",
	"sound/saxtron2/saxton_hale_responce_start5.wav",
	"sound/saxtron2/saxton_hale_132_start_1.wav",
	"sound/saxtron2/saxton_hale_132_start_2.wav",
	"sound/saxtron2/saxton_hale_132_start_3.wav",
	"sound/saxtron2/saxton_hale_132_start_4.wav",
	"sound/saxtron2/saxton_hale_132_start_5.wav",
	"sound/saxtron2/saxton_hale_responce_rage1.wav",
	"sound/saxtron2/saxton_hale_responce_rage2.wav",
	"sound/saxtron2/saxton_hale_responce_rage3.wav",
	"sound/saxtron2/saxton_hale_responce_rage4.wav",
	"sound/saxtron2/saxton_hale_132_jump_1.wav",
	"sound/saxtron2/saxton_hale_132_jump_2.wav",
	"sound/saxtron2/saxton_hale_responce_jump1.wav",
	"sound/saxtron2/saxton_hale_responce_jump2.wav",
	"sound/saxtron2/saxton_hale_responce_win1.wav",
	"sound/saxtron2/saxton_hale_responce_win2.wav",
	"sound/saxtron2/saxton_hale_responce_fail1.wav",
	"sound/saxtron2/saxton_hale_responce_fail2.wav",
	"sound/saxtron2/saxton_hale_responce_fail3.wav",
	"sound/saxtron2/saxton_hale_132_last.wav",
	"sound/saxtron2/saxton_hale_responce_2.wav",
	"sound/saxtron2/saxton_hale_responce_lastman1.wav",
	"sound/saxtron2/saxton_hale_responce_lastman2.wav",
	"sound/saxtron2/saxton_hale_responce_lastman3.wav",
	"sound/saxtron2/saxton_hale_responce_lastman4.wav",
	"sound/saxtron2/saxton_hale_responce_lastman5.wav",
	"sound/saxtron2/saxton_hale_132_kill_scout.wav",
	"sound/saxtron2/saxton_hale_132_kill_w_and_m1.wav",
	"sound/saxtron2/saxton_hale_132_kill_demo.wav",
	"sound/saxtron2/saxton_hale_132_kill_heavy.wav",
	"sound/saxtron2/saxton_hale_132_kill_engie_1.wav",
	"sound/saxtron2/saxton_hale_132_kill_engie_2.wav",
	"sound/saxtron2/saxton_hale_responce_kill_eggineer1.wav",
	"sound/saxtron2/saxton_hale_responce_kill_eggineer2.wav",
	"sound/saxtron2/saxton_hale_responce_kill_medic.wav",
	"sound/saxtron2/saxton_hale_132_kill_toy.wav",
	"sound/saxtron2/saxton_hale_responce_kill_medic.wav",
	"sound/saxtron2/saxton_hale_responce_kill_sniper1.wav",
	"sound/saxtron2/saxton_hale_responce_kill_sniper2.wav",
	"sound/saxtron2/saxton_hale_132_kill_spie.wav",
	"sound/saxtron2/saxton_hale_responce_kill_spy1.wav",
	"sound/saxtron2/saxton_hale_responce_kill_spy2.wav",
	"sound/saxtron2/saxton_hale_132_kill_toy.wav",
	"sound/saxtron2/saxton_hale_responce_spree1.wav",
	"sound/saxtron2/saxton_hale_responce_spree2.wav",
	"sound/saxtron2/saxton_hale_responce_spree3.wav",
	"sound/saxtron2/saxton_hale_responce_spree4.wav",
	"sound/saxtron2/saxton_hale_responce_spree5.wav",
	"sound/saxtron2/saxton_hale_responce_3.wav",
	"sound/saxtron2/saxton_hale_132_kspree_1.wav",
	"sound/saxtron2/saxton_hale_132_kspree_2.wav",
	"sound/saxtron2/saxton_hale_132_stub_1.wav",
	"sound/saxtron2/saxton_hale_132_stub_2.wav",
	"sound/saxtron2/saxton_hale_132_stub_3.wav",
	"sound/saxtron2/saxton_hale_132_stub_4.wav"
};

static const char SoundIntro[][] =
{
	"saxtron2/saxton_hale_responce_start1.wav",
	"saxtron2/saxton_hale_responce_start2.wav",
	"saxtron2/saxton_hale_responce_start3.wav",
	"saxtron2/saxton_hale_responce_start4.wav",
	"saxtron2/saxton_hale_responce_start5.wav",
	"saxtron2/saxton_hale_132_start_1.wav",
	"saxtron2/saxton_hale_132_start_2.wav",
	"saxtron2/saxton_hale_132_start_3.wav",
	"saxtron2/saxton_hale_132_start_4.wav",
	"saxtron2/saxton_hale_132_start_5.wav"
};

static const char SoundRage[][] =
{
	"saxtron2/saxton_hale_responce_rage1.wav",
	"saxtron2/saxton_hale_responce_rage2.wav",
	"saxtron2/saxton_hale_responce_rage3.wav",
	"saxtron2/saxton_hale_responce_rage4.wav"
};

static const char SoundJump[][] =
{
	"saxtron2/saxton_hale_132_jump_1.wav",
	"saxtron2/saxton_hale_132_jump_2.wav",
	"saxtron2/saxton_hale_responce_jump1.wav",
	"saxtron2/saxton_hale_responce_jump2.wav"
};

static const char SoundWin[][] =
{
	"saxtron2/saxton_hale_responce_win1.wav",
	"saxtron2/saxton_hale_responce_win2.wav"
};

static const char SoundDeath[][] =
{
	"saxtron2/saxton_hale_responce_fail1.wav",
	"saxtron2/saxton_hale_responce_fail2.wav",
	"saxtron2/saxton_hale_responce_fail3.wav"
};

static const char SoundLast[][] =
{
	"saxtron2/saxton_hale_132_last.wav",
	"saxtron2/saxton_hale_responce_2.wav",
	"saxtron2/saxton_hale_responce_lastman1.wav",
	"saxtron2/saxton_hale_responce_lastman2.wav",
	"saxtron2/saxton_hale_responce_lastman3.wav",
	"saxtron2/saxton_hale_responce_lastman4.wav",
	"saxtron2/saxton_hale_responce_lastman5.wav"
};

static const char SoundKillScout[] = "saxtron2/saxton_hale_132_kill_scout.wav";
static const char SoundKillSoldier[] = "saxtron2/saxton_hale_responce_spree3.wav";
static const char SoundKillPyro[] = "saxtron2/saxton_hale_132_kill_w_and_m1.wav";
static const char SoundKillDemo[] = "saxtron2/saxton_hale_132_kill_demo.wav";
static const char SoundKillHeavy[] = "saxtron2/saxton_hale_132_kill_heavy.wav";
static const char SoundKillMedic[] = "saxtron2/saxton_hale_responce_kill_medic.wav";
static const char SoundKillCivil[] = "saxtron2/saxton_hale_132_kspree_1.wav";
static const char SoundKillBuild[] = "saxtron2/saxton_hale_132_kill_toy.wav";

static const char SoundKillEngi[][] =
{
	"saxtron2/saxton_hale_132_kill_engie_1.wav",
	"saxtron2/saxton_hale_132_kill_engie_2.wav",
	"saxtron2/saxton_hale_responce_kill_eggineer1.wav",
	"saxtron2/saxton_hale_responce_kill_eggineer2.wav"
};

static const char SoundKillSniper[][] =
{
	"saxtron2/saxton_hale_responce_kill_sniper1.wav",
	"saxtron2/saxton_hale_responce_kill_sniper2.wav"
};

static const char SoundKillSpy[][] =
{
	"saxtron2/saxton_hale_132_kill_spie.wav",
	"saxtron2/saxton_hale_responce_kill_spy1.wav",
	"saxtron2/saxton_hale_responce_kill_spy2.wav"
};

static const char SoundKspree[][] =
{
	"saxtron2/saxton_hale_responce_spree1.wav",
	"saxtron2/saxton_hale_responce_spree2.wav",
	"saxtron2/saxton_hale_responce_spree4.wav",
	"saxtron2/saxton_hale_responce_spree5.wav",
	"saxtron2/saxton_hale_responce_3.wav",
	"saxtron2/saxton_hale_132_kspree_2.wav"
};

static const char SoundStab[][] =
{
	"saxtron2/saxton_hale_132_stub_1.wav",
	"saxtron2/saxton_hale_132_stub_2.wav",
	"saxtron2/saxton_hale_132_stub_3.wav",
	"saxtron2/saxton_hale_132_stub_4.wav"
};

static float SlowFor[MAXPLAYERS+1];

void H413_Precache(Function &func)
{
	func = H413_Info;

	PrecacheModel(BossModel, true);
	PrecacheSound(SoundKillScout, true);
	PrecacheSound(SoundKillSoldier, true);
	PrecacheSound(SoundKillPyro, true);
	PrecacheSound(SoundKillDemo, true);
	PrecacheSound(SoundKillHeavy, true);
	PrecacheSound(SoundKillMedic, true);
	PrecacheSound(SoundKillCivil, true);
	PrecacheSound(SoundKillBuild, true);

	for(int i; i<sizeof(SoundRage); i++)
	{
		PrecacheSound(SoundRage[i], true);
	}

	for(int i; i<sizeof(SoundJump); i++)
	{
		PrecacheSound(SoundJump[i], true);
	}

	for(int i; i<sizeof(SoundKillEngi); i++)
	{
		PrecacheSound(SoundKillEngi[i], true);
	}

	for(int i; i<sizeof(SoundKillSniper); i++)
	{
		PrecacheSound(SoundKillSniper[i], true);
	}

	for(int i; i<sizeof(SoundKillSpy); i++)
	{
		PrecacheSound(SoundKillSpy[i], true);
	}

	for(int i; i<sizeof(SoundStab); i++)
	{
		PrecacheSound(SoundStab[i], true);
	}

	for(int i; i<sizeof(SoundLast); i++)
	{
		PrecacheSound(SoundLast[i], true);
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

public void H413_Info(int client, char[] name, char[] desc, bool setup)
{
	strcopy(name, 64, "Saxtron H413");
	if(setup)
	{
		Hale[client].RoundIntro = H413_Intro;
		Hale[client].RoundStart = H413_RoundStart;
		Hale[client].RoundLastman = H413_Lastman;
		Hale[client].RoundWin = H413_Win;

		Hale[client].PlayerSpawn = H413_Spawn;
		Hale[client].PlayerSound = Default_Sound;
		Hale[client].PlayerVoice = H413_OnRage;
		Hale[client].PlayerCommand = H413_Think;

		Hale[client].PlayerKill = H413_Kill;
		Hale[client].PlayerDeath = H413_Death;

		Hale[client].PlayerTakeDamage = H413_TakeDamage;

		Hale[client].MiscDestory = H413_Destory;
		Hale[client].MiscDesc = H413_Desc;

		TF2_SetPlayerClass(client, BossClass);
	}
	else
	{
		strcopy(desc, 512, "Saxtron H413\nBrave Jump: 6 sec cooldown, x1.0 height, x1.0 distance\nWeighdown: 3 sec cooldown, x6.0 gravity\nAnchor: always active\n \nRage: 2800 damage\nSlowdown: 7 seconds, x1.0 range\nStrip to Melee: 7 seconds, x1.0 range\nSentry Stun: 7 seconds\n ");
	}
}

public void H413_RoundStart(int client)
{
	TF2_SetPlayerClass(client, BossClass);
	H413_Spawn(client);
}

public Action H413_OnRage(int client)
{
	if(!IsPlayerAlive(client) || Hale[client].Rage<RageDamage)
		return Plugin_Continue;

	char arg1[4], arg2[4];
	GetCmdArg(1, arg1, sizeof(arg1));
	GetCmdArg(2, arg2, sizeof(arg2));
	if(StringToInt(arg1) || StringToInt(arg2))
		return Plugin_Continue;

	Hale[client].Rage = 0;

	static float position[3];
	GetEntPropVector(client, Prop_Send, "m_vecOrigin", position);

	Hale[client].RageFor = GetEngineTime()+7.0;

	int team = GetClientTeam(client);
	bool friendlyFire = GetConVarBool(FindConVar("mp_friendlyfire"));
	int sound = GetRandomInt(0, sizeof(SoundRage)-1);
	if(!Client[client].NoVoice)
		ClientCommand(client, "playgamesound %s", SoundRage[sound]);

	for(int target=1; target<=MaxClients; target++)
	{
		if(target==client || !IsClientInGame(target))
			continue;

		if(!Client[target].NoVoice)
		{
			EmitSoundToClient(target, SoundRage[sound], client, _, SNDLEVEL_TRAFFIC, _, _, _, client, position);
			EmitSoundToClient(target, SoundRage[sound], client, _, SNDLEVEL_TRAFFIC, _, _, _, client, position);
			EmitSoundToClient(target, SoundRage[sound], client, _, SNDLEVEL_TRAFFIC, _, _, _, client, position);
		}

		if(!IsPlayerAlive(target) || TF2_IsPlayerInCondition(target, TFCond_Ubercharged) || (!friendlyFire && GetClientTeam(target)==team))
			continue;

		static float position2[3];
		GetEntPropVector(target, Prop_Send, "m_vecOrigin", position2);
		if(GetVectorDistance(position, position2) > 800)
			continue;

		Client[target].LastWeapon = GetEntPropEnt(target, Prop_Send, "m_hActiveWeapon");
		TF2_AddCondition(target, TFCond_RestrictToMelee, 7.0);
		SDKHook(target, SDKHook_PreThink, H413_PreThink);
		SlowFor[target] = Hale[client].RageFor;
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

public void H413_Intro()
{
	int sound = GetRandomInt(0, sizeof(SoundIntro)-1);
	for(int i=1; i<=MaxClients; i++)
	{
		if(!IsClientInGame(i) || Client[i].NoVoice)
			continue;

		ClientCommand(i, "playgamesound \"%s\"", SoundIntro[sound]);
		ClientCommand(i, "playgamesound \"%s\"", SoundIntro[sound]);
	}
}

public void H413_Spawn(int client)
{
	SetVariantString(BossModel);
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

public Action H413_Kill(int attacker, int client, char[] logname, char[] iconname)
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
		int sound = GetRandomInt(0, sizeof(SoundKspree)-1);
		for(int i=1; i<=MaxClients; i++)
		{
			if(!IsClientInGame(i) || Client[i].NoVoice)
				continue;

			ClientCommand(i, "playgamesound \"%s\"", SoundKspree[sound]);
			ClientCommand(i, "playgamesound \"%s\"", SoundKspree[sound]);
		}
		return Plugin_Changed;
	}

	Hale[attacker].SpreeNext = false;
	Hale[attacker].SpreeFor = engineTime+4.0;

	static char buffer[128];
	switch(TF2_GetPlayerClass(client))
	{
		case TFClass_Scout:
			strcopy(buffer, sizeof(buffer), SoundKillScout);

		case TFClass_Soldier:
			strcopy(buffer, sizeof(buffer), SoundKillSoldier);

		case TFClass_Pyro:
			strcopy(buffer, sizeof(buffer), SoundKillPyro);

		case TFClass_DemoMan:
			strcopy(buffer, sizeof(buffer), SoundKillDemo);

		case TFClass_Heavy:
			strcopy(buffer, sizeof(buffer), SoundKillHeavy);

		case TFClass_Engineer:
			strcopy(buffer, sizeof(buffer), SoundKillEngi[GetRandomInt(0, sizeof(SoundKillEngi)-1)]);

		case TFClass_Medic:
			strcopy(buffer, sizeof(buffer), SoundKillMedic);

		case TFClass_Sniper:
			strcopy(buffer, sizeof(buffer), SoundKillSniper[GetRandomInt(0, sizeof(SoundKillSniper)-1)]);

		case TFClass_Spy:
			strcopy(buffer, sizeof(buffer), SoundKillSpy[GetRandomInt(0, sizeof(SoundKillSpy)-1)]);

		case TFClass_Civilian:
			strcopy(buffer, sizeof(buffer), SoundKillCivil);

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

public Action H413_Death(int client, int attacker, char[] logname, char[] iconname)
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

public void H413_Destory(int client)
{
	if(GetRandomInt(0, 2))
		return;

	for(int i=1; i<=MaxClients; i++)
	{
		if(!IsClientInGame(i) || Client[i].NoVoice)
			continue;

		EmitSoundToClient(i, SoundKillBuild, client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, _, NULL_VECTOR, true, 0.0);
		EmitSoundToClient(i, SoundKillBuild, client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, _, NULL_VECTOR, true, 0.0);
	}
}

public Action H413_Think(int client, int &buttons)
{
	if(!IsPlayerAlive(client))
		return Plugin_Continue;

	SetEntityHealth(client, Hale[client].Health);
	SetEntPropFloat(client, Prop_Send, "m_flMaxspeed", 310.0+0.7*(100-Hale[client].Health*100/Hale[client].MaxHealth));

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
					if(!CvarWeighdown.BoolValue)
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

					int sound = GetRandomInt(0, sizeof(SoundJump)-1);
					for(int i=1; i<=MaxClients; i++)
					{
						if(!IsClientInGame(i) || Client[i].NoVoice)
							continue;

						EmitSoundToClient(i, SoundJump[sound], client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, position, NULL_VECTOR, true, 0.0);
						EmitSoundToClient(i, SoundJump[sound], client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, position, NULL_VECTOR, true, 0.0);

						if(i == client)
							continue;

						EmitSoundToClient(i, SoundJump[sound], client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, position, NULL_VECTOR, true, 0.0);
						EmitSoundToClient(i, SoundJump[sound], client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, position, NULL_VECTOR, true, 0.0);
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

	return Plugin_Continue;
}

public Action H413_TakeDamage(int client, int &attacker, int &inflictor, float &damage, int &damagetype, int &weapon, float damageForce[3], float damagePosition[3], int damagecustom)
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

	damagetype |= DMG_PREVENT_PHYSICS_FORCE;
	if(damagecustom == TF_CUSTOM_BACKSTAB)
	{
		damage = 195.0+(Hale[client].MaxHealth/90.0);
		damagetype |= DMG_CRIT;

		int sound = GetRandomInt(0, sizeof(SoundStab)-1);
		ClientCommand(attacker, "playgamesound \"%s\"", SoundStab[sound]);
		ClientCommand(attacker, "playgamesound \"%s\"", SoundStab[sound]);
		for(int i=1; i<=MaxClients; i++)
		{
			if(i==attacker || !IsClientInGame(i))
				continue;

			EmitSoundToClient(i, SoundStab[sound], client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, _, NULL_VECTOR, true, 0.0);
			EmitSoundToClient(i, SoundStab[sound], client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, _, NULL_VECTOR, true, 0.0);
		}

		EmitSoundToClient(client, "player/crit_received3.wav", _, _, _, _, 0.7, _, _, _, _, false);
		EmitSoundToClient(attacker, "player/crit_received3.wav", _, _, _, _, 0.7, _, _, _, _, false);

		float gameTime = GetGameTime();
		SetEntPropFloat(weapon, Prop_Send, "m_flNextPrimaryAttack", gameTime+1.5);
		SetEntProp(weapon, Prop_Send, "m_bLandedCrit", 1);
		SetEntPropFloat(attacker, Prop_Send, "m_flNextAttack", gameTime+1.5);
		SetEntPropFloat(attacker, Prop_Send, "m_flStealthNextChangeTime", gameTime+1.0);

		PrintHintText(attacker, "You backstabed Saxtron H413!");
		PrintHintText(client, "You got backstabed by %N!", attacker);
		return Plugin_Changed;
	}
	else if((damagetype & DMG_CRUSH) && damage==1000.0 && !IsValidEntity(weapon))
	{
		damage = 3000.34;
		damagetype |= DMG_CRIT;

		PrintHintTextToAll("Saxtron H413 got telefragged!");
		PrintHintText(attacker, "You telefragged Saxtron H413!");
		PrintHintText(client, "You got telefragged by %N!", attacker);
		return Plugin_Changed;
	}

	if(!Hale[attacker].Enabled)
	{
		float engineTime = GetEngineTime();
		if(weapon>MaxClients && IsValidEntity(weapon) && HasEntProp(weapon, Prop_Send, "m_iItemDefinitionIndex"))
		{
			int index = GetEntProp(weapon, Prop_Send, "m_iItemDefinitionIndex");
			switch(index)
			{
				case 0, 1, 2, 5, 6, 7, 8, 32, 34, 42, 44, 47:	// Crit-Boosted Weapons
				{
					if(damage > 5)
						damagetype |= DMG_CRIT;
				}
				case 9, 10, 11, 12, 40:	// Shotguns, R.P.G
				{
					damagetype |= DMG_PREVENT_PHYSICS_FORCE;
					if(!(damagetype & DMG_CRIT))
					{
						damage *= 1.35;
						damagetype |= DMG_PREVENT_PHYSICS_FORCE;
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
						damagetype |= DMG_PREVENT_PHYSICS_FORCE;
					}
				}
				case 16:	// SMG
				{
					damagetype |= DMG_PREVENT_PHYSICS_FORCE;
					if(!(damagetype & DMG_CRIT))
						damage *= 2.0;
				}
				case 17:	// Syringe Gun
				{
					int medigun = GetPlayerWeaponSlot(attacker, TFWeaponSlot_Secondary);
					if(medigun>MaxClients && IsValidEntity(medigun) && HasEntProp(medigun, Prop_Send, "m_flChargeLevel"))
						SetEntPropFloat(medigun, Prop_Send, "m_flChargeLevel", GetEntPropFloat(medigun, Prop_Send, "m_flChargeLevel")+0.02);

					damagetype |= DMG_PREVENT_PHYSICS_FORCE;
					if(!(damagetype & DMG_CRIT))
						damage *= 1.35;
				}
				case 21:	// Flamethrower
				{
					damagetype |= DMG_PREVENT_PHYSICS_FORCE;
					if(!(damagetype & DMG_CRIT) && damage>5)
						damage *= 2.0;
				}
				case 22, 23, 24:	// Pistols, Revolver
				{
					damagetype |= DMG_PREVENT_PHYSICS_FORCE;
					if(!(damagetype & DMG_CRIT))
						damage *= 1.5;
				}
				case 35:	// Flaregun
				{
					damagetype |= DMG_PREVENT_PHYSICS_FORCE;
					if(damage > 5)
						damage *= 1.5;
				}
				case 37, 46:	// Huntsman, Mine Layer
				{
					if(!(damagetype & DMG_CRIT))
					{
						damage *= 2.0;
						damagetype |= DMG_PREVENT_PHYSICS_FORCE;
					}
				}
				case 41:	// Hunting Revolver
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
						damagetype |= DMG_PREVENT_PHYSICS_FORCE;
					}
				}
				case 43:	// Tranquilizer
				{
					if(Client[client].GlowFor < engineTime)
					{
						Client[client].GlowFor = engineTime+9.0;
					}
					else if(Client[client].GlowFor != FAR_FUTURE)
					{
						Client[client].GlowFor += 7.5;
						if(Client[client].GlowFor > engineTime+20.0)
							Client[client].GlowFor = engineTime+20.0;
					}
					damagetype |= DMG_PREVENT_PHYSICS_FORCE;
				}
				default:
				{
					if(damage < 250)
						damagetype |= DMG_PREVENT_PHYSICS_FORCE;
				}
			}
		}
		else if(Hale[client].RageFor > engineTime)
		{
			return Plugin_Handled;
		}
	}
	return Plugin_Changed;
}

public void H413_Lastman()
{
	int sound = GetRandomInt(0, sizeof(SoundLast)-1);
	for(int i=1; i<=MaxClients; i++)
	{
		if(IsClientInGame(i))
			ClientCommand(i, "playgamesound \"%s\"", SoundLast[sound]);
	}
}

public void H413_Win()
{
	int sound = GetRandomInt(0, sizeof(SoundWin)-1);
	for(int i=1; i<=MaxClients; i++)
	{
		if(IsClientInGame(i))
			ClientCommand(i, "playgamesound \"%s\"", SoundWin[sound]);
	}
}

public void H413_Desc(int client, char[] buffer)
{
	strcopy(buffer, 512, "Saxtron H413\n \nBrave Jump: Hold ALT-FIRE, look up, and release ALT-FIRE\nWeighdown: Look down and DUCK\nAnchor: Always in affect\nSlowdown + Strip to Melee: Call for a medic when rage is ready\n ");
}

public void H413_PreThink(int client)
{
	if(!IsPlayerAlive(client) || SlowFor[client]<GetEngineTime())
	{
		if(IsValidEntity(Client[client].LastWeapon))
			SetEntPropEnt(client, Prop_Send, "m_hActiveWeapon", Client[client].LastWeapon);

		SDKUnhook(client, SDKHook_PreThink, H413_PreThink);
		return;
	}

	SetEntPropFloat(client, Prop_Send, "m_flMaxspeed", 200.0);
	int entity = GetPlayerWeaponSlot(client, TFWeaponSlot_Melee);
	if(entity > MaxClients)
		SetEntPropEnt(client, Prop_Send, "m_hActiveWeapon", entity);
}