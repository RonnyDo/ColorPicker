project('com.github.ronnydo.colorpicker', ['vala', 'c'],
    version: '0.1.1'
)

gnome = import('gnome')
#i18n = import('i18n')

conf = configuration_data()
conf.set_quoted('GETTEXT_PACKAGE', meson.project_name())
configure_file(output: 'config.h', configuration: conf)
config_h_dir = include_directories('.')

executable(
    'com.github.ronnydo.colorpicker',
    'src/ColorPicker.vala',
    'src/ColorPickerWindow.vala',
    'src/ExtRGBA.vala',
    'src/Widgets/ColorArea.vala',
    'src/Widgets/ColorHistory.vala',
    'src/Widgets/MousePosition.vala',
    dependencies: [
        dependency('granite'),
        dependency('gtk+-3.0'),
    ],
    install : true
)

#meson.add_install_script('meson/post_install.py')

subdir('data')
#subdir('po')
