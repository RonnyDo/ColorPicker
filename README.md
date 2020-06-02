[![Build Status](https://travis-ci.com/RonnyDo/ColorPicker.svg?branch=master)](https://travis-ci.com/RonnyDo/ColorPicker)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

# Color Picker

One Color Picker to rule them all! No overhelming menus or settings. An easy tool with all the features you need.

Features:
* Pick a color with the zoomable Magnifier
* Choose between multiple Color Formats (`hex`, `rgb`, `rgba`)
* Let the Color History remember your last colors

![ColorPicker Screenshot](https://raw.github.com/ronnydo/colorpicker/master/data/screenshot.png)

## Installation

On elementaryOS? Simply install Color Picker from AppCenter:
<p align="center">
  <a href="https://appcenter.elementary.io/com.github.ronnydo.colorpicker">
    <img src="https://appcenter.elementary.io/badge.svg" alt="Get it on AppCenter">
  </a>
</p>

For other Debian-based systems, you can download and install the [latest .deb file](https://github.com/ronnydo/colorpicker/releases/latest).

For other systems, you will need to compile the package yourself. See the instructions below.

## Build from source

If you like to build ColorPicker yourself, take a look at the [`dev-build.sh`](dev-build.sh) file.

### Dependencies

You'll need the following dependencies to compile ColorPicker:
* granite
* libgtk-3-dev
* meson
* valac

### Example

Here's a sample list of commands for building the package from source.
These have been tested to work correctly on Ubuntu 18.04.

```sh
sudo apt install valac libgranite-dev
git clone https://github.com/RonnyDo/ColorPicker.git
cd ColorPicker/
chmod +x dev-build.sh
./dev-build.sh
```
