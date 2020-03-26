# Project name and programming language
project('site.marie-joseph.git.prettymines', 'vala', 'c')

# Create a new executable, list the files we want to compile, list the dependencies we need, and install
executable(
    meson.project_name(),

    # Application and utilities files
    'src/Application.vala',

    # Metawidgets
    'src/widgets/PlayField.vala',
    'src/widgets/Header.vala',
    'src/widgets/GameWindow.vala',
    'src/widgets/GameMenu.vala',

    # Specialized buttons
    'src/widgets/buttons/MineButton.vala',

    dependencies: [
        dependency('gtk+-3.0')
    ],
    install: true
)
