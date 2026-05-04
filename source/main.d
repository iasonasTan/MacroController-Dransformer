import std.stdio;
import std.string;
import std.process;
import std.typecons;

import config.configuration_loader;
import data.parameters;

import events.events;
import input.linux_input;

import core.sys.linux.unistd;
import core.sys.linux.fcntl;

int main(string[] args) {
	ParameterManager params  = new ParameterManager(args);
	
	ParameterChecker checker = new ParameterChecker();
	if(!checker.check(params)) {
		return -1;
	}

	auto result = executeShell("whoami");
	string name = result.output.strip();
	if(name == "root") {
		writeln("It seems like you're running application as sudo.");
		writeln("This won't work! Run it as a regular user.");
		return -1;
	}

	int fd = open(params.get(DEVICE_PATH_IDX).toStringz(), O_RDONLY);
	if(fd == -1) {
		writeln("Error: Cannot open device.");
		writeln("Help: Make sure your user is in group 'input'");
		return -1;
	}

	writeln("Macro controller transformer has started!");

	EventManager eventManager = new EventManager(
		new ConfigurationLoader(params.get(EVENTS_CONFIG_PATH_IDX))
	);
	InputEvent event;
	while(true) {
		ssize_t bytes = read(fd, &event, event.sizeof);
		if(bytes != event.sizeof) {
			writeln("Error reading event...");
			break;
		}
		writefln("Pressed key with code: %d.", event.code);
		writeln ("Pressed key related with " ~ eventManager.getAction(event.code));
		auto r = executeShell(eventManager.getAction(event.code));
	}
	close(fd);
	return 0;
}
