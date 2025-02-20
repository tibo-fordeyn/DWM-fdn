/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
/* -fn option overrides fonts[0]; default X11 font or font set */

//static const char *fonts[] = {
//    "monospace:size=24"
//};
static const char *fonts[] = { "Haskplex:pixelsize=19:antialias=true:autohint=true" };
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static const unsigned int alpha = 0xbb;     /* Amount of opacity. 0xff is opaque             */

#include "/home/dyntif/.cache/wal/colors-wal-dmenu.h"
//static const char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	//[SchemeNorm] = { "#72AEF5", "#1C1F22" },
	//[SchemeSel] = { "#1C1F22", "#72AEF5" },/*deze eerste veranderen*/
	//[SchemeSelHighlight] = { "#eeeeee", "#222222"  },
	//[SchemeNormHighlight] = { "#BBC4D6", "#222222"  },
	//[SchemeOut] = { "#000000", "#000000"  },
//};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 20;
/* -h option; minimum height of a menu line */
static unsigned int lineheight = 30;
static unsigned int min_lineheight = 50;

static const unsigned int alphas[SchemeLast][2] = {
	[SchemeNorm] = { OPAQUE, alpha },
	[SchemeSel] = { OPAQUE, alpha },
	[SchemeOut] = { OPAQUE, alpha },
};



/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/* Size of the window border */
static const unsigned int border_width = 5;

