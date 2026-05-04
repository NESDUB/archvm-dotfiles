# Lattice OS Theme Tokens

This folder is the canonical reference for Lattice OS colors and typography.

It does not automatically generate all configs yet. Each app still has its own syntax:

- Ironbar / GTK CSS uses `@define-color`
- Fuzzel uses ARGB hex in `fuzzel.ini`
- Foot uses RGB hex in `foot.ini`
- Mako uses RGBA hex in `config`
- Sway wallpaper uses SVG/PNG source files

The goal is to keep visual drift low as the shell grows.
