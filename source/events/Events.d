module events.Events;

public final class EventManager {
    private string[int] events;

    this(EventLoader loader) {
        events = loader.load();
    }

    public string getAction(int keycode) {
        if(string* action = keycode in events) {
            return *action;
        }
        return "";
    }
}

public interface EventLoader {
    string[int] load();
}