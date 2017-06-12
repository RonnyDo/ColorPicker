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
    
    public class ColorArea: Gtk.DrawingArea {
        
        private Gdk.RGBA color;
        
        public ColorArea () {
            set_size_request (140, 140);
            
            color.parse("#EEEEEE");            
        }

        /* Widget is asked to draw itself */
        public override bool draw (Cairo.Context ctx) {
            // Get necessary data:
            weak Gtk.StyleContext style_context = get_style_context ();
            int width = get_allocated_width ();
            int height = get_allocated_height ();

            // Draw an arc:
            double xc = width / 2.0;
            double yc = height / 2.0;
            double radius = (int.min (width, height) / 2.0);
            double angle1 = 0;
            double angle2 = 2*Math.PI;
                        
            
            int shadow_width = 6;
            double shadow_alpha = 1.0;
            string shadow_color = "#A9A9A9";
            for (int i = 1; i <= shadow_width; i++) {
                ctx.arc (xc, yc, radius - i, angle1, angle2);
                Gdk.RGBA c = new Gdk.RGBA();
                c.parse(shadow_color);
                //c.alpha = i* shadow_inc;      
                c.alpha = shadow_alpha / ((shadow_width - i + 1)*(shadow_width - i + 1));   
                Gdk.cairo_set_source_rgba (ctx, c); 
                ctx.stroke ();
            }      
            
            ctx.arc (xc, yc, radius - shadow_width, angle1, angle2);
            Gdk.cairo_set_source_rgba (ctx, this.color); 
            ctx.fill ();
            
            return true;
        }
        
        public void set_color (Gdk.RGBA color) {
           this.color = color;
        }
    }    
}
