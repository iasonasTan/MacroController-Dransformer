module data.parameters;

import std.stdio : writeln;
import std.conv;

immutable int DEVICE_PATH_IDX        = 1;
immutable int EVENTS_CONFIG_PATH_IDX = 2;

public final class ParameterManager {
    private const int PARAMETERS_REQ_LEN = 2;

    private string[] args;

    public this(string[] args) {
        this.args = args;
        if(!containsExpectedMembers()) {
            writeln("Error: Missing arguments.");
        }
    }

    // Parameter 'what' must be one of these:
    // DEVICE_PATH_IDX
    // EVENTS_CONFIG_PATH_IDX
    public string get(int what) {
        return args[what];
    }

    public bool containsExpectedMembers() {
        return args.length == getExpectedLength();
    }

    public int getExpectedLength() {
        return PARAMETERS_REQ_LEN+1;
    }
}

public final class ParameterChecker {
    public bool check(ParameterManager manager) {
        if(manager.containsExpectedMembers() && 
            isPath(manager.get(DEVICE_PATH_IDX)) && 
            isPath(manager.get(EVENTS_CONFIG_PATH_IDX))) {
            return true;
        } else {
            writeErrors();
            return false;
        }
    }

    private bool isPath(string path) {
        // TODO: check better.
        return path.length > 1;
    }

    private void writeErrors() {
        writeln("Usage: macro-dransformer [device] [events]");
    }
}