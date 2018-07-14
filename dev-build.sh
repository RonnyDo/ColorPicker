sudo rm -r build
meson build
cd build
meson configure -Dprefix=/usr
ninja
./com.github.ronnydo.colorpicker
cd ..
