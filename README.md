# Macro Controller Dransformer
(dransformer means transformer)

This program basicaly a better implementation of [JeController](https://github.com/iasonasTan/MacroController-Transformer) in Dlang.

_(Again, it only works on linux)_

## Is this better than the other?
This project is the second version of `JeController`.
It has better I/O handling, better design and safer code.

While JeController requires just sudo, this project only needs your user to be in the *input* group.
You can execute the following command to add yourself.
```
sudo usermod -aG input $USER
```

Then you can normally run the binary giving it two parameters:
1. The path of the device you want to use as macro controller.
2. The path of the configuration file that tells the app which keys execute which commands.

**WARNING:** Device you enter won't be able to send events to other apps of your computer.
If you use the wrong device, you may lose control over your computer.
**Be careful with which device you use** and allways check them before using `evtest` command.
But if you didn't added the app on startup apps, after a restart the device will be free again.

## Gui panel
This app also contains a GUI panel that edits `events.conf` files.
For the GUI **you need sdl2**, here's how to install it:
Arch:
```
sudo pacman -S sdl2
```
Fedora:
```
sudo dnf install sdl2
```
Debian:
```
sudo apt-get install sdl2
```