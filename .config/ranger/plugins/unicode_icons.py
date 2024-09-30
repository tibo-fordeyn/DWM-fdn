from __future__ import absolute_import, division, print_function

import ranger.api
from ranger.core.linemode import LinemodeBase

# Linemode met Noto Color Emoji voor neutrale emoji's
@ranger.api.register_linemode
class MyLinemode(LinemodeBase):
    name = "unicode_icons"

    def filetitle(self, fobj, metadata):
        if fobj.is_directory:
            icon = '📁'  # Noto Color Emoji map symbool
        elif fobj.is_link:
            icon = '🔗'  # Link symbool
        elif fobj.audio:
            icon = '🎧'  # Audio symbool
        elif fobj.container:
            icon = '📦'  # Container symbool
        elif fobj.document:
            icon = '📄'  # Document symbool
        elif fobj.image:
            icon = '📄'  # Afbeelding symbool
        elif fobj.video:
            icon = '📄'  # Video symbool
        else:
            icon = '📄'  # Algemeen bestandssymbool
        return (icon + ' ' if icon else '') + fobj.relative_path

    def infostring(self, fobj, metadata):
        raise NotImplementedError
