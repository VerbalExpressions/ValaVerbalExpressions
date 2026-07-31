verbex_tests = [
    
    'add_modifier_test',
    'add_test',
    'digits_test',
    'end_of_line_test',
    'maybe_test',
    'multiple_test',
    'or_test',
    'range_test',
    'remove_modifier_test',
    'repeat_test',
    'sanitize_test',
    'something_but_test',
    'something_test',
    'start_of_line_test',
    'then_test',
    'utility_test',
    'verbex_test',
    'with_any_case_test',
]

foreach name : verbex_tests
    test(
        name,
        executable(
            name,
            name + '.vala',
            dependencies: [glib, gobject, gio, libverbex_dep],
        ),
        env: ['G_TEST_SRCDIR=' + meson.current_source_dir()],
    )
endforeach
