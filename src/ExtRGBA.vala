namespace ColorPicker {

    public struct ExtRGBA : Gdk.RGBA {

        /* format like #3f92aa */
        public string to_hex_string () {        
            string s = "#%02x%02x%02x"
                .printf((uint) (this.red * 255),
                        (uint) (this.green * 255),
                        (uint) (this.blue * 255));
            return s;
        }
        
        /* format like #3F92AA */
        public string to_uppercase_hex_string () {
            return this.to_hex_string ().up ();
        }
        
        /* format like rgb(211, 32, 128) */
        public string to_css_rgb_string () {
        
            string s = "rgb(%i, %i, %i)"
                .printf((int) (this.red * 255),
                        (int) (this.green * 255),
                        (int) (this.blue * 255));
            return s;
        }


        /* format like rgba(211, 32, 128, 1) */
        public string to_css_rgba_string () {        
            string s = "rgba(%i, %i, %i, 1)"
                .printf((int) (this.red * 255),
                        (int) (this.green * 255),
                        (int) (this.blue * 255));                
            return s;
        }
        
        
        /* format like Gdk.RGBA(211, 32, 128, 1) */
        public string to_gdk_rgba_string () {        
            string s = "Gdk.RGBA(%i, %i, %i, 1.0)"
                .printf((int) (this.red * 255),
                        (int) (this.green * 255),
                        (int) (this.blue * 255));                
            return s;
        }


        /* format like QML.Gdk.RGBA(211, 32, 128, 1) */
        public string to_qml_qt_rgba_string () {        
            string s = "Qt.rgba(%i, %i, %i, 1.0)"
                .printf((int) (this.red * 255),
                        (int) (this.green * 255),
                        (int) (this.blue * 255));                
            return s;
        }       

    }
}
