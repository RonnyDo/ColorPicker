sudo rm -r build
meson build
cd build
mesonconf -Dprefix=/usr
ninja
./com.github.ronnydo.colorpicker
cd ..
