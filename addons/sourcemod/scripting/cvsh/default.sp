#define BOSS_DEFAULT	0

static const float RageDamage = 1900.0;

public void Default_RoundStart(int client)
{
	Default_Spawn(client);
}

public Action Default_OnVoice(int client)
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

	Hale[client].RageFor = GetEngineTime()+5.0;

	int team = GetClientTeam(client);
	bool friendlyFire = GetConVarBool(FindConVar("mp_friendlyfire"));
	for(int target=1; target<=MaxClients; target++)
	{
		if(target==client || !IsClientInGame(target))
			continue;

		if(!IsPlayerAlive(target) || TF2_IsPlayerInCondition(target, TFCond_Ubercharged) || (!friendlyFire && GetClientTeam(target)==team))
			continue;

		static float position2[3];
		GetEntPropVector(target, Prop_Send, "m_vecOrigin", position2);
		if(GetVectorDistance(position, position2) > 800)
			continue;

		Client[target].LastWeapon = GetEntPropEnt(target, Prop_Send, "m_hActiveWeapon");
		Client[target].StunFor = Hale[client].RageFor;
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
				CreateTimer(7.0, Default_EnableBuilding, EntIndexToEntRef(sentry), TIMER_FLAG_NO_MAPCHANGE);
			}
		}
	}*/
	return Plugin_Handled;
}

/*public Action Default_EnableBuilding(Handle timer, any sentryid)
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

public void Default_Spawn(int client)
{
	TF2_RemoveWeaponSlot(client, 0);
	TF2_RemoveWeaponSlot(client, 1);
	TF2_RemoveWeaponSlot(client, 3);
	TF2_RemoveWeaponSlot(client, 4);
	TF2_RemoveWeaponSlot(client, 5);
	TF2_AddCondition(client, TFCond_RestrictToMelee);
}

public Action Default_Sound(int clients[64], int &numClients, char sound[PLATFORM_MAX_PATH], int &client, int &channel, float &volume, int &level, int &pitch, int &flags, char soundEntry[PLATFORM_MAX_PATH], int &seed)
{
	return (channel==SNDCHAN_VOICE || (channel==SNDCHAN_STATIC && !StrContains(sound, "vo"))) ? Plugin_Stop : Plugin_Continue;
}

public Action Default_Think(int client, int &buttons)
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
			ShowSyncHudText(client, PlayerHud, "Super DUPER Jump is ready.\nLook up, press and release ALT-FIRE.");
		}
		else if(Hale[client].JumpReadyAt < engineTime)
		{
			SetHudTextParams(-1.0, HUD_Y, HUD_INTERVAL+HUD_LINGER, HUD_R_OK, HUD_G_OK, HUD_B_OK, HUD_ALPHA);
			ShowSyncHudText(client, PlayerHud, "Super Jump is ready. %.0f percent charged.\nLook up, press and release ALT-FIRE.", chargePercent);
		}
		else
		{
			SetHudTextParams(-1.0, HUD_Y, HUD_INTERVAL+HUD_LINGER, HUD_R_ERROR, HUD_G_ERROR, HUD_B_ERROR, HUD_ALPHA);
			ShowSyncHudText(client, PlayerHud, "Super Jump is not ready. %.1f seconds remaining.", Hale[client].JumpReadyAt-engineTime);
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

public Action Default_TakeDamage(int client, int &attacker, int &inflictor, float &damage, int &damagetype, int &weapon, float damageForce[3], float damagePosition[3], int damagecustom)
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

		float gameTime = GetGameTime();
		SetEntPropFloat(weapon, Prop_Send, "m_flNextPrimaryAttack", gameTime+1.5);
		SetEntProp(weapon, Prop_Send, "m_bLandedCrit", 1);
		SetEntPropFloat(attacker, Prop_Send, "m_flNextAttack", gameTime+1.5);
		SetEntPropFloat(attacker, Prop_Send, "m_flStealthNextChangeTime", gameTime+1.0);

		PrintHintText(attacker, "You backstabed %s!", Hale[client].Name);
		PrintHintText(client, "You got backstabed by %N!", attacker);
		return Plugin_Changed;
	}
	else if((damagetype & DMG_CRUSH) && damage==1000.0 && !IsValidEntity(weapon))
	{
		damage = 3000.34;
		damagetype |= DMG_CRIT|DMG_PREVENT_PHYSICS_FORCE;

		PrintHintTextToAll("%s got telefragged!", Hale[client].Name);
		PrintHintText(attacker, "You telefragged %s!", Hale[client].Name);
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
			case 0, 1, 2, 5, 6, 7, 8, 32, 34, 42, 43, 44, 47:	// Crit-Boosted Weapons
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

public void Default_Desc(int client, char[] buffer)
{
	Format(buffer, 512, "%s\n \nNo boss description\n ", Hale[client].Name);
}