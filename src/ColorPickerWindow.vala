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

namespace ColorPicker {
    
    public class ColorPickerWindow: Gtk.Window {
    
        public ColorPickerWindow () {
            Object (title: "Whazzup") ;     
        }
        
        construct {
            var button_hello = new Gtk.Button.with_label ("Click me!");
            button_hello.clicked.connect (() => {
                var mouse_position = new ColorPicker.Widgets.MousePosition ();
                mouse_position.show_all ();
                
                mouse_position.moved.connect ((t, color) => {
                    button_hello.label = color.to_string ();
                });                

                mouse_position.cancelled.connect (() => {
                    mouse_position.close ();
                    this.present ();
                });

                var win = mouse_position.get_window ();
                
                mouse_position.picked.connect ((t, color) => {
                
                    mouse_position.close ();
                    this.present ();                    
                });
            });
            
            Gtk.Box content = get_content_area () as Gtk.Box;
            content.add (button_hello);
        }
    }
    
    
}
