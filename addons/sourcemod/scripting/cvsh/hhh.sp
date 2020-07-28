#define BOSS_HHH	4

static const char BossModel[] = "models/player/saxton_hale/hhh_jr_mk3.mdl";
static const TFClassType BossClass = TFClass_DemoMan;
static const int RageDamage = 3000;

static const char Downloads[][] =
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

	"models/player/saxton_hale/hhh_jr_mk3.dx80.vtx",
	"models/player/saxton_hale/hhh_jr_mk3.dx90.vtx",
	"models/player/saxton_hale/hhh_jr_mk3.mdl",
	"models/player/saxton_hale/hhh_jr_mk3.sw.vtx",
	"models/player/saxton_hale/hhh_jr_mk3.vvd",

	"sound/freak_fortress_2/hhh/hhh_bgm.mp3",
};

static const char BGMusic[] = "#freak_fortress_2/hhh/hhh_bgm.mp3";
static const char SoundIntro[] = "ui/halloween_boss_summoned_fx.wav";
static const char SoundDeath[] = "vo/halloween_boss/knight_dying.wav";
static const char SoundWin[] = "vo/halloween_boss/knight_spawn.wav";
static const char SoundRage[] = "vo/halloween_boss/knight_alert.wav";
static const char SoundLose[] = "ui/halloween_boss_defeated.wav";

static const char SoundTele[][] =
{
	"vo/halloween_boss/knight_alert01.wav",
	"vo/halloween_boss/knight_alert02.wav"
};

static const char SoundKill[][] =
{
	"vo/halloween_boss/knight_attack01.wav",
	"vo/halloween_boss/knight_attack02.wav",
	"vo/halloween_boss/knight_attack03.wav",
	"vo/halloween_boss/knight_attack04.wav"
};

static const char SoundSpree[][] =
{
	"vo/halloween_boss/knight_laugh01.wav",
	"vo/halloween_boss/knight_laugh02.wav",
	"vo/halloween_boss/knight_laugh03.wav",
	"vo/halloween_boss/knight_laugh04.wav"
};

static const char SoundStab[][] =
{
	"vo/halloween_boss/knight_death01.wav",
	"vo/halloween_boss/knight_death02.wav",
	"vo/halloween_boss/knight_pain01.wav",
	"vo/halloween_boss/knight_pain02.wav",
	"vo/halloween_boss/knight_pain03.wav"
};

void HHH_Precache(Function &func)
{
	func = HHH_Info;

	PrecacheModel(BossModel, true);
	PrecacheSound(BGMusic, true);
	PrecacheSound(SoundIntro, true);
	PrecacheSound(SoundDeath, true);
	PrecacheSound(SoundWin, true);
	PrecacheSound(SoundRage, true);
	PrecacheSound(SoundLose, true);

	for(int i; i<sizeof(SoundTele); i++)
	{
		PrecacheSound(SoundTele[i], true);
	}

	for(int i; i<sizeof(SoundKill); i++)
	{
		PrecacheSound(SoundKill[i], true);
	}

	for(int i; i<sizeof(SoundSpree); i++)
	{
		PrecacheSound(SoundSpree[i], true);
	}

	for(int i; i<sizeof(SoundStab); i++)
	{
		PrecacheSound(SoundStab[i], true);
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

public void HHH_Info(int client, char[] name, char[] desc, bool setup)
{
	strcopy(name, 64, "Horseless Headless Horsemann Jr.");
	if(setup)
	{
		Hale[client].RoundIntro = HHH_Intro;
		Hale[client].RoundStart = HHH_RoundStart;
		Hale[client].RoundWin = HHH_Win;
		Hale[client].RoundEnd = HHH_RoundEnd;

		Hale[client].PlayerSpawn = HHH_Spawn;
		Hale[client].PlayerSound = Default_Sound;
		Hale[client].PlayerVoice = HHH_OnRage;
		Hale[client].PlayerCommand = HHH_Think;

		Hale[client].PlayerKill = HHH_Kill;
		Hale[client].PlayerDeath = HHH_Death;

		Hale[client].PlayerTakeDamage = HHH_TakeDamage;

		Hale[client].MiscDesc = HHH_Desc;

		TF2_SetPlayerClass(client, HALECLASS);
	}
	else
	{
		strcopy(desc, 512, "Horseless Headless Horsemann Jr.\nTeleportation: 20 sec cooldown, 2.5 sec stun\nWeighdown: 3 sec cooldown, x6.0 gravity\nHeavyweight: 250 damage limit\n \nRage: 3000 damage\nPlayer Stun: 5 seconds, x3.0 range\nSentry Stun: 7 seconds\n ");
	}
}

public void HHH_RoundStart(int client)
{
	TF2_SetPlayerClass(client, BossClass);
	HHH_Spawn(client);
}

public Action HHH_OnRage(int client)
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

	float engineTime = GetEngineTime()+5.0;
	Hale[client].RageFor = engineTime+2.0;

	int team = GetClientTeam(client);
	bool friendlyFire = GetConVarBool(FindConVar("mp_friendlyfire"));
	for(int target=1; target<=MaxClients; target++)
	{
		if(!IsClientInGame(target))
			continue;

		if(!Client[target].NoVoice)
		{
			ClientCommand(target, "playgamesound %s", SoundRage);
			ClientCommand(target, "playgamesound %s", SoundRage);
		}

		if(target==client || !IsPlayerAlive(target) || TF2_IsPlayerInCondition(target, TFCond_Ubercharged) || (!friendlyFire && GetClientTeam(target)==team))
			continue;

		static float position2[3];
		GetEntPropVector(target, Prop_Send, "m_vecOrigin", position2);
		if(GetVectorDistance(position, position2) > 2400)
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

public void HHH_Intro()
{
	for(int i=1; i<=MaxClients; i++)
	{
		if(!IsClientInGame(i) || Client[i].NoVoice)
			continue;

		ClientCommand(i, "playgamesound \"%s\"", SoundIntro);
		ClientCommand(i, "playgamesound \"%s\"", SoundIntro);
	}
}

public void HHH_Spawn(int client)
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

public Action HHH_Kill(int attacker, int client, char[] logname, char[] iconname)
{
	strcopy(logname, 32, "headtaker");
	strcopy(iconname, 32, "skull_tf");

	float engineTime = GetEngineTime();
	if(Hale[client].SpreeFor < engineTime)
	{
		Hale[client].SpreeNext = false;
		Hale[client].SpreeFor = engineTime+4.0;
		return Plugin_Changed;
	}

	Hale[client].SpreeFor = engineTime+4.0;
	if(!Hale[client].SpreeNext)
	{
		Hale[client].SpreeNext = true;
		return Plugin_Changed;
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
	return Plugin_Changed;
}

public Action HHH_Death(int client, int attacker, char[] logname, char[] iconname)
{
	for(int i=1; i<=MaxClients; i++)
	{
		if(!IsClientInGame(i) || Client[i].NoVoice)
			continue;

		ClientCommand(i, "playgamesound \"%s\"", SoundDeath);
		ClientCommand(i, "playgamesound \"%s\"", SoundDeath);
	}
	return Plugin_Continue;
}

public void HHH_RoundEnd(int client, int team)
{
	if(!team || GetClientTeam(client)==team)
		return;

	for(int i=1; i<=MaxClients; i++)
	{
		if(!IsClientInGame(i) || Client[i].NoMusic)
			continue;

		ClientCommand(i, "playgamesound \"%s\"", SoundLose);
		ClientCommand(i, "playgamesound \"%s\"", SoundLose);
	}
}

public Action HHH_Think(int client, int &buttons)
{
	if(!IsPlayerAlive(client))
		return Plugin_Continue;

	SetEntityHealth(client, Hale[client].Health);
	SetEntPropFloat(client, Prop_Send, "m_flMaxspeed", 330.0+0.7*(100-Hale[client].Health*100/Hale[client].MaxHealth));

	static float eyeAngles[3];
	float engineTime = GetEngineTime();
	float chargePercent = 0.0;
	if(Hale[client].JumpReadyAt < engineTime)
	{
		if(Hale[client].JumpChargeFrom)
		{
			// has key been released?
			if(!(buttons & CHARGE_BUTTON) && (Hale[client].JumpDuper || Hale[client].JumpChargeFrom>engineTime+3.0))
			{
				// is user's eye angle valid? if so, perform the jump
				GetClientEyeAngles(client, eyeAngles);
				if(eyeAngles[0] <= JUMP_TELEPORT_MAX_ANGLE)
				{
					if(TeleportToPlayer(client, Hale[client].JumpDuper ? 4.0 : 2.5))
					{
						// unlike the original, I'm managing cooldown myself. so lets do it now.
						Hale[client].JumpReadyAt = engineTime+20.0;

						// emergency teleport no longer needs to be ready
						Hale[client].JumpDuper = false;

						int sound = GetRandomInt(0, sizeof(SoundTele)-1);
						for(int i=1; i<=MaxClients; i++)
						{
							if(!IsClientInGame(i) || Client[i].NoVoice)
								continue;

							EmitSoundToClient(i, SoundTele[sound], client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, position, NULL_VECTOR, true, 0.0);
							EmitSoundToClient(i, SoundTele[sound], client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, position, NULL_VECTOR, true, 0.0);

							if(i == client)
								continue;

							EmitSoundToClient(i, SoundTele[sound], client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, position, NULL_VECTOR, true, 0.0);
							EmitSoundToClient(i, SoundTele[sound], client, _, SNDLEVEL_TRAFFIC, SND_NOFLAGS, SNDVOL_NORMAL, 100, client, position, NULL_VECTOR, true, 0.0);
						}
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
			ShowSyncHudText(client, PlayerHud, "Quick Teleport is ready.\nLook up, press and release ALT-FIRE.");
		}
		else if(chargePercent > 99)
		{
			SetHudTextParams(-1.0, HUD_Y, HUD_INTERVAL+HUD_LINGER, HUD_R_OK, HUD_G_OK, HUD_B_OK, HUD_ALPHA);
			ShowSyncHudText(client, PlayerHud, "Teleportation is ready. 100 percent charged.\nLook up and release ALT-FIRE.");
		}
		else if(Hale[client].JumpReadyAt < engineTime)
		{
			SetHudTextParams(-1.0, HUD_Y, HUD_INTERVAL+HUD_LINGER, HUD_R_OK, HUD_G_OK, HUD_B_OK, HUD_ALPHA);
			ShowSyncHudText(client, PlayerHud, "Teleportation is not ready. %.0f percent charged.\nPress and hold ALT-FIRE.", chargePercent);
		}
		else
		{
			SetHudTextParams(-1.0, HUD_Y, HUD_INTERVAL+HUD_LINGER, HUD_R_ERROR, HUD_G_ERROR, HUD_B_ERROR, HUD_ALPHA);
			ShowSyncHudText(client, PlayerHud, "Teleportation is not ready. %.1f seconds remaining.", Hale[client].JumpReadyAt-engineTime);
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

public Action HHH_TakeDamage(int client, int &attacker, int &inflictor, float &damage, int &damagetype, int &weapon, float damageForce[3], float damagePosition[3], int damagecustom)
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
		SetEntPropFloat(weapon, Prop_Send, "m_flNextPrimaryAttack", GetGameTime()+1.5);
		SetEntProp(weapon, Prop_Send, "m_bLandedCrit", 1);
		SetEntPropFloat(attacker, Prop_Send, "m_flNextAttack", GetGameTime()+1.5);
		SetEntPropFloat(attacker, Prop_Send, "m_flStealthNextChangeTime", GetGameTime()+1.0);

		PrintHintText(attacker, "You backstabed Headless Horseless Horsemann Jr!");
		PrintHintText(client, "You got backstabed by %N!", attacker);
		return Plugin_Changed;
	}
	else if((damagetype & DMG_CRUSH) && damage==1000.0 && !IsValidEntity(weapon))
	{
		damage = 3000.34;
		damagetype |= DMG_CRIT|DMG_PREVENT_PHYSICS_FORCE;

		PrintHintTextToAll("Headless Horseless Horsemann Jr. got telefragged!");
		PrintHintText(attacker, "You telefragged Headless Horseless Horsemann Jr!");
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
				case 0, 1, 2, 3, 5, 6, 7, 8, 32, 37, 3003, 3005, 3008:	// Melee weapons
				{
					damagetype |= DMG_CRIT;
				}
				case 9, 10, 11, 12, 3001:	// Shotguns, R.P.G
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
				case 39:	// Flaregun
				{
					damagetype |= DMG_PREVENT_PHYSICS_FORCE;
					if(damage > 5)
						damage *= 2.0;
				}
				case 56:	// Huntsman
				{
					if(!(damagetype & DMG_CRIT))
					{
						damage *= 2.0;
						damagetype |= DMG_PREVENT_PHYSICS_FORCE;
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
						damagetype |= DMG_PREVENT_PHYSICS_FORCE;
					}
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
	else
	{
		damagetype |= DMG_PREVENT_PHYSICS_FORCE;
	}
	return Plugin_Changed;
}

public void HHH_Win()
{
	for(int i=1; i<=MaxClients; i++)
	{
		if(IsClientInGame(i))
			ClientCommand(i, "playgamesound \"%s\"", SoundWin);
	}
}

public void HHH_Desc(int client, char[] buffer)
{
	strcopy(buffer, 512, "Saxton Hale\n \nBrave Jump: Hold ALT-FIRE, look up, and release ALT-FIRE\nWeighdown: Look down and DUCK\nAnchor: Hold DUCK on the ground\nStun: Call for a medic when rage is ready\n ");
}

// Dynamic Defaults FF2
bool TeleportToPlayer(int clientIdx, float stunTime=0.0, bool tryAbove=true, bool trySide=true, bool sameTeam=false, bool reverseTeleport=false)
{
	// teleport code, which only uses light sprinkles of the original
	int target = FindRandomPlayer(GetClientTeam(clientIdx) == BossTeam ? sameTeam : !sameTeam, NULL_VECTOR, 0.0, false, clientIdx, true);
	if (IsLivingPlayer(target))
	{
		// the rare practical use for an xor swap :p
		if (reverseTeleport)
		{
			clientIdx ^= target;
			target ^= clientIdx;
			clientIdx ^= target;
		}
		
		static float targetOrigin[3];
		static float teleportCoords[3];
		bool coordsSet = false;
		bool mayNeedToDuck = false;
		GetEntPropVector(target, Prop_Send, "m_vecOrigin", targetOrigin);

		if (GetEntPropFloat(clientIdx, Prop_Send, "m_flModelScale") < GetEntPropFloat(target, Prop_Send, "m_flModelScale"))
		{
			tryAbove = false;
			trySide = false;
		}

		// try teleporting above
		if (!coordsSet && tryAbove)
			coordsSet = TestTeleportLocation(clientIdx, targetOrigin, teleportCoords, 0.0, 0.0, 85.0);

		// try teleporting to the side. also, lol at this little arrangement.
		if (!coordsSet && trySide)
			if (!(coordsSet = TestTeleportLocation(clientIdx, targetOrigin, teleportCoords, 50.0, 0.0, 0.0)))
				if (!(coordsSet = TestTeleportLocation(clientIdx, targetOrigin, teleportCoords, -50.0, 0.0, 0.0)))
					if (!(coordsSet = TestTeleportLocation(clientIdx, targetOrigin, teleportCoords, 0.0, 50.0, 0.0)))
						coordsSet = TestTeleportLocation(clientIdx, targetOrigin, teleportCoords, 0.0, -50.0, 0.0);

		// hellooooooo up there...also, if all these have failed, time to fall back to what is guaranteed to work
		if (!coordsSet)
		{
			coordsSet = true;
			mayNeedToDuck = true;
			teleportCoords[0] = targetOrigin[0];
			teleportCoords[1] = targetOrigin[1];
			teleportCoords[2] = targetOrigin[2];
		}

		// stun before teleport
		if (stunTime > 0.0)
		{
			Client[target].LastWeapon = GetEntPropEnt(target, Prop_Send, "m_hActiveWeapon");
			Client[target].StunFor = stunTime;

			SetEntPropEnt(client, Prop_Send, "m_hActiveWeapon", -1);
			SetEntPropFloat(client, Prop_Send, "m_flNextAttack", FAR_FUTURE);
		}

		// now, teleport!
		if (mayNeedToDuck)
		{
			// credit to FF2 base for this "force ducking" code
			SetEntPropVector(clientIdx, Prop_Send, "m_vecMaxs", view_as<float>({24.0, 24.0, 62.0}));
			SetEntProp(clientIdx, Prop_Send, "m_bDucked", 1);
			SetEntityFlags(clientIdx, GetEntityFlags(clientIdx) | FL_DUCKING);
		}
		TeleportEntity(clientIdx, teleportCoords, NULL_VECTOR, view_as<float>({0.0, 0.0, 0.0}));
		return true;
	}
	
	return false;
}

static bool TestTeleportLocation(int clientIdx, float origin[3], float targetPos[3], float xOffset, float yOffset, float zOffset)
{
	// test the path to the offset, ensure no obstructions
	static float endPos[3];
	targetPos[0] = origin[0] + xOffset;
	targetPos[1] = origin[1] + yOffset;
	targetPos[2] = origin[2] + zOffset;
	
	static float mins[3];
	static float maxs[3];
	GetEntPropVector(clientIdx, Prop_Send, "m_vecMins", mins);
	GetEntPropVector(clientIdx, Prop_Send, "m_vecMaxs", maxs);
	Handle trace = TR_TraceHullFilterEx(origin, targetPos, mins, maxs, MASK_PLAYERSOLID, TraceWallsOnly);
	TR_GetEndPosition(endPos, trace);
	CloseHandle(trace);
	
	// first, the distance check
	if (GetVectorDistance(origin, endPos, true) < GetVectorDistance(origin, targetPos, true))
		return false;
		
	// if this is just a teleport above, we've already succeeded
	if (xOffset == 0.0 && yOffset == 0.0)
		return true;
		
	// otherwise, do the pit test, ensuring the teleporter doesn't teleport above a hole (don't want unreachable players)
	static float pitFailPos[3];
	pitFailPos[0] = targetPos[0];
	pitFailPos[1] = targetPos[1];
	pitFailPos[2] = targetPos[2] - 40.0;
	trace = TR_TraceHullFilterEx(targetPos, pitFailPos, mins, maxs, MASK_PLAYERSOLID, TraceWallsOnly);
	TR_GetEndPosition(endPos, trace);
	CloseHandle(trace);
	
	// success!
	return GetVectorDistance(targetPos, endPos, true)<GetVectorDistance(targetPos, pitFailPos, true);
}