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
    
    public class ColorPickerApp : Granite.Application {
    
        private static ColorPickerApp app;
        private ColorPickerWindow window = null;
        
        
        construct {
            var quit_action = new SimpleAction ("quit", null);
            quit_action.activate.connect (() => {
             if (window != null) {
                 window.destroy ();
             }
            });

            add_action (quit_action);
            add_accelerator ("<Control>q", "app.quit", null);
        }
        
        public static ColorPickerApp get_instance () {
            if (app == null) {
             app = new ColorPickerApp ();
            }

            return app;
        }
        
        protected override void activate () {
            window = new ColorPickerWindow();
            window.set_application (this);
            window.show_all ();
        }
        
        public static int main (string[] args) {
            Gtk.init (ref args);
            
            app = new ColorPickerApp ();
            
            app.run(args);

/*
            var window = new Gtk.Window ();
            window.title = "Hello World!";-
            //window.set_border_width (12);
            //window.set_position (Gtk.WindowPosition.CENTER);
            window.set_default_size (350, 70);
            //window.destroy.connect (Gtk.main_quit);

            var button_hello = new Gtk.Button.with_label ("Click me!");
            button_hello.clicked.connect (() => {
                var mouse_position = new ColorPicker.Widgets.MousePosition ();
                mouse_position.show_all ();
                
                mouse_position.moved.connect ((t, color) => {
                    button_hello.label = color.to_string ();
                });                

                mouse_position.cancelled.connect (() => {
                    mouse_position.close ();
                    window.present ();
                });

                var win = mouse_position.get_window ();
                
                mouse_position.picked.connect ((t, color) => {
                
                    mouse_position.close ();
                    window.present ();                    
                });
            });

            window.add (button_hello);
            window.show_all ();
*/

            Gtk.main ();
            return 0;   
        }

    }
}
