#define MODULE_MENU

static void Changelog(int &page, char[] buffer, int length)
{
	switch(page)
	{
		case 0:
		{
			strcopy(buffer, length, "Changelog: 1.0.0\n \n- Added Vagineer\n ");
		}
		case 1:
		{
			strcopy(buffer, length, "Changelog: 1.0.1\n \n- Fixed bosses not being able to see the top damage hud\n ");
		}
		case 2:
		{
			strcopy(buffer, length, "Changelog: 1.1.0 Fixes\n \n- Fixed bosses not being able to suicide after the round ended\n- Spectators now see the intro hud\n- Fixed Vagineer saying lastman and kill streak sounds at once\n ");
		}
		case 3:
		{
			strcopy(buffer, length, "Changelog: 1.1.0 Changes\n \n- Added Christian Brutal Sniper\n- Decreased Vagineer's damage to full rage from 2800 to 2700\n ");
		}
		case 4:
		{
			strcopy(buffer, length, "Changelog: 1.2.0 Balance Changes\n \n- Airblasts now give rage\n- Sniper Rifles now outline bosses\n- Flaregun now gains critical damage bonus\n- Decreased Christian Brutal Sniper's jump cooldown\n- Removed scopes for Christian Brutal Sniper\n ");
		}
		case 5:
		{
			strcopy(buffer, length, "Changelog: 1.2.0 Features\n \n- Added the main menu\n- Added queue point info\n- Added class change info\n ");
		}
		case 6:
		{
			strcopy(buffer, length, "Changelog: 1.2.1\n \n- Added boss selection\n- Fixed Gunboats not giving fall damage resistance\n- Fixed bosses not gaining extra hazard jump height\n- Removed first arena round\n ");
		}
		case 7:
		{
			strcopy(buffer, length, "Changelog: 1.3.0 Balance Changes\n \n- Increased Christian Brutal Sniper's bleed damage from 4 to 18 a tick\n- Decreased Christian Brutal Sniper's Fishwhacker damage from 390 to 300\n- Decreased Sniper Rifle damage from base 100 to 75\n ");
		}
		case 8:
		{
			strcopy(buffer, length, "Changelog: 1.3.0 Features\n \n- Added four-team boss vs boss mode\n- Added a changelog\n- Fixed critical hits not outlining bosses\n ");
		}
		case 9:
		{
			strcopy(buffer, length, "Changelog: 1.3.1\n \n- Added user settings\n- Added option to disable being the boss\n- Boss selection is now saved between reconnects\n- Reduced lag with high player counts\n ");
		}
		default:
		{
			strcopy(buffer, length, "Changelog: 1.4.0\n \n- Added Headless Horseless Horsemann Jr.\n- Fixed Syringe Guns not gaining uber on hit\n- Fixed crit-boosted weapons flickering");
			page = 10;
		}
	}
}

void Menu_PluginStart()
{
	RegConsoleCmd("hale", Menu_MainC, "Visit the main menu");
	RegConsoleCmd("ff2", Menu_MainC, "Visit the main menu");
	RegConsoleCmd("vsh", Menu_MainC, "Visit the main menu");

	RegConsoleCmd("hale_next", Menu_QueueC, "See your current queue points");
	RegConsoleCmd("halenext", Menu_QueueC, "See your current queue points");
	RegConsoleCmd("ff2_next", Menu_QueueC, "See your current queue points");
	RegConsoleCmd("ff2next", Menu_QueueC, "See your current queue points");
	RegConsoleCmd("vsh_next", Menu_QueueC, "See your current queue points");
	RegConsoleCmd("vshnext", Menu_QueueC, "See your current queue points");
	RegConsoleCmd("hale_resetpoints", Menu_QueueC, "See your current queue points");
	RegConsoleCmd("haleresetpoints", Menu_QueueC, "See your current queue points");
	RegConsoleCmd("ff2_resetpoints", Menu_QueueC, "See your current queue points");
	RegConsoleCmd("ff2resetpoints", Menu_QueueC, "See your current queue points");
	RegConsoleCmd("vsh_resetpoints", Menu_QueueC, "See your current queue points");
	RegConsoleCmd("vshresetpoints", Menu_QueueC, "See your current queue points");

	RegConsoleCmd("hale_classinfo", Menu_InfoC, "View changes to your class");
	RegConsoleCmd("haleclassinfo", Menu_InfoC, "View changes to your class");
	RegConsoleCmd("ff2_classinfo", Menu_InfoC, "View changes to your class");
	RegConsoleCmd("ff2classinfo", Menu_InfoC, "View changes to your class");
	RegConsoleCmd("vsh_classinfo", Menu_InfoC, "View changes to your class");
	RegConsoleCmd("vshclassinfo", Menu_InfoC, "View changes to your class");

	RegConsoleCmd("hale_boss", Menu_SelectC, "Select your boss");
	RegConsoleCmd("haleboss", Menu_SelectC, "Select your boss");
	RegConsoleCmd("ff2_boss", Menu_SelectC, "Select your boss");
	RegConsoleCmd("ff2boss", Menu_SelectC, "Select your boss");
	RegConsoleCmd("vsh_boss", Menu_SelectC, "Select your boss");
	RegConsoleCmd("vshboss", Menu_SelectC, "Select your boss");
	RegConsoleCmd("hale_toggle", Menu_SelectC, "Select your boss");
	RegConsoleCmd("haletoggle", Menu_SelectC, "Select your boss");
	RegConsoleCmd("ff2_toggle", Menu_SelectC, "Select your boss");
	RegConsoleCmd("ff2toggle", Menu_SelectC, "Select your boss");
	RegConsoleCmd("vsh_toggle", Menu_SelectC, "Select your boss");
	RegConsoleCmd("vshtoggle", Menu_SelectC, "Select your boss");
	RegConsoleCmd("sm_setboss", Menu_SelectC, "Select your boss");
	RegConsoleCmd("sm_boss", Menu_SelectC, "Select your boss");

	RegConsoleCmd("hale_new", Menu_ChangelogC, "See the changelog");
	RegConsoleCmd("halenew", Menu_ChangelogC, "See the changelog");
	RegConsoleCmd("ff2_new", Menu_ChangelogC, "See the changelog");
	RegConsoleCmd("ff2new", Menu_ChangelogC, "See the changelog");
	RegConsoleCmd("vsh_new", Menu_ChangelogC, "See the changelog");
	RegConsoleCmd("vshnew", Menu_ChangelogC, "See the changelog");

	RegConsoleCmd("hale_music", Menu_SettingsC, "Set your settings");
	RegConsoleCmd("halemusic", Menu_SettingsC, "Set your settings");
	RegConsoleCmd("ff2_music", Menu_SettingsC, "Set your settings");
	RegConsoleCmd("ff2music", Menu_SettingsC, "Set your settings");
	RegConsoleCmd("vsh_music", Menu_SettingsC, "Set your settings");
	RegConsoleCmd("vshmusic", Menu_SettingsC, "Set your settings");
	RegConsoleCmd("hale_voice", Menu_SettingsC, "Set your settings");
	RegConsoleCmd("halevoice", Menu_SettingsC, "Set your settings");
	RegConsoleCmd("ff2_voice", Menu_SettingsC, "Set your settings");
	RegConsoleCmd("ff2voice", Menu_SettingsC, "Set your settings");
	RegConsoleCmd("vsh_voice", Menu_SettingsC, "Set your settings");
	RegConsoleCmd("vshvoice", Menu_SettingsC, "Set your settings");
	RegConsoleCmd("hale_infotoggle", Menu_SettingsC, "Set your settings");
	RegConsoleCmd("haleinfotoggle", Menu_SettingsC, "Set your settings");
	RegConsoleCmd("ff2_infotoggle", Menu_SettingsC, "Set your settings");
	RegConsoleCmd("ff2infotoggle", Menu_SettingsC, "Set your settings");
	RegConsoleCmd("vsh_infotoggle", Menu_SettingsC, "Set your settings");
	RegConsoleCmd("vshinfotoggle", Menu_SettingsC, "Set your settings");
}

/*
	Main Menu
*/

public Action Menu_MainC(int client, int args)
{
	if(client)
	{
		Menu_Main(client);
	}
	else
	{
		ReplyToCommand(client, "[SM] %t", "Command is in-game only");
	}
	return Plugin_Handled;
}

static void Menu_Main(int client)
{
	Menu menu = new Menu(Menu_MainH);

	menu.SetTitle("Versus Saxton Hale / Freak Fortress 2\n ");
	menu.AddItem("0", "User Settings");
	menu.AddItem("1", "Boss Selection");
	menu.AddItem("2", "Hud Settings", ITEMDRAW_DISABLED);
	menu.AddItem("3", "Queue Points");
	menu.AddItem("4", "Class Changes");
	menu.AddItem("5", "Changelog");
	menu.AddItem("6", "DISC-FF.com");

	menu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_MainH(Menu menu, MenuAction action, int client, int selection)
{
	switch(action)
	{
		case MenuAction_End:
		{
			delete menu;
		}
		case MenuAction_Select:
		{
			switch(selection)
			{
				case 0:
					Menu_Settings(client, true);

				case 1:
					Menu_Select(client, true);

				case 3:
					Menu_Queue(client, true);

				case 4:
					Menu_Info(client, true);

				case 5:
					Menu_Changelog(client, true);

				default:
					ClientCommand(client, "sm_helpme");
			}
		}
	}
}

/*
	Queue Points
*/

public Action Menu_QueueC(int client, int args)
{
	if(client)
	{
		Menu_Queue(client);
	}
	else
	{	
		for(int i=1; i<=MaxClients; i++)
		{
			if(IsClientInGame(i))
				ReplyToCommand(client, "%N: %d", i, Client[i].Queue);
		}
	}
	return Plugin_Handled;
}

static void Menu_Queue(int client, bool back=false)
{
	Menu menu = new Menu(Menu_QueueH);

	if(Hale[client].Enabled)
	{
		menu.SetTitle("Queue Points\n \nYou are currently playing as %s.\n ", Hale[client].Name);
	}
	else if(Client[client].Queue < 0)
	{
		menu.SetTitle("Queue Points\n \nYou are currently banned from being the boss.\n ");
	}
	else if(!Client[client].Queue)
	{
		menu.SetTitle("Queue Points\n \nYou have no queue points.\n ");
	}
	else if(Client[client].Selection == -2)
	{
		menu.SetTitle("Queue Points\n \nYou have %d queue points.\nYou disabled becoming the boss.\n ",  Client[client].Queue);
	}
	else if(GetClientTeam(client) > view_as<int>(TFTeam_Spectator))
	{
		int place = 1;
		if(FourTeams)
		{
			int team = GetClientTeam(client);
			for(int i=1; i<=MaxClients; i++)
			{
				if(IsClientInGame(i) && Client[i].Queue>Client[client].Queue && GetClientTeam(i)==team)
					place++;
			}
		}
		else
		{
			for(int i=1; i<=MaxClients; i++)
			{
				if(IsClientInGame(i) && Client[i].Queue>Client[client].Queue && GetClientTeam(i)>view_as<int>(TFTeam_Spectator))
					place++;
			}
		}

		if(place == 1)
		{
			menu.SetTitle("Queue Points\n \nYou have %d queue points.\nYou will become the boss next!\n ", Client[client].Queue);
		}
		else
		{
			menu.SetTitle("Queue Points\n \nYou have %d queue points.\nYou will become the boss in %d more rounds.\n ", Client[client].Queue, place);
		}
	}
	else
	{
		menu.SetTitle("Queue Points\n \nYou have %d queue points.\nYou are currently in spectator.\n ", Client[client].Queue);
	}

	menu.AddItem("0", "Reset Queue Points", Client[client].Queue>0 ? ITEMDRAW_DEFAULT : ITEMDRAW_DISABLED);

	if(back)
		menu.AddItem("1", "Back");

	menu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_QueueH(Menu menu, MenuAction action, int client, int selection)
{
	switch(action)
	{
		case MenuAction_End:
		{
			delete menu;
		}
		case MenuAction_Select:
		{
			char buffer[4];
			if(selection)
			{
				menu.GetItem(selection, buffer, sizeof(buffer));
				if(StringToInt(buffer))
					Menu_Main(client);
			}
			else
			{
				if(Client[client].Queue > 0)
					Client[client].Queue = 0;

				menu.GetItem(1, buffer, sizeof(buffer));
				Menu_Queue(client, view_as<bool>(StringToInt(buffer)));
			}
		}
	}
}

/*
	Class Info
*/

public Action Menu_InfoC(int client, int args)
{
	if(client)
	{
		Menu_Info(client);
	}
	else
	{
		ReplyToCommand(client, "[SM] %t", "Command is in-game only");
	}
	return Plugin_Handled;
}

static void Menu_Info(int client, bool back=false)
{
	if(Hale[client].Enabled && Hale[client].MiscDesc!=INVALID_FUNCTION)
	{
		static char buffer[512];
		Call_StartFunction(null, Hale[client].MiscDesc);
		Call_PushCell(client);
		Call_PushStringEx(buffer, sizeof(buffer), SM_PARAM_STRING_UTF8, SM_PARAM_COPYBACK);
		Call_Finish();

		if(buffer[0])
		{
			Menu menu = new Menu(EmptyMenuH);
			menu.SetTitle(buffer);
			menu.ExitButton = false;
			menu.AddItem("0", "Exit");
			menu.Display(client, MENU_TIME_FOREVER);
			return;
		}
	}

	Menu menu = new Menu(Menu_InfoH);

	menu.SetTitle("Class Changes\n ");

	menu.AddItem("1", "Scout");
	menu.AddItem("3", "Soldier");
	menu.AddItem("7", "Pyro");
	menu.AddItem("4", "Demoman");
	menu.AddItem("6", "Heavy");
	menu.AddItem("9", "Engineer");
	menu.AddItem("5", "Medic");
	menu.AddItem("2", "Sniper");
	menu.AddItem("8", "Spy");
	menu.AddItem("10", "Cilvilian");

	menu.ExitBackButton = back;
	menu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_InfoH(Menu menu, MenuAction action, int client, int selection)
{
	switch(action)
	{
		case MenuAction_End:
		{
			delete menu;
		}
		case MenuAction_Cancel:
		{
			if(selection == MenuCancel_ExitBack)
				Menu_Main(client);
		}
		case MenuAction_Select:
		{
			char buffer[4];
			menu.GetItem(selection, buffer, sizeof(buffer));
			Menu_InfoClass(client, StringToInt(buffer), menu.ExitBackButton ? 2 : 1);
		}
	}
}

void Menu_InfoClass(int client, int class, int backMode=0)
{
	Menu menu = new Menu(Menu_InfoClassH);
	switch(view_as<TFClassType>(class))
	{
		case TFClass_Scout:
			menu.SetTitle("Class Changes: Scout\n \n- Pistol deals 50%% more damage\n ");

		case TFClass_Soldier:
			menu.SetTitle("Class Changes: Soldier\n \n- The R.P.G. deals 35%% more damage\n- Shotgun deals 35%% more damage\n- The Gunboats reduces fall damage by 80%%\n ");

		case TFClass_Pyro:
			menu.SetTitle("Class Changes: Pyro\n \n- Flamethrower deals 100%% more damage\n- Airblast causes the boss to gain rage\n- Shotgun deals 35%% more damage\n- The Flare Gun deals 100%% more damage\n ");

		case TFClass_DemoMan:
			menu.SetTitle("Class Changes: Demoman\n \n- The Dynamite Pack always deals critical hits\n ");

		case TFClass_Heavy:
			menu.SetTitle("Class Changes: Heavy\n \n- Shotgun deals 35%% more damage\n ");

		case TFClass_Engineer:
			menu.SetTitle("Class Changes: Engineer\n \n- Shotgun deals 35%% more damage\n- Sentries explode upon your death\n ");

		case TFClass_Medic:
			menu.SetTitle("Class Changes: Medic\n \n- Syringe Gun deals 35%% more damage and gains 2%% Ubercharge on hit\n- Medi Gun's Ubercharge gives critical hits\n- The Kritzkrieg's Ubercharge gives 67%% damage resistance\n ");

		case TFClass_Sniper:
			menu.SetTitle("Class Changes: Sniper\n \n- Primary Weapons deals 100%% more damage and outline the boss\n- SMG deals 50%% more damage\n- Fishwhacker deals 10%% more damage against bleeding targets\n ");

		case TFClass_Spy:
			menu.SetTitle("Class Changes: Spy\n \n- Revolver deals 50%% more damage\n- The Tranquilizer Gun doesn't slow down bosses\n- Knives don't deal critical hits\n- Backstab damage is based on boss's max health\n ");

		case TFClass_Civilian:
			menu.SetTitle("Class Changes: Civilian\n \n- 80%% less damage from fall damage\n ");

		default:
			menu.SetTitle("Class Changes: Mercenary\n \n- The Super Shotgun has 50%% more knockback\n- Flamethrower deals 100%% more damage- Airblast causes the boss to gain rage\n- Pistols deals 50%% more damage\n- This is not an easter egg\n ");
	}

	if(backMode)
	{
		menu.AddItem(backMode==2 ? "2" : "1", "Back");
		menu.Display(client, MENU_TIME_FOREVER);
	}
	else
	{
		menu.OptionFlags |= MENUFLAG_NO_SOUND;
		menu.ExitButton = false;
		menu.AddItem("0", "Exit");
		menu.Display(client, 15);
	}
}

public int Menu_InfoClassH(Menu menu, MenuAction action, int client, int selection)
{
	switch(action)
	{
		case MenuAction_End:
		{
			delete menu;
		}
		case MenuAction_Select:
		{
			char buffer[4];
			menu.GetItem(selection, buffer, sizeof(buffer));
			int value = StringToInt(buffer);
			if(value)
				Menu_Info(client, value==2);
		}
	}
}

/*
	Boss Selection
*/

public Action Menu_SelectC(int client, int args)
{
	if(client)
	{
		Menu_Select(client);
	}
	else
	{
		char desc[4];
		for(int i; i<MAXBOSSES; i++)
		{
			if(Special[i] == INVALID_FUNCTION)
				continue;

			static char name[64];
			Call_StartFunction(null, Special[i]);
			Call_PushCell(client);
			Call_PushStringEx(name, sizeof(name), SM_PARAM_STRING_UTF8|SM_PARAM_STRING_COPY, SM_PARAM_COPYBACK);
			Call_PushStringEx(desc, sizeof(desc), SM_PARAM_STRING_UTF8|SM_PARAM_STRING_COPY, SM_PARAM_COPYBACK);
			Call_PushCell(false);
			Call_Finish();

			ReplyToCommand(client, name);
		}
	}
	return Plugin_Handled;
}

static void Menu_Select(int client, bool back=false)
{
	Menu menu = new Menu(Menu_SelectH);

	char desc[4];
	static char name[64];
	if(Client[client].Selection == -2)
	{
		menu.SetTitle("Boss Selection\n \nSelection: None");
		menu.AddItem("-1", "None", ITEMDRAW_DISABLED);
		menu.AddItem("-1", "Random Boss");
	}
	else if(Client[client].Selection<0 || Client[client].Selection>=MAXBOSSES || Special[Client[client].Selection]==INVALID_FUNCTION)
	{
		menu.SetTitle("Boss Selection\n \nSelection: Random Boss");
		menu.AddItem("-1", "None");
		menu.AddItem("-1", "Random Boss", ITEMDRAW_DISABLED);
	}
	else
	{
		Call_StartFunction(null, Special[Client[client].Selection]);
		Call_PushCell(client);
		Call_PushStringEx(name, sizeof(name), SM_PARAM_STRING_UTF8|SM_PARAM_STRING_COPY, SM_PARAM_COPYBACK);
		Call_PushStringEx(desc, sizeof(desc), SM_PARAM_STRING_UTF8|SM_PARAM_STRING_COPY, SM_PARAM_COPYBACK);
		Call_PushCell(false);
		Call_Finish();

		menu.SetTitle("Boss Selection\n \nSelection: %s", name);
		menu.AddItem("-1", "None");
		menu.AddItem("-1", "Random Boss");
	}

	for(int i; i<MAXBOSSES; i++)
	{
		if(Special[i] == INVALID_FUNCTION)
			continue;

		Call_StartFunction(null, Special[i]);
		Call_PushCell(client);
		Call_PushStringEx(name, sizeof(name), SM_PARAM_STRING_UTF8|SM_PARAM_STRING_COPY, SM_PARAM_COPYBACK);
		Call_PushStringEx(desc, sizeof(desc), SM_PARAM_STRING_UTF8|SM_PARAM_STRING_COPY, SM_PARAM_COPYBACK);
		Call_PushCell(false);
		Call_Finish();

		IntToString(i, desc, sizeof(desc));
		menu.AddItem(desc, name);
	}

	menu.ExitBackButton = back;
	menu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_SelectH(Menu menu, MenuAction action, int client, int selection)
{
	switch(action)
	{
		case MenuAction_End:
		{
			delete menu;
		}
		case MenuAction_Cancel:
		{
			if(selection == MenuCancel_ExitBack)
				Menu_Main(client);
		}
		case MenuAction_Select:
		{
			switch(selection)
			{
				case 0:
				{
					Client[client].Selection = -2;
					Menu_Select(client, menu.ExitBackButton);
				}
				case 1:
				{
					Client[client].Selection = -1;
					Menu_Select(client, menu.ExitBackButton);
				}
				default:
				{
					char buffer[4];
					menu.GetItem(selection, buffer, sizeof(buffer));
					Menu_Confirm(client, StringToInt(buffer), menu.ExitBackButton);
				}
			}
		}
	}
}

static void Menu_Confirm(int client, int i, bool back)
{
	if(i<0 || i>=MAXBOSSES || Special[i]==INVALID_FUNCTION)
	{
		Menu_Select(client, back);
		return;
	}

	char name[64];	// TODO: Why strcopy can cause a plugin address failure
	static char desc[512];
	Call_StartFunction(null, Special[i]);
	Call_PushCell(client);
	Call_PushStringEx(name, sizeof(name), SM_PARAM_STRING_UTF8|SM_PARAM_STRING_COPY, SM_PARAM_COPYBACK);
	Call_PushStringEx(desc, sizeof(desc), SM_PARAM_STRING_UTF8|SM_PARAM_STRING_COPY, SM_PARAM_COPYBACK);
	Call_PushCell(false);
	Call_Finish();

	Menu menu = new Menu(Menu_ConfirmH);
	menu.SetTitle(desc);

	IntToString(i, name, sizeof(name));
	menu.AddItem(name, "Select");
	menu.AddItem(name, "Back");

	menu.ExitButton = !back;
	menu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_ConfirmH(Menu menu, MenuAction action, int client, int selection)
{
	switch(action)
	{
		case MenuAction_End:
		{
			delete menu;
		}
		case MenuAction_Select:
		{
			if(!selection)
			{
				char buffer[4];
				menu.GetItem(0, buffer, sizeof(buffer));
				Client[client].Selection = StringToInt(buffer);
			}

			Menu_Select(client, !menu.ExitButton);
		}
	}
}

/*
	User Settings
*/

public Action Menu_SettingsC(int client, int args)
{
	if(client)
	{
		Menu_Settings(client);
	}
	else
	{
		ReplyToCommand(client, "[SM] %t", "Command is in-game only");
	}
	return Plugin_Handled;
}

static void Menu_Settings(int client, bool back=false)
{
	Menu menu = new Menu(Menu_SettingsH);

	menu.SetTitle("User Settings\n ");

	menu.AddItem("", Client[client].NoMusic ? "Background Music [OFF]" : "Background Music [ON]");
	menu.AddItem("", Client[client].NoVoice ? "Boss Voicelines [OFF]" : "Boss Voicelines [ON]");
	menu.AddItem("", Client[client].NoInfo ? "Class Changes [OFF]" : "Class Changes [ON]");
	menu.AddItem("", "Boss Ranking [OFF]", ITEMDRAW_DISABLED);

	menu.ExitBackButton = back;
	menu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_SettingsH(Menu menu, MenuAction action, int client, int selection)
{
	switch(action)
	{
		case MenuAction_End:
		{
			delete menu;
		}
		case MenuAction_Cancel:
		{
			if(selection == MenuCancel_ExitBack)
				Menu_Main(client);
		}
		case MenuAction_Select:
		{
			switch(selection)
			{
				case 0:
				{
					if(Client[client].NoMusic)
					{
						Client[client].NoMusic = false;
						Client[client].ThemeAt = 0.0;
					}
					else
					{
						Client[client].NoMusic = true;
						Client[client].ThemeAt = FAR_FUTURE;
						if(Client[client].Theme[0])
						{
							StopSound(client, SNDCHAN_STATIC, Client[client].Theme);
							Client[client].Theme[0] = 0;
						}
					}
				}
				case 1:
				{
					Client[client].NoVoice = !Client[client].NoVoice;
				}
				case 2:
				{
					Client[client].NoInfo = !Client[client].NoInfo;
				}
			}

			Menu_Settings(client, menu.ExitBackButton);
		}
	}
}

/*
	Changelog
*/

public Action Menu_ChangelogC(int client, int args)
{
	if(client)
	{
		Menu_Changelog(client);
	}
	else
	{
		int page = -1;
		do
		{
			static char buffer[512];
			Changelog(page, buffer, sizeof(buffer));
			ReplyToCommand(client, "%s\n ", buffer);
		} while(page-- > 0);
	}
	return Plugin_Handled;
}

static void Menu_Changelog(int client, bool back=false, int page=-1)
{
	Menu menu = new Menu(Menu_ChangelogH);

	static char buffer[512];
	Changelog(page, buffer, sizeof(buffer));
	menu.SetTitle(buffer);

	IntToString(page, buffer, sizeof(buffer));
	if(back)
	{
		menu.AddItem(buffer, "Newer");
		menu.AddItem("1", "Older", page ? ITEMDRAW_DEFAULT : ITEMDRAW_DISABLED);
		menu.AddItem("", "Back");
	}
	else
	{
		menu.AddItem(buffer, "Newer");
		menu.AddItem("0", "Older", page ? ITEMDRAW_DEFAULT : ITEMDRAW_DISABLED);
	}
	menu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_ChangelogH(Menu menu, MenuAction action, int client, int selection)
{
	switch(action)
	{
		case MenuAction_End:
		{
			delete menu;
		}
		case MenuAction_Select:
		{
			if(selection == 2)
			{
				Menu_Main(client);
				return;
			}

			char buffer[4];
			menu.GetItem(1, buffer, sizeof(buffer));
			bool back = view_as<bool>(StringToInt(buffer));

			menu.GetItem(0, buffer, sizeof(buffer));
			Menu_Changelog(client, back, selection ? StringToInt(buffer)-1 : StringToInt(buffer)+1);
		}
	}
}