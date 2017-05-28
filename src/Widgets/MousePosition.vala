// inspired by https://github.com/elementary/screenshot-tool/blob/master/src/Widgets/SelectionArea.vala

namespace ColorPicker.Widgets {

    public class MousePosition : Granite.Widgets.CompositedWindow {
        public signal void picked (Gdk.RGBA color);
        public signal void cancelled ();
        public signal void moved (Gdk.RGBA color);

        private Gdk.Point point;

        construct {
            type = Gtk.WindowType.POPUP;
        }

        public MousePosition () {
            stick ();
            set_resizable (true);
            set_deletable (false);
            set_has_resize_grip (false);
            set_skip_taskbar_hint (true);
            set_skip_pager_hint (true);
            set_keep_above (true);

            var screen = get_screen ();
            set_default_size (screen.get_width (), screen.get_height ());
        }   

        
        public override bool button_release_event (Gdk.EventButton e) {
            if (e.button != 1) {
                return true;
            }

            Gdk.RGBA color = get_color_at ((int) e.x_root, (int) e.y_root);
            picked (color);

            return true;            
        }


        public override bool motion_notify_event (Gdk.EventMotion e) {
            Gdk.RGBA color = get_color_at ((int) e.x_root, (int) e.y_root);
            moved (color);
            
            return true;            
        }


        public override bool key_press_event (Gdk.EventKey e) {
            if (e.keyval == Gdk.Key.Escape) {
                cancelled ();
            }

            return true;            
        }

        public Gdk.RGBA get_color_at (int x, int y) {
            Gdk.Window win = Gdk.get_default_root_window ();
            Gdk.Pixbuf? pixbuf = Gdk.pixbuf_get_from_window (win, x, y, 1, 1);

            if (pixbuf != null) {                
                // see https://hackage.haskell.org/package/gtk3-0.14.6/docs/Graphics-UI-Gtk-Gdk-Pixbuf.html
                uint8 red = pixbuf.get_pixels()[0];
                uint8 green = pixbuf.get_pixels()[1];
                uint8 blue = pixbuf.get_pixels()[2];
                
                Gdk.RGBA color = Gdk.RGBA();
                string spec = "rgb(" + red.to_string() + "," + green.to_string() + "," + blue.to_string() + ")";
                if (color.parse (spec)) {
                    return color;                   
                } else {
                    stdout.printf("ERROR: Parse pixel rgb values failed.");
                }                
            }
            
            // fallback: default RGBA color
            stdout.printf("ERROR: Gdk.pixbuf_get_from_window failed");
            return Gdk.RGBA ();
        }


        public override void show_all () {
            base.show_all ();
            var manager = Gdk.Display.get_default ().get_device_manager ();
            var pointer = manager.get_client_pointer ();
            var keyboard = pointer.get_associated_device ();
            var window = get_window ();

            var status = pointer.grab (window,
                        Gdk.GrabOwnership.NONE,
                        false,
                        Gdk.EventMask.BUTTON_PRESS_MASK | Gdk.EventMask.BUTTON_RELEASE_MASK | Gdk.EventMask.POINTER_MOTION_MASK,
                        new Gdk.Cursor.for_display (window.get_display (), Gdk.CursorType.CROSSHAIR),
                        Gtk.get_current_event_time ());

            if (status != Gdk.GrabStatus.SUCCESS) {
                pointer.ungrab (Gtk.get_current_event_time ());
            }

            if (keyboard != null) {
                status = keyboard.grab (window,
                        Gdk.GrabOwnership.NONE,
                        false,
                        Gdk.EventMask.KEY_PRESS_MASK,
                        null,
                        Gtk.get_current_event_time ());

                if (status != Gdk.GrabStatus.SUCCESS) {
                    keyboard.ungrab (Gtk.get_current_event_time ());
                }                
            }
        }

        public new void close () {
            get_window ().set_cursor (null);
            base.close ();
        }

        /*
        public override bool draw (Cairo.Context ctx) {
            if (!dragging) {
                return true;
            }

            int w = get_allocated_width ();
            int h = get_allocated_height ();

            ctx.rectangle (0, 0, w, h);
            ctx.set_source_rgba (0.1, 0.1, 0.1, 0.2);
            ctx.fill ();

            ctx.rectangle (0, 0, w, h);
            ctx.set_source_rgb (0.7, 0.7, 0.7);
            ctx.set_line_width (1.0);
            ctx.stroke ();

            return base.draw (ctx);
        }
    */



    }

}
