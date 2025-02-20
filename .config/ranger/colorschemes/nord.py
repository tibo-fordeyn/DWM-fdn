# ~/.config/ranger/colorschemes/nord.py

from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import default_colors

class Nord(ColorScheme):
    progress_bar_color = 4

    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors
        elif context.in_browser:
            if context.selected:
                fg = 15
            else:
                fg = 4
        elif context.highlight:
            fg = 14

        return fg, bg, attr
from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import default_colors

class Nord(ColorScheme):
    progress_bar_color = 4

    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors
        elif context.in_browser:
            if context.selected:
                fg = 15
                bg = 4  # De achtergrondkleur van het geselecteerde item
            else:
                fg = 4
        elif context.highlight:
            fg = 14

        return fg, bg, attr

