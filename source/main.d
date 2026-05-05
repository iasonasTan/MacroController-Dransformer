import std.stdio : writeln, writefln;
import std.string : strip;
import std.process : executeShell;

import parameters;
import config.storing;
import service;

int main(string[] args) {
	ParameterManager params  = new ParameterManager(args);

	// Check if user is root
	auto result = executeShell("whoami");
	string name = result.output.strip();
	if(name == "root") {
		writeln("It seems like you're running application as sudo.");
		writeln("This won't work! Run it as a regular user.");
		return -1;
	}

	switch(params.get(WHERE_ACTION)) {
		case ACTION_START: return startService(params);
		case ACTION_CONFIG: return startConfig(params);
		case ACTION_CONFIG_GUI: return startConfigGui(params);
		default:
			writefln(
				"Error: expected '%s', '%s' or '%s' as first argument.",
				ACTION_START, ACTION_CONFIG, ACTION_CONFIG_GUI
			);
	}

	return 0;
}