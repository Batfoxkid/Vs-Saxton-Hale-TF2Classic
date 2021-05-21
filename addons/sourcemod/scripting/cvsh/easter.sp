#define BOSS_EASTER	5

static const char BossModel[] = "models/player/saxton_hale/easter_demo.mdl";
static const char ProjModel[] = "models/player/saxton_hale/w_easteregg.mdl";
static const TFClassType BossWeapon = TFClass_DemoMan;
static const TFClassType BossClass = TFClass_Scout;
static const int RageDamage = 3400;

static const char Downloads[][] =
{
	"materials/models/player/easter_demo/demoman_head_red.vmt",
	"materials/models/player/easter_demo/easter_body.vmt",
	"materials/models/player/easter_demo/easter_body.vtf",
	"materials/models/player/easter_demo/easter_rabbit.vmt",
	"materials/models/player/easter_demo/easter_rabbit.vtf",
	"materials/models/player/easter_demo/easter_rabbit_normal.vtf",
	"materials/models/player/easter_demo/eyeball_r.vmt",
	"materials/models/props_easteregg/c_easteregg.vmt",
	"materials/models/props_easteregg/c_easteregg.vtf",
	"materials/models/props_easteregg/c_easteregg_gold.vmt",

	"models/player/saxton_hale/easter_demo.dx80.vtx",
	"models/player/saxton_hale/easter_demo.dx90.vtx",
	"models/player/saxton_hale/easter_demo.mdl",
	"models/player/saxton_hale/easter_demo.phy",
	"models/player/saxton_hale/easter_demo.sw.vtx",
	"models/player/saxton_hale/easter_demo.vvd",
	"models/player/saxton_hale/w_easteregg.dx80.vtx",
	"models/player/saxton_hale/w_easteregg.dx90.vtx",
	"models/player/saxton_hale/w_easteregg.mdl",
	"models/player/saxton_hale/w_easteregg.phy",
	"models/player/saxton_hale/w_easteregg.sw.vtx",
	"models/player/saxton_hale/w_easteregg.vvd"
};

static const char SoundIntro[][] =
{
	"vo/demoman_gibberish03.wav",
	"vo/demoman_gibberish11.wav"
};

static const char SoundCatch[][] =
{
	"vo/demoman_positivevocalization03.wav",
	"vo/demoman_jeers08.wav",
	"vo/demoman_gibberish03.wav",
	"vo/demoman_cheers07.wav",
	//"vo/demoman_sf12_badmagic01.wav",
	"vo/burp02.wav",
	"vo/burp03.wav",
	"vo/burp04.wav",
	"vo/burp05.wav",
	"vo/burp06.wav",
	"vo/burp07.wav"
};

static const char SoundDeath[][] =
{
	"vo/demoman_gibberish04.wav",
	"vo/demoman_gibberish10.wav",
	"vo/demoman_jeers03.wav",
	"vo/demoman_jeers06.wav",
	"vo/demoman_jeers07.wav",
	"vo/demoman_jeers08.wav"
};

static const char SoundWin[][] =
{
	"vo/demoman_gibberish01.wav",
	"vo/demoman_gibberish12.wav",
	"vo/demoman_cheers02.wav",
	"vo/demoman_cheers03.wav",
	"vo/demoman_cheers06.wav",
	"vo/demoman_cheers07.wav",
	"vo/demoman_cheers08.wav",
	"vo/taunts/demoman_taunts12.wav"
};

static const char SoundKill[][] =
{
	"vo/demoman_gibberish09.wav",
	"vo/demoman_cheers02.wav",
	"vo/demoman_cheers07.wav",
	"vo/demoman_positivevocalization03.wav"
};

static const char SoundSpree[][] =
{
	"vo/demoman_gibberish05.wav",
	"vo/demoman_gibberish06.wav",
	"vo/demoman_gibberish09.wav",
	"vo/demoman_gibberish11.wav",
	"vo/demoman_gibberish13.wav",
	"vo/demoman_autodejectedtie01.wav"
};

static const char SoundLast[][] =
{
	"vo/taunts/demoman_taunts05.wav",
	"vo/taunts/demoman_taunts04.wav",
	"vo/demoman_specialcompleted07.wav"
};

static const char SoundStab[][] =
{
	"vo/demoman_sf12_badmagic01.wav",
	"vo/demoman_sf12_badmagic07.wav",
	"vo/demoman_sf12_badmagic10.wav"
};

static const char SoundRage[][] =
{
	"vo/demoman_positivevocalization03.wav",
	"vo/demoman_dominationscout05.wav",
	"vo/demoman_cheers02.wav"
};

static const char SoundJump[][] =
{
	"vo/demoman_gibberish07.wav",
	"vo/demoman_gibberish08.wav",
	"vo/demoman_laughshort01.wav",
	"vo/demoman_positivevocalization04.wav"
};

void Easter_Precache(Function &func)
{
	func = Easter_Info;

	PrecacheModel(BossModel, true);
	PrecacheModel(ProjModel, true);

	for(int i=4; i<sizeof(SoundCatch); i++)
	{
		PrecacheSound(SoundCatch[i], true);
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

public void Easter_Info(int client, char[] name, char[] desc, bool setup)
{
	strcopy(name, 64, "Easter Bunny");
	if(setup)
	{
		Hale[client].RoundIntro = Easter_Intro;
		Hale[client].RoundStart = Easter_RoundStart;
		Hale[client].RoundLastman = Easter_Lastman;
		Hale[client].RoundWin = Easter_Win;

		Hale[client].PlayerSpawn = Easter_Spawn;
		Hale[client].PlayerSound = Easter_Sound;
		Hale[client].PlayerVoice = Easter_OnVoice;
		Hale[client].PlayerCommand = Easter_Think;

		Hale[client].PlayerKill = Easter_Kill;
		Hale[client].PlayerDeath = Easter_Death;

		Hale[client].PlayerTakeDamage = Default_TakeDamage;
		//Hale[client].PlayerDealDamage = Easter_DealDamage;

		Hale[client].MiscDesc = Easter_Desc;

		TF2_SetPlayerClass(client, BossWeapon);
	}
	else
	{
		strcopy(desc, 512, "Easter Bunny\nBrave Jump: 6 sec cooldown, x1.2 height, x0.8 distance\nWeighdown: 3 sec cooldown, x6.0 gravity\n \nRage: 2900 damage\nHappy Easter, Fools: 50 eggs\nSentry Stun: 5 seconds\n ");
	}
}

public void Easter_RoundStart(int client)
{
	TF2_SetPlayerClass(client, BossClass);
	Easter_Spawn(client);
}

public Action Easter_OnVoice(int client)
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

	DataPack data;
	CreateDataTimer(0.04, Easter_Raging, data, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
	data.WriteCell(GetClientUserId(client));
	data.WriteCell(50);

	int sound = GetRandomInt(0, sizeof(SoundRage)-1);
	for(int i=1; i<=MaxClients; i++)
	{
		if(Client[i].NoVoice || !IsClientInGame(i))
			continue;

		EmitSoundToClient(i, SoundRage[sound], client, _, SNDLEVEL_TRAFFIC, _, _, _, client);
		EmitSoundToClient(i, SoundRage[sound], client, _, SNDLEVEL_TRAFFIC, _, _, _, client);
	}
	return Plugin_Handled;
}

public void Easter_Intro()
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

public void Easter_Spawn(int client)
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
}

public Action Easter_Sound(int clients[64], int &numClients, char sound[PLATFORM_MAX_PATH], int &client, int &channel, float &volume, int &level, int &pitch, int &flags, char soundEntry[PLATFORM_MAX_PATH], int &seed)
{
	if(channel!=SNDCHAN_VOICE && !(channel==SNDCHAN_STATIC && !StrContains(sound, "vo")))
		return Plugin_Continue;

	strcopy(sound, PLATFORM_MAX_PATH, SoundCatch[GetRandomInt(0, sizeof(SoundCatch)-1)]);
	return Plugin_Changed;
}

public Action Easter_Kill(int client, int victim, char[] logname, char[] iconname)
{
	if(!StrContains(logname, "world", false))
	{
		strcopy(logname, 32, "egg");
		strcopy(iconname, 32, "pumpkindeath");
	}

	SpawnManyObjects(victim);

	if(AlivePlayers < 2)
		return Plugin_Continue;

	float engineTime = GetEngineTime();
	if(Hale[client].SpreeFor < engineTime)
	{
		Hale[client].SpreeNext = false;
		Hale[client].SpreeFor = engineTime+4.0;
	}
	else
	{
		Hale[client].SpreeFor = engineTime+4.0;
		if(Hale[client].SpreeNext)
		{
			Hale[client].SpreeFor = 0.0;
			int sound = GetRandomInt(0, sizeof(SoundSpree)-1);
			for(int i=1; i<=MaxClients; i++)
			{
				if(!IsClientInGame(i) || Client[i].NoVoice)
					continue;

				ClientCommand(i, "playgamesound \"%s\"", SoundSpree[sound]);
				ClientCommand(i, "playgamesound \"%s\"", SoundSpree[sound]);
			}
			return Plugin_Changed;
		}

		Hale[client].SpreeNext = true;
	}

	int sound = GetRandomInt(0, sizeof(SoundKill)-1);
	for(int i=1; i<=MaxClients; i++)
	{
		if(!IsClientInGame(i) || Client[i].NoVoice)
			continue;

		EmitSoundToClient(i, SoundKill[sound], client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, _, NULL_VECTOR, true, 0.0);

		if(i != client)
			EmitSoundToClient(i, SoundKill[sound], client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, _, NULL_VECTOR, true, 0.0);
	}
	return Plugin_Continue;
}

public Action Easter_Death(int client, int attacker, char[] logname, char[] iconname)
{
	SpawnManyObjects(client, 14, 120.0);

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

public Action Easter_TakeDamage(int client, int &attacker, int &inflictor, float &damage, int &damagetype, int &weapon, float damageForce[3], float damagePosition[3], int damagecustom)
{
	if(client==attacker || ((damagetype & DMG_FALL) && attacker<1))
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

		int sound = GetRandomInt(0, sizeof(SoundStab)-1);
		for(int i=1; i<=MaxClients; i++)
		{
			if(!IsClientInGame(i))
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

		PrintHintText(attacker, "You backstabed Easter Bunny!");
		PrintHintText(client, "You got backstabed by %N!", attacker);
		return Plugin_Changed;
	}
	else if((damagetype & DMG_CRUSH) && damage==1000.0 && !IsValidEntity(weapon))
	{
		damage = 3000.34;
		damagetype |= DMG_CRIT|DMG_PREVENT_PHYSICS_FORCE;

		PrintHintTextToAll("Easter Bunny got telefragged!");
		PrintHintText(attacker, "You telefragged Easter Bunny!");
		PrintHintText(client, "You got telefragged by %N!", attacker);
		return Plugin_Changed;
	}

	if(Hale[attacker].Enabled)
		return Plugin_Continue;

	float engineTime = GetEngineTime();
	if(weapon>MaxClients && IsValidEntity(weapon) && HasEntProp(weapon, Prop_Send, "m_iItemDefinitionIndex"))
	{
		int index = GetEntProp(weapon, Prop_Send, "m_iItemDefinitionIndex");
		switch(index)
		{
			case 0, 1, 2, 5, 6, 7, 8, 32, 34, 42, 44, 47:	// Crit-Boosted Weapons
			{
				if(damage > 5)
				{
					damagetype |= DMG_CRIT;
					return Plugin_Changed;
				}
			}
			case 9, 10, 11, 12, 40:	// Shotguns, R.P.G
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
					SetEntPropFloat(medigun, Prop_Send, "m_flChargeLevel", GetEntPropFloat(medigun, Prop_Send, "m_flChargeLevel")+0.02);

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
			case 35:	// Flaregun
			{
				if(damage > 5)
				{
					damage *= 2.0;
					return Plugin_Changed;
				}
			}
			case 37, 46:	// Huntsman, Mine Layer
			{
				if(!(damagetype & DMG_CRIT))
				{
					damage *= 2.0;
					return Plugin_Changed;
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
					return Plugin_Changed;
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
			}
		}
	}
	else if(Hale[client].RageFor > engineTime)
	{
		return Plugin_Handled;
	}
	return Plugin_Continue;
}

/*public Action Easter_DealDamage(int client, int victim, int &inflictor, float &damage, int &damagetype, int &weapon, float damageForce[3], float damagePosition[3], int damagecustom)
{
	if(inflictor > MaxClients)
	{
		damage = TF2_IsPlayerInCondition(victim, TFCond_Kritzkrieged) ? 40.0 : 99.67;
		return Plugin_Changed;
	}

	if(TF2_IsPlayerInCondition(victim, TFCond_Kritzkrieged))
		return Plugin_Continue;

	damage *= 3.0;
	return Plugin_Changed;
}*/

public Action Easter_Attack(int client, int weapon, const char[] classname, bool &result)
{
	result = false;
	return Plugin_Changed;
}

public Action Easter_Think(int client, int &buttons)
{
	if(!IsPlayerAlive(client))
		return Plugin_Continue;

	SetEntityHealth(client, Hale[client].Health);
	SetEntPropFloat(client, Prop_Send, "m_flMaxspeed", 345.0+0.7*(100-Hale[client].Health*100/Hale[client].MaxHealth));

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

					velocity[2] = (750 + (chargePercent / 3.5) * 13.0);
					if(Hale[client].JumpDuper)
					{
						velocity[2] += 2000;
						Hale[client].JumpDuper = false;
					}

					SetEntProp(client, Prop_Send, "m_bJumping", 1);
					velocity[0] *= (1 + Sine((chargePercent / 4.5) * FLOAT_PI / 50));
					velocity[1] *= (1 + Sine((chargePercent / 4.5) * FLOAT_PI / 50));

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

	if(buttons & IN_ATTACK2)
	{
		buttons &= ~IN_ATTACK2;
		return Plugin_Changed;
	}
	return Plugin_Continue;
}

public void Easter_Lastman()
{
	int sound = GetRandomInt(0, sizeof(SoundLast)-1);
	for(int i=1; i<=MaxClients; i++)
	{
		if(IsClientInGame(i))
			ClientCommand(i, "playgamesound \"%s\"", SoundLast[sound]);
	}
}

public void Easter_Win()
{
	int sound = GetRandomInt(0, sizeof(SoundWin)-1);
	for(int i=1; i<=MaxClients; i++)
	{
		if(IsClientInGame(i))
			ClientCommand(i, "playgamesound \"%s\"", SoundWin[sound]);
	}
}

public void Easter_Desc(int client, char[] buffer)
{
	strcopy(buffer, 512, "Easter Bunny\n \nBrave Jump: Hold ALT-FIRE, look up, and release ALT-FIRE\nWeighdown: Look down and DUCK\nHappy Easter, Fools: Call for a medic when rage is ready\n ");
}

public Action Easter_Raging(Handle timer, DataPack data)
{
	data.Reset();
	int client = GetClientOfUserId(data.ReadCell());
	if(!client || !IsClientInGame(client))
		return Plugin_Stop;

	int entity = CreateEntityByName("tf_projectile_pipe");
	if(!IsValidEntity(entity))
		return Plugin_Stop;

	SetEntPropEnt(entity, Prop_Send, "m_hOwnerEntity", client);
	SetEntProp(entity, Prop_Send, "m_bCritical", 1);

	static float pos[3];
	{
		int team = GetClientTeam(client);
		SetEntProp(entity, Prop_Send, "m_iTeamNum", team, 1);

		GetEntPropVector(client, Prop_Send, "m_vecOrigin", pos);
		pos[2] += 63;
		TeleportEntity(entity, pos, NULL_VECTOR, NULL_VECTOR);

		SetVariantInt(team);
		AcceptEntityInput(entity, "TeamNum", -1, -1, 0);
		SetVariantInt(team);
		AcceptEntityInput(entity, "SetTeam", -1, -1, 0);
	}

	DispatchSpawn(entity);

	{
		pos[0] = GetRandomFloat(-600.0, 600.0);
		pos[1] = GetRandomFloat(-600.0, 600.0);
		pos[2] = GetRandomFloat(300.0, 1000.0);
		TeleportEntity(entity, NULL_VECTOR, NULL_VECTOR, pos);
	}

	SetEntityModel(entity, ProjModel);
	CreateTimer(1.9, Easter_Explode, EntIndexToEntRef(entity), TIMER_FLAG_NO_MAPCHANGE);

	int count = data.ReadCell();
	if(count < 1)
		return Plugin_Stop;

	data.Position--;
	data.WriteCell(count-1, false);
	return Plugin_Continue;
}

public Action Easter_Explode(Handle timer, int ref)
{
	int entity = EntRefToEntIndex(ref);
	if(entity>MaxClients && IsValidEntity(entity))
	{
		static float position[3];
		GetEntPropVector(entity, Prop_Send, "m_vecOrigin", position);

		int client = GetEntPropEnt(entity, Prop_Send, "m_hOwnerEntity");
		int team = GetConVarBool(FindConVar("mp_friendlyfire")) ? -1 : GetClientTeam(client);
		for(int target=1; target<=MaxClients; target++)
		{
			if(client==target || !IsClientInGame(target) || !IsPlayerAlive(target) || GetClientTeam(target)==team)
				continue;

			static float position2[3];
			GetEntPropVector(target, Prop_Send, "m_vecOrigin", position2);
			float distance = GetVectorDistance(position, position2);
			if(distance > 250)
				continue;

			SDKHooks_TakeDamage(target, client, client, 95.0-(80.0*(distance/250.0)), DMG_BLAST|DMG_CRIT);
		}
	}
	return Plugin_Continue;
}

static void SpawnManyObjects(int client, int amount=3, float distance=30.0)
{
	static float position[3];
	GetClientAbsOrigin(client, position);
	position[2] += distance;
	for(int i; i<amount; i++)
	{
		int entity = CreateEntityByName("tf_ammo_pack");
		if(!IsValidEntity(entity))
			return;

		SetEntityModel(entity, ProjModel);
		DispatchKeyValue(entity, "OnPlayerTouch", "!self,Kill,,0,-1");
		SetEntProp(entity, Prop_Send, "m_nSkin", GetClientTeam(client)-2);
		SetEntProp(entity, Prop_Send, "m_nSolidType", 6);
		SetEntProp(entity, Prop_Send, "m_usSolidFlags", 152);
		SetEntProp(entity, Prop_Send, "m_triggerBloat", 24);
		SetEntProp(entity, Prop_Send, "m_CollisionGroup", 1);
		SetEntPropEnt(entity, Prop_Send, "m_hOwnerEntity", client);
		SetEntProp(entity, Prop_Send, "m_iTeamNum", 2);
		DispatchSpawn(entity);

		position[0] += GetRandomFloat(-5.0, 5.0);
		position[1] += GetRandomFloat(-5.0, 5.0);

		{
			static float velocity[3];
			velocity[0] = GetRandomFloat(-400.0, 400.0);
			velocity[1] = GetRandomFloat(-400.0, 400.0);
			velocity[2] = GetRandomFloat(300.0, 500.0);
			static float angle[] = {90.0, 0.0, 0.0};
			TeleportEntity(entity, position, angle, velocity);
		}

		SetEntProp(entity, Prop_Data, "m_iHealth", 900);
		//SetEntData(entity, GetEntSendPropOffs(entity, "m_vecInitialVelocity", true)-4, 1, _, true);
	}
}