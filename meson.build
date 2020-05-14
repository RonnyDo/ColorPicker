# Project name, programming language and version
project (
    'com.github.ronnydo.colorpicker',
    'vala', 'c',
    version: '1.1.5',
    license: 'GPL-3.0'
)

# Translation module
i18n = import ('i18n')

# Project arguments
add_project_arguments (
    '-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name ()),
    language: 'c'
)

# Listing dependencies
dependencies = [
    dependency ('glib-2.0'),
    dependency ('gtk+-3.0'),
    dependency ('granite'),
    dependency ('gobject-2.0')
]

subdir ('src')

# Executable
executable (
    meson.project_name (),
    sources,
    dependencies: dependencies,
    install : true
)

subdir ('data')
subdir ('po')

meson.add_install_script ('meson/post_install.py')
