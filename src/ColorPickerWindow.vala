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
            
        ExtRGBA ext_active_color = ExtRGBA ();
                
        public ColorPickerWindow (Gtk.Application application) {
            Object (application: application,
                icon_name: "com.github.ronnydo.colorpicker",
                    title: _("Color Picker"),
                    resizable: false,
                    width_request: 500
            );
        }        
        
        construct {
            // main box                       
            ext_active_color.parse ("#FFFFFF");
                                    
            var color_area = new ColorPicker.Widgets.ColorArea ();
            color_area.set_color (ext_active_color);
            
            var hex_label = new Gtk.Label (ext_active_color.to_uppercase_hex_string ());
            hex_label.halign = Gtk.Align.END;       
            hex_label.valign = Gtk.Align.END;
            hex_label.set_selectable (true);
            hex_label.set_use_markup (true);
            
            hex_label.get_style_context ().add_class ("h1");            
            
            var pick_color_button = new Gtk.Button.with_label (_("Pick Color"));
            pick_color_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);         
            pick_color_button.halign = Gtk.Align.END;
            pick_color_button.valign = Gtk.Align.BASELINE;
            // TODO Just icon or text is displyed, but not both
            // pick_color_button.set_image (new Gtk.Image.from_icon_name ("gtk-color-picker", Gtk.IconSize.BUTTON));            
            
            var main_right_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            main_right_box.pack_start (hex_label);
            main_right_box.pack_start (pick_color_button, true, false);
            
            var main_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            main_box.margin_bottom = 12;
            //main_box.margin_start = 12;       
            //main_box.margin_end = 12;
            main_box.pack_start (color_area, false, false);
            main_box.pack_start (main_right_box);
            
            // format box
            var format_label = new Gtk.Label (_("Format"));
            format_label.get_style_context ().add_class ("h4");
            format_label.halign = Gtk.Align.START;
            
            var format_entry = new Gtk.Entry ();
            format_entry.placeholder_text = ext_active_color.to_css_rgb_string ();
            format_entry.set_editable (false);
            format_entry.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "edit-copy-symbolic");     
            format_entry.margin_end = 6;
            
            var color_format_combobox = new Gtk.ComboBoxText ();
            color_format_combobox.append_text ("HEX");
            color_format_combobox.append_text ("hex");
            color_format_combobox.append_text ("rgb");
            color_format_combobox.append_text ("rgba");
            color_format_combobox.append_text ("Gdk RGBA");
            color_format_combobox.append_text ("Qt rgba");
            color_format_combobox.active =  settings.color_format_index;
            
            var adjust_button = new Gtk.Button.from_icon_name ("media-eq-symbolic");
            adjust_button.margin_start = 12;
            // TODO implement change color dialog
            
            var format_hbox = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            format_hbox.pack_start (format_entry);
            format_hbox.pack_start (color_format_combobox, false, false);
            
            var format_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);          
            format_box.pack_start (format_label);
            format_box.pack_start (format_hbox);   
            // TODO implement change color dialog
            // format_box.pack_start (adjust_button);
            
            // color history box
            var color_history_label = new Gtk.Label (_("Color History"));
            color_history_label.get_style_context ().add_class ("h4");
            color_history_label.halign = Gtk.Align.START;
            
            var color_history = new ColorPicker.Widgets.ColorHistory ();
            
            var color_history_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);            
            color_history_box.margin_top = 6;
            color_history_box.margin_bottom = 0;
            color_history_box.pack_start (color_history_label);
            color_history_box.pack_start (color_history);
            
            // tie together
            var skeleton_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            skeleton_box.orientation = Gtk.Orientation.VERTICAL;
            skeleton_box.margin = 12;    
            skeleton_box.margin_bottom = 0;        
            skeleton_box.pack_start (main_box);            
            skeleton_box.pack_start (format_box);
            
    		var content_box = get_content_area () as Gtk.Box; 		
    		content_box.pack_start (skeleton_box);   
    		    		
    		
            // restore old state
    		var color_list = color_history.get_color_list ();
    		if (color_list != null && color_list.size >= 1) {
    		    ext_active_color = (ExtRGBA) color_list.last ();
    		    
    		    hex_label.set_markup (ext_active_color.to_uppercase_hex_string ());
                color_area.set_color (ext_active_color);
                color_area.queue_draw ();
		        int id = color_format_combobox.get_active ();
		        update_color_format_combobox_text (format_entry, id);
		        
		        if (color_list.size >= 2) {
		            skeleton_box.pack_start (color_history_box);
                    color_history_box.show_all ();
		        }
    		}
    		
            var window_x = settings.window_x;
            var window_y = settings.window_y;
            
            if (window_x != -1 ||  window_y != -1) {
              move (window_x, window_y);
            }
                		    		    		    		        
    		// activate color picker    
            pick_color_button.clicked.connect (() => {
                var mouse_position = new ColorPicker.Widgets.Picker ();
                mouse_position.show_all ();
                
                mouse_position.moved.connect ((t, color) => {
                    var ext_color = (ExtRGBA) color;
                    color_area.set_color (ext_color);
                    color_area.queue_draw ();
                    hex_label.set_markup (ext_color.to_uppercase_hex_string ());
                });                

                mouse_position.cancelled.connect (() => {
                    color_area.set_color (ext_active_color);
                    color_area.queue_draw ();
                    hex_label.set_markup (ext_active_color.to_uppercase_hex_string ());
                    mouse_position.close ();
                    this.present ();
                });

                //var win = mouse_position.get_window ();

                mouse_position.picked.connect ((t, color) => {
                    ext_active_color = (ExtRGBA) color;
                    color_area.set_color (ext_active_color);
                    color_area.queue_draw ();
                                                        
                    int id = color_format_combobox.get_active ();                
                    update_color_format_combobox_text (format_entry, id);
                    Gtk.Clipboard.get_default (this.get_display ()).set_text (ext_active_color.to_uppercase_hex_string (), -1);
                    color_history.add_color (ext_active_color);       
                                               
                    var c_list = color_history.get_color_list ();
                    
                    if (color_history_box.get_parent () == null) {
                        if (c_list != null && c_list.size >= 2) {
                            skeleton_box.pack_start (color_history_box);
                            color_history_box.show_all ();
                        }
                    }
                                        
                    mouse_position.close ();
                    this.present ();                    
                });
            });
            
            
            // enable copy feature
    		format_entry.icon_press.connect ((pos, event) => {
                if (pos == Gtk.EntryIconPosition.SECONDARY) {
                    Gtk.Clipboard.get_default (this.get_display ()).set_text (format_entry.get_text (), -1);
                }
            });

            //color_format_combobox.changed.connect (color_format_changed);

            color_format_combobox.changed.connect (() => {
                int id = color_format_combobox.get_active ();                
     			update_color_format_combobox_text (format_entry, id);
     			ColorPicker.settings.color_format_index = id;
     		});


            // handle changed color in color history
            color_history.color_clicked.connect ((t, color) => {
                ext_active_color = (ExtRGBA) color;
                color_area.set_color (ext_active_color);
                color_area.queue_draw ();
                                   
                hex_label.set_markup (ext_active_color.to_uppercase_hex_string ());
                                
                int id = color_format_combobox.get_active ();                
                update_color_format_combobox_text (format_entry, id);
                
                this.present ();                    
            });
            
            
            // trigger picker on startup
            this.show.connect(() => {            
                pick_color_button.clicked ();
            });
                                  
            
        }
        
        private void update_color_format_combobox_text (Gtk.Entry format_entry, int id) {			
           switch (id) {
               case 0:
                   format_entry.text = ext_active_color.to_uppercase_hex_string ();
                   break;
               case 1:
                   format_entry.text = ext_active_color.to_hex_string ();
                   break;
               case 2:
                   format_entry.text = ext_active_color.to_css_rgb_string ();
                   break;
               case 3:
                   format_entry.text = ext_active_color.to_css_rgba_string ();
                   break;
               case 4:
                   format_entry.text = ext_active_color.to_gdk_rgba_string ();
                   break;
               case 5:
                   format_entry.text = ext_active_color.to_qml_qt_rgba_string ();
                   break;
           }
        }
        
        public override bool delete_event (Gdk.EventAny event) {   
            // save window position             
            int root_x, root_y;
            get_position (out root_x, out root_y);
            
            settings.window_x = root_x;
            settings.window_y = root_y;
            
            return false;
        }
        
    }
    
    
} 
