project('com.github.ronnydo.colorpicker', ['vala', 'c'],
    version: '0.1.2',
    license: 'GPL-3.0'
)

gnome = import('gnome')
i18n = import('i18n')

conf = configuration_data()
conf.set_quoted('GETTEXT_PACKAGE', meson.project_name())
configure_file(output: 'config.h', configuration: conf)
config_h_dir = include_directories('.')


c_args = [
  '-include', 'config.h'
]

executable(
    'com.github.ronnydo.colorpicker',
    'src/ColorPicker.vala',
    'src/ColorPickerWindow.vala',
    'src/ExtRGBA.vala',
    'src/Widgets/ColorArea.vala',
    'src/Widgets/ColorHistory.vala',
    'src/Widgets/MousePosition.vala',
    c_args: c_args,
    dependencies: [
        dependency('granite'),
        dependency('gtk+-3.0'),
    ],
    install : true
)

#meson.add_install_script('meson/post_install.py')

subdir('data')
subdir('po')