#define BOSS_JOKE 6

static const char BossModel[] = "models/custom/vsh/buffvillian.mdl";
static const TFClassType BossClass = TFClass_Heavy;
static const int RageDamage = 2800;

static const char Downloads[][] =
{
	"models/custom/vsh/buffvillian.dx80.vtx",
	"models/custom/vsh/buffvillian.dx90.vtx",
	"models/custom/vsh/buffvillian.mdl",
	"models/custom/vsh/buffvillian.phy",
	"models/custom/vsh/buffvillian.sw.vtx",
	"models/custom/vsh/buffvillian.vvd"
};

void Joke_Precache(Function &func)
{
	func = Joke_Info;

	PrecacheModel(BossModel, true);

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

public void Joke_Info(int client, char[] name, char[] desc, bool setup)
{
	strcopy(name, 64, "Henchman");
	if(setup)
	{
		Hale[client].RoundStart = Joke_RoundStart;

		Hale[client].PlayerSpawn = Joke_Spawn;
		Hale[client].PlayerSound = Joke_Sound;
		Hale[client].PlayerVoice = Joke_OnRage;
		Hale[client].PlayerCommand = Joke_Think;
		Hale[client].PlayerTakeDamage = Joke_TakeDamage;

		Hale[client].MiscDesc = Joke_Desc;

		TF2_SetPlayerClass(client, BossClass);
	}
	else
	{
		strcopy(desc, 512, "Henchman\nBrave Jump: 6 sec cooldown, x1.0 height, x1.0 distance\nWeighdown: 3 sec cooldown, x6.0 gravity\nAnchor: unlimited use\n \nRage: 2800 damage\nPlayer Stun: 5 seconds, x1.0 range\nSentry Stun: 7 seconds\n ");
	}
}

public void Joke_RoundStart(int client)
{
	Joke_Spawn(client);
}

public Action Joke_OnRage(int client)
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
		if(target==client || !IsClientInGame(target) || !IsPlayerAlive(target) || TF2_IsPlayerInCondition(target, TFCond_Ubercharged) || (!friendlyFire && GetClientTeam(target)==team))
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

public void Joke_Spawn(int client)
{
	TF2_SetPlayerClass(client, BossClass);

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

public Action Joke_Sound(int clients[MAXPLAYERS], int &numClients, char sound[PLATFORM_MAX_PATH], int &client, int &channel, float &volume, int &level, int &pitch, int &flags, char soundEntry[PLATFORM_MAX_PATH], int &seed)
{
	if(channel!=SNDCHAN_VOICE && !(channel==SNDCHAN_STATIC && !StrContains(sound, "vo")))
		return Plugin_Continue;

	static float delay[MAXPLAYERS+1];
	float time = GetGameTime();
	if(delay[client] > time)
		return Plugin_Stop;

	delay[client] = time+1.0;
	ReplaceString(sound, PLATFORM_MAX_PATH, "heavy", "civilian", false);
	if(!FileExists(sound, true))
		return Plugin_Stop;

	for(int i=1; i<=MaxClients; i++)
	{
		if(!IsClientInGame(i) || Client[i].NoVoice)
			continue;

		ClientCommand(i, "playgamesound \"%s\"", sound);
		ClientCommand(i, "playgamesound \"%s\"", sound);
	}
	return Plugin_Stop;
}

public Action Joke_Think(int client, int &buttons)
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

	if(!(buttons & IN_ATTACK2))
		return Plugin_Continue;

	buttons &= ~IN_ATTACK2;
	return Plugin_Changed;
}

public Action Joke_TakeDamage(int client, int &attacker, int &inflictor, float &damage, int &damagetype, int &weapon, float damageForce[3], float damagePosition[3], int damagecustom)
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

		EmitSoundToClient(client, "player/crit_received3.wav", _, _, _, _, 0.7, _, _, _, _, false);
		EmitSoundToClient(attacker, "player/crit_received3.wav", _, _, _, _, 0.7, _, _, _, _, false);
		SetEntPropFloat(weapon, Prop_Send, "m_flNextPrimaryAttack", GetGameTime()+1.5);
		SetEntProp(weapon, Prop_Send, "m_bLandedCrit", 1);
		SetEntPropFloat(attacker, Prop_Send, "m_flNextAttack", GetGameTime()+1.5);
		SetEntPropFloat(attacker, Prop_Send, "m_flStealthNextChangeTime", GetGameTime()+1.0);

		PrintHintText(attacker, "You backstabed Henchman!");
		PrintHintText(client, "You got backstabed by %N!", attacker);
		return Plugin_Changed;
	}
	else if((damagetype & DMG_CRUSH) && damage==1000.0 && !IsValidEntity(weapon))
	{
		damage = 3000.34;
		damagetype |= DMG_CRIT|DMG_PREVENT_PHYSICS_FORCE;

		PrintHintTextToAll("Henchman got telefragged!");
		PrintHintText(attacker, "You telefragged Henchman!");
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
				case 3004:	// Tranquilizer
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
	}
	return changed ? Plugin_Changed : Plugin_Continue;
}

public void Joke_Desc(int client, char[] buffer)
{
	strcopy(buffer, 512, "Henchman\n \nBrave Jump: Hold ALT-FIRE, look up, and release ALT-FIRE\nWeighdown: Look down and DUCK\nAnchor: Hold DUCK on the ground\nStun: Call for a medic when rage is ready\n ");
}