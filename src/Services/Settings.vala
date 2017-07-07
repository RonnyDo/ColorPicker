/*
* Copyright (c) 2017 Ronny Dobra (https://github.com/RonnyDo/ColorPicker)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Ronny Dobra <ronnydobra at arcor dot de>
*/

namespace ColorPicker.Services {

    public class Settings : Granite.Services.Settings {
    
        private static Settings? instance = null;

        public int window_x { get; set; }
        public int window_y { get; set; }
        public int color_format_index { get; set; }
        public string[] color_history { get; set; }
        public int zoomlevel { get; set; }

        public static Settings get_instance () {
            if (instance == null) {
                instance = new Settings ();
            }

            return instance;
        }

        private Settings () {
            base ("com.github.ronnydo.colorpicker");
        }
    }
}

