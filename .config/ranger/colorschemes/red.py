# ~/.config/ranger/colorschemes/mijn_roze.py

from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import default_colors

class MijnRoze(ColorScheme):
    progress_bar_color = 13  # Lichtroze voor de voortgangsbalk

    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors
        elif context.in_browser:
            if context.selected:
                fg = 15
                bg = 9  # Lichtroze achtergrondkleur voor geselecteerde items
            else:
                fg = 13  # Lichtroze tekstkleur
        elif context.highlight:
            fg = 9  # Magenta kleur voor highlights

        return fg, bg, attr
