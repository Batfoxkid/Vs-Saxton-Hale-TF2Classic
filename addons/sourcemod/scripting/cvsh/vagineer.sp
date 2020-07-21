#define BOSS_VAG	2

#define VAGMODEL	"models/player/saxton_hale/vagineer_v151c.mdl"
#define VAGCLASS	TFClass_Engineer
#define VAGRAGEDAMAGE	2700

static const char VagDownload[][] =
{
	"models/player/saxton_hale/vagineer_v151c.dx80.vtx",
	"models/player/saxton_hale/vagineer_v151c.dx90.vtx",
	"models/player/saxton_hale/vagineer_v151c.mdl",
	"models/player/saxton_hale/vagineer_v151c.sw.vtx",
	"models/player/saxton_hale/vagineer_v151c.vvd",

	"sound/saxton_hale/vagineer_responce_intro.wav",
	"sound/saxton_hale/lolwut_0.wav",
	"sound/saxton_hale/lolwut_1.wav",
	"sound/saxton_hale/lolwut_2.wav",
	"sound/saxton_hale/lolwut_3.wav",
	"sound/saxton_hale/lolwut_4.wav",
	"sound/saxton_hale/lolwut_5.wav",
	"sound/saxton_hale/vagineer_responce_taunt_1.wav",
	"sound/saxton_hale/vagineer_responce_taunt_2.wav",
	"sound/saxton_hale/vagineer_responce_taunt_3.wav",
	"sound/saxton_hale/vagineer_responce_taunt_4.wav",
	"sound/saxton_hale/vagineer_responce_taunt_5.wav",
	"sound/saxton_hale/vagineer_responce_fail_1.wav",
	"sound/saxton_hale/vagineer_responce_fail_2.wav",
	"sound/saxton_hale/vagineer_responce_rage_1.wav",
	"sound/saxton_hale/vagineer_responce_rage_2.wav",
	"sound/saxton_hale/vagineer_responce_jump_1.wav",
	"sound/saxton_hale/vagineer_responce_jump_2.wav"
};

static const char VagIntro[][] =
{
	"saxton_hale/lolwut_1.wav",
	"saxton_hale/vagineer_responce_intro.wav"
};

static const char VagJump[][] =
{
	"saxton_hale/vagineer_responce_jump_1.wav",
	"saxton_hale/vagineer_responce_jump_2.wav"
};

static const char VagRage[][] =
{
	"saxton_hale/lolwut_2.wav",
	"saxton_hale/vagineer_responce_rage_1.wav",
	"saxton_hale/vagineer_responce_rage_2.wav"
};

static const char VagDeath[][] =
{
	"saxton_hale/vagineer_responce_fail_1.wav",
	"saxton_hale/vagineer_responce_fail_2.wav"
};

static const char VagKspree[][] =
{
	"saxton_hale/lolwut_4.wav",
	"saxton_hale/vagineer_responce_taunt_1.wav",
	"saxton_hale/vagineer_responce_taunt_2.wav",
	"saxton_hale/vagineer_responce_taunt_3.wav",
	"saxton_hale/vagineer_responce_taunt_4.wav",
	"saxton_hale/vagineer_responce_taunt_5.wav",
	"saxton_hale/lolwut_3.wav"
};

#define VAGLAST		"saxton_hale/lolwut_0.wav"
#define VAGWIN		"saxton_hale/vagineer_responce_taunt_5.wav"
#define VAGKILL		"saxton_hale/lolwut_5.wav"
#define VAGCATCH	"vo/engineer_jeers02.wav"

void Vag_Precache(Function &func)
{
	func = Vag_Info;

	PrecacheModel(VAGMODEL, true);
	PrecacheSound(VAGKILL, true);

	for(int i; i<sizeof(VagJump); i++)
	{
		PrecacheSound(VagJump[i], true);
	}

	for(int i; i<sizeof(VagRage); i++)
	{
		PrecacheSound(VagRage[i], true);
	}

	int table = FindStringTable("downloadables");
	bool save = LockStringTables(false);
	for(int i; i<sizeof(VagDownload); i++)
	{
		if(!FileExists(VagDownload[i], true))
		{
			LogError("Missing file: '%s'", VagDownload[i]);
			continue;
		}

		AddToStringTable(table, VagDownload[i]);
	}
	LockStringTables(save);
}

public void Vag_Info(int client, char[] name, char[] desc, bool setup)
{
	strcopy(name, 64, "Vagineer");
	if(setup)
	{
		Hale[client].RoundIntro = Vag_Intro;
		Hale[client].RoundStart = Vag_RoundStart;
		Hale[client].RoundLastman = Vag_Lastman;
		Hale[client].RoundWin = Vag_Win;

		Hale[client].PlayerSpawn = Vag_Spawn;
		Hale[client].PlayerSound = Vag_Sound;
		Hale[client].PlayerVoice = Vag_OnRage;
		Hale[client].PlayerCommand = Vag_Think;

		Hale[client].PlayerKill = Vag_Kill;
		Hale[client].PlayerDeath = Vag_Death;

		Hale[client].PlayerTakeDamage = Default_TakeDamage;

		Hale[client].MiscDesc = Vag_Desc;

		TF2_SetPlayerClass(client, VAGCLASS);
	}
	else
	{
		strcopy(desc, 512, "Vagineer\nBrave Jump: 6 sec cooldown, x0.9 height, x1.1 distance\nWeighdown: 3 sec cooldown, x6.0 gravity\n \nRage: 2700 damage\nUbercharge: 10 seconds\nSentry Stun: 10 seconds\n ");
	}
}

public void Vag_RoundStart(int client)
{
	TF2_SetPlayerClass(client, VAGCLASS);
	Vag_Spawn(client);
}

public Action Vag_OnRage(int client)
{
	if(!IsPlayerAlive(client) || Hale[client].Rage<VAGRAGEDAMAGE)
		return Plugin_Continue;

	char arg1[4], arg2[4];
	GetCmdArg(1, arg1, sizeof(arg1));
	GetCmdArg(2, arg2, sizeof(arg2));
	if(StringToInt(arg1) || StringToInt(arg2))
		return Plugin_Continue;

	Hale[client].Rage = 0;
	Hale[client].RageFor = GetEngineTime()+10.0;
	TF2_AddCondition(client, TFCond_Ubercharged, 10.0);

	static float position[3];
	GetEntPropVector(client, Prop_Send, "m_vecOrigin", position);

	int sound = GetRandomInt(0, sizeof(VagRage)-1);
	if(!Client[client].NoVoice)
		ClientCommand(client, "playgamesound %s", VagRage[sound]);

	for(int target=1; target<=MaxClients; target++)
	{
		if(target==client || Client[target].NoVoice || !IsClientInGame(target))
			continue;

		EmitSoundToClient(target, VagRage[sound], client, _, SNDLEVEL_TRAFFIC, _, _, _, client, position);
		EmitSoundToClient(target, VagRage[sound], client, _, SNDLEVEL_TRAFFIC, _, _, _, client, position);
		EmitSoundToClient(target, VagRage[sound], client, _, SNDLEVEL_TRAFFIC, _, _, _, client, position);
	}
	return Plugin_Handled;
}

public void Vag_Intro()
{
	int sound = GetRandomInt(0, sizeof(VagIntro)-1);
	for(int i=1; i<=MaxClients; i++)
	{
		if(!IsClientInGame(i) || Client[i].NoVoice)
			continue;

		ClientCommand(i, "playgamesound \"%s\"", VagIntro[sound]);
		ClientCommand(i, "playgamesound \"%s\"", VagIntro[sound]);
	}
}

public void Vag_Spawn(int client)
{
	SetVariantString(VAGMODEL);
	AcceptEntityInput(client, "SetCustomModel");
	SetEntProp(client, Prop_Send, "m_bUseClassAnimations", 1);

	for(int i; i<6; i++)
	{
		if(i != TFWeaponSlot_Melee)
			TF2_RemoveWeaponSlot(client, i);
	}

	TF2_AddCondition(client, TFCond_RestrictToMelee);
}

public Action Vag_Kill(int attacker, int client, char[] logname, char[] iconname)
{
	EmitSoundToAll(VAGKILL, client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, _, NULL_VECTOR, true, 0.0);
	EmitSoundToAll(VAGKILL, client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, _, NULL_VECTOR, true, 0.0);
	CreateTimer(0.1, Vag_DissolveRagdoll, GetClientUserId(client), TIMER_FLAG_NO_MAPCHANGE);

	if(AlivePlayers < 3)
		return Plugin_Continue;

	float engineTime = GetEngineTime();
	if(Hale[attacker].SpreeFor < engineTime)
	{
		Hale[attacker].SpreeNext = false;
		Hale[attacker].SpreeFor = engineTime+4.0;
	}

	Hale[attacker].SpreeFor = engineTime+4.0;
	if(!Hale[attacker].SpreeNext)
	{
		Hale[attacker].SpreeNext = true;
		return Plugin_Continue;
	}

	Hale[attacker].SpreeFor = 0.0;
	int sound = GetRandomInt(0, sizeof(VagKspree)-1);
	for(int i=1; i<=MaxClients; i++)
	{
		if(!IsClientInGame(i) || Client[i].NoVoice)
			continue;

		ClientCommand(i, "playgamesound \"%s\"", VagKspree[sound]);
		ClientCommand(i, "playgamesound \"%s\"", VagKspree[sound]);
	}
	return Plugin_Continue;
}

public Action Vag_Death(int client, int attacker, char[] logname, char[] iconname)
{
	if(client != attacker)
		CreateTimer(0.1, Vag_DissolveRagdoll, GetClientUserId(client), TIMER_FLAG_NO_MAPCHANGE);

	int sound = GetRandomInt(0, sizeof(VagDeath)-1);
	for(int i=1; i<=MaxClients; i++)
	{
		if(!IsClientInGame(i) || Client[i].NoVoice)
			continue;

		ClientCommand(i, "playgamesound \"%s\"", VagDeath[sound]);
		ClientCommand(i, "playgamesound \"%s\"", VagDeath[sound]);
	}
	return Plugin_Continue;
}

public Action Vag_Sound(int clients[64], int &numClients, char sound[PLATFORM_MAX_PATH], int &client, int &channel, float &volume, int &level, int &pitch, int &flags, char soundEntry[PLATFORM_MAX_PATH], int &seed)
{
	if(channel!=SNDCHAN_VOICE && !(channel==SNDCHAN_STATIC && !StrContains(sound, "vo")))
		return Plugin_Continue;

	strcopy(sound, PLATFORM_MAX_PATH, VAGCATCH);
	return Plugin_Changed;
}

public Action Vag_Think(int client, int &buttons)
{
	if(!IsPlayerAlive(client))
		return Plugin_Continue;

	SetEntityHealth(client, Hale[client].Health);
	SetEntPropFloat(client, Prop_Send, "m_flMaxspeed", 340.0+0.7*(100-Hale[client].Health*100/Hale[client].MaxHealth));

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

					velocity[2] = (750 + (chargePercent / 4.25) * 13.0);
					if(Hale[client].JumpDuper)
					{
						velocity[2] += 2000;
						Hale[client].JumpDuper = false;
					}

					SetEntProp(client, Prop_Send, "m_bJumping", 1);
					velocity[0] *= (1 + Sine((chargePercent / 3.75) * FLOAT_PI / 50));
					velocity[1] *= (1 + Sine((chargePercent / 3.75) * FLOAT_PI / 50));

					TeleportEntity(client, NULL_VECTOR, NULL_VECTOR, velocity);

					int sound = GetRandomInt(0, sizeof(VagJump)-1);
					for(int i=1; i<=MaxClients; i++)
					{
						if(!IsClientInGame(i) || Client[i].NoVoice)
							continue;

						EmitSoundToClient(i, VagJump[sound], client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, position, NULL_VECTOR, true, 0.0);
						EmitSoundToClient(i, VagJump[sound], client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, position, NULL_VECTOR, true, 0.0);

						if(i == client)
							continue;

						EmitSoundToClient(i, VagJump[sound], client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, position, NULL_VECTOR, true, 0.0);
						EmitSoundToClient(i, VagJump[sound], client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, position, NULL_VECTOR, true, 0.0);
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

public void Vag_Lastman()
{
	for(int i=1; i<=MaxClients; i++)
	{
		if(IsClientInGame(i) || Client[i].NoVoice)
			ClientCommand(i, "playgamesound \"%s\"", VAGLAST);
	}
}

public void Vag_Win()
{
	for(int i=1; i<=MaxClients; i++)
	{
		if(IsClientInGame(i) || Client[i].NoVoice)
			ClientCommand(i, "playgamesound \"%s\"", VAGWIN);
	}
}

public Action Vag_DissolveRagdoll(Handle timer, any userid)
{
	int client = GetClientOfUserId(userid);
	if(!client)
		return Plugin_Continue;

	int ragdoll = GetEntPropEnt(client, Prop_Send, "m_hRagdoll");
	if(!IsValidEntity(ragdoll))
		return Plugin_Continue;

	int dissolver = CreateEntityByName("env_entity_dissolver");
	if(dissolver == -1)
		return Plugin_Continue;

	DispatchKeyValue(dissolver, "dissolvetype", "0");
	DispatchKeyValue(dissolver, "magnitude", "200");
	DispatchKeyValue(dissolver, "target", "!activator");

	AcceptEntityInput(dissolver, "Dissolve", ragdoll);
	AcceptEntityInput(dissolver, "Kill");
	return Plugin_Continue;
}

public void Vag_Desc(int client, char[] buffer)
{
	strcopy(buffer, 512, "Vagineer\n \nBrave Jump: Hold ALT-FIRE, look up, and release ALT-FIRE\nWeighdown: Look down and DUCK\nUbercharge: Call for a medic when rage is ready\n ");
}