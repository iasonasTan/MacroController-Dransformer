module config.storing;

import std.stdio : writeln, writefln, readln;
import std.string : split, chomp;
import std.conv;
import std.process : executeShell;
import std.algorithm : endsWith;

import events.evtest;
import parameters;

int startConfig(ParameterManager params) {
    writeln("MCD - Configuration.");
    writeln("What would you like to config?");
    writeln("1) device");
    writeln("2) events");
    int config = readln().chomp().to!int;

    const string DEAFAULT_DEV = "/dev/input/";
    writeln("Where are you going to get device from? (default: "~DEAFAULT_DEV~")");
    string path = readln().chomp();
    if(path == "") {
        path = DEAFAULT_DEV;
    }
    if(!path.endsWith("/")) {
        path = path ~ "/";
    }

    if(config == 1) {
        // Configure device
        auto result = executeShell("ls " ~ path);
        string[] devices = result.output.split("\n");
        writeln("Select a device:");
        for(int i=0; i<devices.length; i++) {
            writefln("%d) %s", i, devices[i]);
        }
        int deviceIdx = readln().chomp().to!int;
        string deviceStr = devices[deviceIdx];
        test(path ~ deviceStr);
    } else {
        // Configure events
    }
    return 0;
}

int startConfigGui(ParameterManager params) {
	return 0;
}
