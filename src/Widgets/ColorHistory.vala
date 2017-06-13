namespace ColorPicker {
    
    public class ColorHistory: Gtk.DrawingArea {
        
        const int max_colors = 6;
        Gee.ArrayList<Gdk.RGBA?> color_list;
        
        const int border_width = 1;
        const string border_color_string = "rgba(50, 50, 50, 0.4)";
        private Gdk.RGBA border_color = new Gdk.RGBA();
        
        const string triangle_color_string = "#F5F5F5";
        private Gdk.RGBA triangle_color = new Gdk.RGBA();
        
        
        int shadow_width = 16;    
        const string shadow_color_string = "#000000"; 
        //const string shadow_color_string = "#A9A9A9";
        
        
        public ColorHistory () {
            set_size_request (100, 28);
            color_list = new Gee.ArrayList<Gdk.RGBA?> ();
            
            border_color.parse (border_color_string); 
            
            triangle_color.parse (triangle_color_string);
            
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
            
            // colorboxes
            for (int i = 0; i < color_list.size; i++) {     
                ctx.move_to (i * width / color_list.size, 0);
                // fix: +1 to overlap boxes, otherwise small gaps appear
                ctx.rel_line_to (width / color_list.size + 1, 0);
                ctx.rel_line_to (0, height);
                // fix: -1 to overlap boxes
                ctx.rel_line_to (-1 * width / color_list.size - 1, 0);
                ctx.close_path ();
                                
                Gdk.cairo_set_source_rgba (ctx, color_list.get(i));
                
                ctx.fill ();
            }
            
             
            // simple shade
            var fixed_border_width = border_width + 1;
            ctx.new_path ();
            ctx.move_to (border_width, border_width);
            ctx.rel_line_to (width - (border_width) * 2, 0);
            Gdk.RGBA s = Gdk.RGBA();
            //s.parse("rgba(255, 255, 255, 0.8)");
            s.parse("rgba(33, 33, 33, 0.2)");  
            Gdk.cairo_set_source_rgba (ctx, s); 
            
            ctx.set_line_width (border_width);   
            ctx.stroke ();
             
            
            
           /*
            // real faded shade
            for (int i = 1; i <= shadow_width; i++) {            
                ctx.new_path ();
                ctx.move_to (border_width, shadow_width - i - 1);
                ctx.rel_line_to (width - 2 * border_width, 0);
                Gdk.RGBA shadow_color = Gdk.RGBA();
                shadow_color.parse(shadow_color_string);
                double shadow_alpha = 1.0;   
                shadow_color.alpha = shadow_alpha / ((shadow_width - i + 1)*(shadow_width - i + 1)); 
                
                
                debug(shadow_color.alpha.to_string());
                Gdk.cairo_set_source_rgba (ctx, shadow_color); 
                ctx.stroke ();
            }
            */
               
            // colorboxes border
            ctx.new_path ();
            ctx.move_to (0, 0);
            ctx.rel_line_to (width, 0);
            ctx.rel_line_to (0, height);      
            ctx.rel_line_to (-1 * width, 0);     
            ctx.close_path ();
              
            Gdk.cairo_set_source_rgba (ctx, border_color);      
            // fix: stright lines must be + 1 to appear same as diagonales
            ctx.set_line_width (border_width + 1);   
                      
            ctx.stroke ();
            
            
            /*
            // triangle (Is used to indicate the selected color, which isn't implemented yet)        
            if (color_list.size > 0) {
                ctx.new_path ();
                int triangle_height = 10;
                int triangle_width = 20;
                ctx.move_to (width - width / color_list.size / 2, height - triangle_height);
                ctx.rel_line_to (triangle_width / 2, triangle_height);
                ctx.rel_line_to (-1 * triangle_width, 0);
                ctx.close_path ();  
                                       
                Gdk.cairo_set_source_rgba (ctx, triangle_color);
                
                ctx.fill ();       
                
                // triangle border
                ctx.new_path ();
                ctx.move_to (width - width / color_list.size / 2 - triangle_width / 2, height);
                ctx.rel_line_to (triangle_width / 2, -1 * triangle_height);
                ctx.rel_line_to (triangle_width / 2, triangle_height);
                Gdk.cairo_set_source_rgba (ctx, border_color);
                
                ctx.set_line_width (border_width);
                
                ctx.stroke ();  
            }
            */
            
            return true;
        }
    }
}
