# Pretty Mines

Pretty Mines is a simple Minesweeper clone written in Vala and using Gtk.

## Quirks

This particular implementation of Minesweeper was designed for elementary OS,
and uses default system icons as such. It should work with most any
freedesktop.org-compliant desktop environment, but the mines may not look like
mines.

I've removed the timer because it always stressed me out. So, just relax and enjoy!

## Compilation

The only build dependencies are Gtk3, Vala, and meson. The procedure is the standard for meson.

```
meson build
cd build
ninja
```

Obviously, if you want to install it, that's a simple
`ninja install`

## Goals

These are some features I'd eventually like to implement. If you'd like to help out, feel free to open a PR explaining what you've done. Any improvements you make to existing functionality are welcome as well.

* "protected" first click (first click is guaranteed to be safe)
* infinite mode
* off-by-default timer
* player-defined sizes
* player-defined mine ratio/number
* earn the name on own merits
    * custom icons
    * custom theme