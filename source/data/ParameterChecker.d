module data.ParameterChecker;

import data.ParameterManager : DEVICE_PATH_IDX;
import data.ParameterManager : EVENTS_CONFIG_PATH_IDX;

import data.ParameterManager;

import std.stdio : writeln;
import std.conv;

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
        writeln("Error: missing parameters.");
        writeln("Usage: macro-dransformer [device] [events]");
    }
}