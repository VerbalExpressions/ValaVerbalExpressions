libverbex_sources = files('libverbex.vala')

api_version = '1.0'

verbex_lib = library(
    f'verbex-@api_version@',
    libverbex_sources,
    dependencies: deps,
    vala_header: 'libverbex.h',
    vala_vapi: f'verbex-@api_version@.vapi',
    vala_gir: f'Verbex-@api_version@.gir',
    install: true,
)

libverbex_dep = declare_dependency(
    link_with: verbex_lib,
    include_directories: include_directories('.'),
)
link_deps = ['glib-2.0', 'gobject-2.0']

configure_file(
    input: 'verbex.deps.in',
    output: f'verbex-@api_version@.deps',
    configuration: {'DEPS': '\n'.join(link_deps)},
    install: true,
    install_dir: get_option('datadir') / 'vala' / 'vapi',
)

pkgconfig = import('pkgconfig')
pkgconfig.generate(
    requires: link_deps,
    libraries: verbex_lib,
    name: 'Verbal Expressions',
    filebase: f'verbex-@api_version@',
    description: 'Simple alternative to regular expressions',
    version: meson.project_version(),
    subdirs: f'verbex-@api_version@',
)

