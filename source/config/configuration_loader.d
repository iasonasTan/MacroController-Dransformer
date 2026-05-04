module config.configuration_loader;

import events.events;
import std.file;
import std.stdio;
import std.conv;
import std.array;

public final class ConfigurationLoader : EventLoader {
    private immutable string conffp;

    this(string cfp) {
        conffp = cfp;
    }

    public string[int] load() {
        string[int] events = null;
        if(!exists(conffp) || !isFile(conffp)) {
            return events;
        }

        File eventsFile = File(conffp, "r");
        foreach (char[] line; eventsFile.byLine()) {
            string[] lineSplit = (line.replace(" ", " ").to!string).split("=");
            if(lineSplit.length != 2) {
                writeln("Invalid line found in configuration: '"~line~"'");
                continue;
            }
            writeln(lineSplit);
            int keycode = lineSplit[0].to!int;
            events[keycode] = lineSplit[1];
        }

        eventsFile.close();

        return events;
    }
}