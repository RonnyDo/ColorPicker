sudo rm -r build
meson build
cd build
meson configure -Dprefix=/usr
ninja

sudo cp ../data/com.github.ronnydo.colorpicker.gschema.xml /usr/share/glib-2.0/schemas/
sudo glib-compile-schemas /usr/share/glib-2.0/schemas/

G_MESSAGES_DEBUG=all ./com.github.ronnydo.colorpicker
cd ..
