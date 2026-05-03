module input.linux_input;

extern(C):

enum : ubyte {
    EV_SYN = 0,
    EV_KEY = 1,
    EV_REL = 2,
    EV_ABS = 3,
}

enum : ushort {
    KEY_ESC = 1,
    KEY_1 = 2,
    KEY_A = 30,
    KEY_SPACE = 57,
    KEY_ENTER = 28,
}

struct input_event {
    timeval time;
    ushort type;
    ushort code;
    int value;
}

struct timeval {
    long tv_sec;
    long tv_usec;
}