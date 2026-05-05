module service;

import parameters;
import std.stdio : writeln, writefln;
import std.process : executeShell;
import config.loader : ConfigurationLoader;
import std.conv;
import std.string : toStringz;
import events.manager;
import core.sys.linux.unistd;
import core.sys.linux.fcntl;
import input.linux_input;

int startService(ParameterManager params) {
	// Open device
	const string value = params.get(DEVICE_PATH_IDX);
	if(value==STR_RET_UNKNOWN) {
		writeln("Error: expected device as second argument.");
		return -1;
	}
	int fd = open(value.toStringz(), O_RDONLY);
	if(fd == -1) {
		writeln("Error: Cannot open device.");
		writeln("Help: Make sure your user is in group 'input'");
		return -1;
	}

	// Load events
	const string configuration_file_path = params.get(EVENTS_CONFIG_PATH_IDX);
	if(configuration_file_path==STR_RET_UNKNOWN) {
		writeln("Error: expected configuration file as third argument.");
		return -1;
	}
	EventLoader loader = new ConfigurationLoader(configuration_file_path);
	EventManager eventManager = new EventManager(loader);
	
	// Start infinite reading loop
	InputEvent event;
	while(true) {
		// Get event
		ssize_t bytes = read(fd, &event, event.sizeof);
		// Check event
		if(bytes != event.sizeof) {
			writeln("Error reading event...");
			writeln("Aborting.");
			return -1;
		}
		// Log what it returned
		writefln("Pressed key with code: %d.", event.code);
		// Get related command and check if it's not null
		string action = eventManager.getAction(event.code);
		if(action !is null) {
			// Execute related command and write it's output
			auto r = executeShell(eventManager.getAction(event.code));
			writeln("Executed command returned exit code " ~ r.status.to!string);
		}
	}

	// Close and return 0.
	close(fd);
	return 0;
}