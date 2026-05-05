module parameters;

import std.stdio : writeln;
import std.conv;

// Where is the action
immutable int WHERE_ACTION           = 1;

// Action 1
immutable string ACTION_START        = "start_service";
// Action 1 values
immutable int DEVICE_PATH_IDX        = 2;
immutable int EVENTS_CONFIG_PATH_IDX = 3;

// Action 2
immutable string ACTION_CONFIG       = "configure";
immutable string ACTION_CONFIG_GUI   = "configure_gui";
// Action 2 parameters
immutable int WHERE_WHAT_CONFIG      = 2;
// Action 2 parameter valid values
immutable string CONFIG_DEVICE       = "device";
immutable string CONFIG_EVENTS       = "events";

immutable string STR_RET_ERR     = "[ERROR]";
immutable string STR_RET_UNKNOWN = "[UNKNOWN]";

public final class ParameterManager {
    private string[] args;

    public this(string[] args) {
        this.args = args;
    }

    // Use one of the above constants
    public string get(int where) {
        if(args.length <= where) {
            return STR_RET_UNKNOWN;
        }
        return args[where];
    }
}