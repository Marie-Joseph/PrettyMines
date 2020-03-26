Pretty Mines is a simple Minesweeper clone written in Vala and using Gtk.

This particular implementation of Minesweeper was designed for elementary OS,
and uses default system icons as such. It should work with most any
freedesktop.org-compliant desktop environment, but the mines may not look like
mines.

The only build dependencies are Gtk3, Vala, and meson, and the procedure is the standard for meson.

`meson build`
`cd build`
`ninja`

Obviously, if you want to install it, that's a simple
`ninja install`

I've removed the timer because it always stressed me out. So, just relax and enjoy!
