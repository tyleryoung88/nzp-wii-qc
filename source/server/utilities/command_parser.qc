/*
	server/utilities/command_parser.qc

	Contains SV_ParseClientCommand(), helper functions for server
    commands, and a table storing command information. Modeled after
    pr_cmds.

	Copyright (C) 2021-2024 NZ:P Team

	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

	See the GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to:

		Free Software Foundation, Inc.
		59 Temple Place - Suite 330
		Boston, MA  02111-1307, USA

*/

void(vector where, float type) Spawn_Powerup;

// Whether the command prohibits client-sending.
float client_parse_override;

// Success/Failure return codes
#define COMMAND_SUCCESS     0
#define COMMAND_FAILURE     1

//
// Server command table
// command_name         : Command string entered into developer console.
// command_function     : QuakeC function called when command is executed.
//                        Returns 0 for success, 1 for failure.
// requires_arguments   : Whether or not to expect arguments to be passed 
//                        with the command.
// command_description  : Called when no params (when applicable) are given.
//
/*
var struct {
    string                  command_name;
    float(string params)    command_function;
    float                   requires_arguments;
    string                  command_description;
} server_commands[] = {
    {"addmoney", Command_addmoney, true, "Usage: addmoney <point_value>\n  Gives `point_value` amount of points to the client who requested it.\n"},
    {"give", Command_give, true, "Usage: give <weapon number>\n  Gives `weapon` of index.\n"},
	{"qc_soft_restart", Command_softrestart, false, "Executes the Soft_Restart QuakeC function. Useful for debugging its functionality.\n"},
	{"god", Command_godmode, false, "Toggles God Mode.\n"},
	{"noclip", Command_noclip, false, "Toggles No Clip.\n"},
	{"sv_tracedmgmultiplier", Command_tracedmgmultiplier, true, "Multiplies damage output with weapons that fire Traces.\n"},
	{"spawn_pu", Command_powerup, true, "Usage: spawn_pu <powerup>\n  Spawns a Power-Up of a given ID in front of you. -1 for random.\n"},
	{"say", Command_say, true, "Usage: say <message>\n  Sends a chat message to CSQC for other clients.\n"}
};
*/
//
// SV_IsCommand(command_string)
// Takes a single string and references if it is a
// registered command, returns true if it is. Useful
// for cl_chatmode interferring with custom commands.
//
/*
float(string command_string) SV_IsCommand =
{
	for (float i = 0; i < server_commands.length; i++) {
		if (command_string == server_commands[i].command_name)
			return true;
	}

	return false;
}
*/
//
// SV_ParseClientCommand(command_string)
// Server-Side client command parser to add special
// gameplay commands that interact with QuakeC.
//
void(string command_string) SV_ParseClientCommand =
{/*
	// If true, we will avoid sending the command info
	// to the client.
	client_parse_override = false;

	// Get the string ready for arg parsing
	tokenize(command_string);

	// Grab the command string
	string command = argv(0);

	// Check for 'say' prefix (`cl_chatmode 2` will append it
	// to everything unregistered by the client). Re-tokenize
	// if found.
	if (command == "say" && SV_IsCommand(argv(1))) {
		string fixed_command_string = argv(1);
		tokenize(fixed_command_string);
		command = argv(0);	
	}

    // Now iterate over our commands
    for (float i = 0; i < server_commands.length; i++) {
        // Command names match
        if (command == server_commands[i].command_name) {
            // Override Client Commands
            client_parse_override = true;

            // Return description if no params are given
            if (argv(1) == "" && server_commands[i].requires_arguments == true) {
                sprint(self, 1, server_commands[i].command_description);
            } else {
                if (server_commands[i].command_function(argv(1)) == COMMAND_FAILURE) {
                    sprint(self, 1, "Command executed but failed to complete.\n");
                }
            }
        }
    }

	// Client override was disabled, so let the engine
	// deal with whatever was sent.
#ifdef FTE

	if (client_parse_override == false)
		clientcommand(self, command_string);

#endif // FTE
*/
};

#ifndef FTE

void() ParseClientCommand = {/*SV_ParseClientCommand(CMD_STRING);*/}

#endif // FTE