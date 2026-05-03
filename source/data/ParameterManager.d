module data.ParameterManager;

import std.stdio;

immutable int DEVICE_PATH_IDX        = 1;
immutable int EVENTS_CONFIG_PATH_IDX = 2;

public final class ParameterManager {
    private const int PARAMETERS_REQ_LEN = 2;

    private string[] args;

    public this(string[] args) {
        this.args = args;
        if(!containsExpectedMembers()) {
            writeln(
                "[ERROR] Array passed into data.ParameterManager " ~
                "does not contain the expected number of values."
            );
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