#define MODULE_MENU

static void Changelog(int &page, char[] buffer, int length)
{
	switch(page)
	{
		case 0:
		{
			strcopy(buffer, length, "Changelog: 1.0.0\n \n- Added Vagineer");
		}
		case 1:
		{
			strcopy(buffer, length, "Changelog: 1.0.1\n \n- Fixed bosses not being able to see the top damage hud");
		}
		case 2:
		{
			strcopy(buffer, length, "Changelog: 1.1.0 Fixes\n \n- Fixed bosses not being able to suicide after the round ended\n- Spectators now see the intro hud\n- Fixed Vagineer saying lastman and kill streak sounds at once");
		}
		case 2:
		{
			strcopy(buffer, length, "Changelog: 1.1.0 Changes\n \n- Added Christian Brutal Sniper\n- Decreased Vagineer's damage to full rage from 2800 to 2700");
		}
		case 3:
		{
			strcopy(buffer, length, "Changelog: 1.2.0 Balance Changes\n \n- Airblasts now give rage\n- Sniper Rifles now outline bosses\nFlaregun now gains critical damage bonus\n- Decreased Christian Brutal Sniper's jump cooldown\n- Removed scopes for Christian Brutal Sniper");
		}
		case 4:
		{
			strcopy(buffer, length, "Changelog: 1.2.0 New Features\n \n- Added the main menu\n- Added queue point info\n- Added class change info");
		}
		default:
		{
			strcopy(buffer, length, "Changelog: 1.2.1\n \n- Fixed Gunboats not giving fall damage resistance");
			page = 5;
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

	RegConsoleCmd("hale_classinfo", Menu_InfoC, "View changes to your class");
	RegConsoleCmd("haleclassinfo", Menu_InfoC, "View changes to your class");
	RegConsoleCmd("ff2_classinfo", Menu_InfoC, "View changes to your class");
	RegConsoleCmd("ff2classinfo", Menu_InfoC, "View changes to your class");
	RegConsoleCmd("vsh_classinfo", Menu_InfoC, "View changes to your class");
	RegConsoleCmd("vshclassinfo", Menu_InfoC, "View changes to your class");
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
	menu.AddItem("1", "Queue Points");
	menu.AddItem("2", "Class Changes");
	menu.AddItem("3", "Boss Selection", ITEMDRAW_DISABLED);
	menu.AddItem("4", "User Settings", ITEMDRAW_DISABLED);
	menu.AddItem("5", "Hud Settings", ITEMDRAW_DISABLED);
	menu.AddItem("6", "Changelog", ITEMDRAW_DISABLED);
	menu.AddItem("7", "DISC-FF.com");

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
					Menu_Queue(client, true);

				case 1:
					Menu_Info(client, true);

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
	else if(GetClientTeam(client) > view_as<int>(TFTeam_Spectator))
	{
		int place = 1;
		for(int i=1; i<=MaxClients; i++)
		{
			if(IsClientInGame(i) && Client[i].Queue>Client[client].Queue && GetClientTeam(i)>view_as<int>(TFTeam_Spectator))
				place++;
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
	if(!client)
	{
		ReplyToCommand(client, "[SM] %t", "Command is in-game only");
	}
	else if(Hale[client].Enabled && Hale[client].MiscDesc!=INVALID_FUNCTION)
	{
		Call_StartFunction(null, Hale[client].MiscDesc);
		Call_PushCell(client);
		Call_Finish();
	}
	else
	{
		Menu_Info(client);
	}
	return Plugin_Handled;
}

static void Menu_Info(int client, bool back=false)
{
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
			menu.SetTitle("Class Changes: Soldier\n \n- The R.P.G. deals 35%% more damage\n- The Gunboats reduces fall damage by 80%%\n ");

		case TFClass_Pyro:
			menu.SetTitle("Class Changes: Pyro\n \n- Flamethrower deals 100%% more damage\n- Airblast causes the boss to gain rage\n- The Flare Gun deals 100%% more damage\n ");

		case TFClass_DemoMan:
			menu.SetTitle("Class Changes: Demoman\n \n- The Dynamite Pack always deals critical hits\n ");

		case TFClass_Heavy:
			menu.SetTitle("Class Changes: Heavy\n \n- Fists has 75%% more knockback\n ");

		case TFClass_Engineer:
			menu.SetTitle("Class Changes: Engineer\n \n- Sentries explode upon your death\n ");

		case TFClass_Medic:
			menu.SetTitle("Class Changes: Medic\n \n- Syringe Gun deals 35%% more damage and gains 2%% Ubercharge on hit\n- Medi Gun's Ubercharge gives critical hits\n- The Kritzkrieg's Ubercharge gives 67%% damage resistance\n ");

		case TFClass_Sniper:
			menu.SetTitle("Class Changes: Sniper\n \n- Primary Weapons deals 100%% more damage and outline the boss\n- SMG deals 50%% more damage\n- Fishwhacker deals 10%% more damage against bleeding targets\n ");

		case TFClass_Spy:
			menu.SetTitle("Class Changes: Spy\n \n- Revolver deals 50%% more damage\n- The Tranquilizer Gun doesn't slow down bosses\n- Knives don't deal critical hits\n- Backstab damage is based on boss's max health\n ");

		case TFClass_Civilian:
			menu.SetTitle("Class Changes: Civilian\n \n- Has 5%% less cash on wearer\n ");

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