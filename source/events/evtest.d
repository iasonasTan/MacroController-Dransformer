module events.evtest;

import std.stdio : writefln, writeln, readln;
import std.string : toStringz, chomp;
import std.process : executeShell;
import core.sys.linux.unistd;
import core.sys.linux.fcntl;
import input.linux_input;

void test(string device){
    writeln("Testing device '" ~ device ~ "'");
    writeln("Press 'q' and then 'enter' to quit.");
    int fd = open(device.toStringz(), O_RDONLY | O_CLOEXEC);
    if(fd == -1) {
        writeln("Error opening device.");
        return;
    }
	InputEvent event;
	while(true) {
		ssize_t bytes = read(fd, &event, event.sizeof);
		if(bytes != event.sizeof) {
			writeln("Error reading event...");
			writeln("Aborting.");
            break;
		}
		writefln("Pressed key with code: %d.", event.code);

        const string inp = readln().chomp();
        if(inp == "q") {
            break;
        }
	}
    close(fd);
}