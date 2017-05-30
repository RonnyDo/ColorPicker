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
    
    public class ColorPickerWindow: Gtk.Dialog {
    
        public ColorPickerWindow () {
            Object (application: application,
                icon_name: "com.github.ronnydo.colorpicker",
                    title: "Color Picker",
                    resizable: false
                    // height_request: 500,
                    // width_request: 300
                    );     
        }
        
        construct {
            
            var color_area = new ColorArea ();        
            color_area.margin_bottom = 12;
                         
            var hex_entry = new Gtk.Entry ();
            hex_entry.placeholder_text = "rgb(255,255,255)";
            hex_entry.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "edit-copy");
                   
            var button_hello = new Gtk.Button.with_label ("Pick Color");
            button_hello.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
            
            var box = get_content_area () as Gtk.Box;
            box.border_width = 6;
            
    		box.pack_start (color_area);
    		box.pack_start (hex_entry);
    		box.pack_start (button_hello);
    		
    		var content_box = get_content_area () as Gtk.Box;
    		content_box.border_width = 6;
    		
            content_box.add (box);
            content_box.add (button_hello);
    		
    		
    		hex_entry.icon_press.connect ((pos, event) => {
                if (pos == Gtk.EntryIconPosition.SECONDARY) {
                    Gtk.Clipboard.get_default (this.get_display ()).set_text (hex_entry.get_text (), -1);
                }
            });
    		            
            button_hello.clicked.connect (() => {
                var mouse_position = new ColorPicker.Widgets.MousePosition ();
                mouse_position.show_all ();
                
                mouse_position.moved.connect ((t, color) => {
                    color_area.set_color (color);
                    color_area.queue_draw ();
                    hex_entry.text = color.to_string ();
                });                

                mouse_position.cancelled.connect (() => {
                    mouse_position.close ();
                    this.present ();
                });

                var win = mouse_position.get_window ();
                
                mouse_position.picked.connect ((t, color) => {
                    color_area.set_color (color);
                    color_area.queue_draw ();
                    hex_entry.text = color.to_string ();
                    mouse_position.close ();
                    this.present ();                    
                });
            });
            
        }    
        
    }
    
    
}
