namespace ColorPicker {
    
    public class ColorHistory: Gtk.DrawingArea {
        
        const int max_colors = 6;
        Gee.ArrayList<Gdk.RGBA?> color_list;
        
        public ColorHistory () {
            set_size_request (100, 30);
            color_list = new Gee.ArrayList<Gdk.RGBA?> ();
            
            Gdk.RGBA c1 = new Gdk.RGBA();
            c1.parse ("#FE3478");   
            //add_color (c1);
                     
            Gdk.RGBA c2 = new Gdk.RGBA();
            c2.parse ("#82A32E");   
            //add_color (c2);
        }
        
        public void add_color (Gdk.RGBA color) {
            if (color_list.size == max_colors) {
                remove_oldest_color ();
            }
            color_list.add (color);            
        }
        
        public void remove_oldest_color () {
            color_list.remove_at (0);
        }
        
        public Gee.ArrayList<Gdk.RGBA?> get_color_list () {
            return color_list;
        }
              
        /* Widget is asked to draw itself */
        public override bool draw (Cairo.Context ctx) {
            
            weak Gtk.StyleContext style_context = get_style_context ();
           
        
            int width = get_allocated_width (); // better element_width / amount
            int height = get_allocated_height ();
            
            // draw colorlist
            for (int i = 0; i < color_list.size; i++) {                
                ctx.move_to (i * width / color_list.size, 0);
                ctx.rel_line_to (width / color_list.size, 0);
                ctx.rel_line_to (0, height);
                ctx.rel_line_to (-1 * width / color_list.size, 0);
                ctx.close_path ();
                
                Gdk.cairo_set_source_rgba (ctx, color_list.get(i));
                
                ctx.fill ();
            }
            
            // draw triangle            
            if (color_list.size > 0) {
                ctx.new_path ();
                int triangle_height = 10;
                int triangle_width = 20;
                ctx.move_to (width - width / color_list.size / 2, height - triangle_height);
                ctx.rel_line_to (triangle_width / 2, triangle_height);
                ctx.rel_line_to (-1 * triangle_width, 0);
                ctx.close_path ();
                
                Gdk.RGBA c_grey = new Gdk.RGBA();
                c_grey.parse ("#F5F5F5");                
                Gdk.cairo_set_source_rgba (ctx, c_grey);
                
                ctx.fill ();          
            }
            
            
            return true;
        }
    }
}
