import std.stdio;
import std.string;
import std.process;

import data.parameters;
import data.parameters;
import config.configuration_loader;
import data.parameters : DEVICE_PATH_IDX;
import data.parameters : EVENTS_CONFIG_PATH_IDX;

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

	writeln("Macro controller transformer has started!");
	int fd = open(params.get(DEVICE_PATH_IDX).toStringz(), O_RDONLY);
	if(fd == -1) {
		writeln("Error openning file...");
		return -1;
	}

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
