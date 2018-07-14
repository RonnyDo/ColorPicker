# Color Picker

One Color Picker to rule them all! No overhelming menus or settings. An easy tool with the features you need.

Features:
* Pick a color with the zoomable Magnifier
* Choose between multiple Color Formats
* Let the Color History remember your last colors

![ColorPicker Screenshot](https://raw.github.com/ronnydo/colorpicker/master/data/screenshot.png)

## Installation
On elementaryOS? Simply install Color Picker from AppCenter:
<p align="center">
  <a href="https://appcenter.elementary.io/com.github.ronnydo.colorpicker">
    <img src="https://appcenter.elementary.io/badge.svg" alt="Get it on AppCenter">
  </a>
</p>

Otherwise you can download and install the [latest .deb file](https://github.com/ronnydo/colorpicker/releases/latest).

## Dependencies
You'll need the following dependencies to build:
* granite
* libgtk-3-dev
* meson
* valac

## Build, Install and Run
Call in the project's root folder:

    meson build && cd build
    meson configure -Dprefix=/usr
    ninja
    sudo ninja install
    com.github.ronnydo.colorpicker

