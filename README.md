# Color Picker

One Color Picker to rule them all! No overhelming menus and settings. Just a dialog with all the features you'll need:
* Pick a color
* Choose between multiple Color Formats
* Let the Color History remember your last colors

![ColorPicker Screenshot](https://raw.github.com/ronnydo/colorpicker/master/data/screenshot.png)

## Appcenter
Color Picker will be soon available on [Appcenter](https://github.com/elementary/appcenter)!

## Dependencies
You'll need the following dependencies to build:
* granite
* libgtk-3-dev
* meson
* valac

## Build, Install and Run
In the projects root folder call:

    meson build && cd build
    mesonconf -Dprefix=/usr
    ninja
    sudo ninja install
    com.github.ronnydo.colorpicker

