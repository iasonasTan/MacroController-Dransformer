import std.stdio;
import std.string;

import data.ParameterChecker;
import data.ParameterManager;
import linux_input;

import core.sys.linux.unistd;
import core.sys.linux.fcntl;

int main(string[] args) {
	ParameterManager params  = new ParameterManager(args);
	ParameterChecker checker = new ParameterChecker();
	if(!checker.check(params)) {
		return -1;
	}

	writeln("Micro controller transformer has started!");
	int fd = open(args[1].toStringz(), O_RDONLY);
	if(fd == -1) {
		writeln("Error openning file...");
		return -1;
	}

	input_event event;

	while(true) {
		ssize_t bytes = read(fd, &event, event.sizeof);
		if(bytes != event.sizeof) {
			writeln("Error reading event...");
			break;
		}
		writefln("Type: %d, Code: %d, Value: %d.", 
				event.type, event.code, event.value);
	}
	close(fd);
	return 0;
}
