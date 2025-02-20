/* See LICENSE file for copyright and license details. */

/* Constants */
#define TERMINAL "st"
#define TERMCLASS "St"
#define BROWSER "firefox"

/* appearance */
static unsigned int borderpx  = 0;        /* border pixel of windows */
static unsigned int snap      = 32;       /* snap pixel */
static unsigned int gappih    = 20;       /* horiz inner gap between windows */
static unsigned int gappiv    = 20;       /* vert inner gap between windows */
static unsigned int gappoh    = 60;       /* horiz outer gap between windows and screen edge */
static unsigned int gappov    = 70;       /* vert outer gap between windows and screen edge */
static int swallowfloating    = 0;        /* 1 means swallow floating windows by default */
static int smartgaps          = 0;        /* 1 means no outer gap when there is only one window */
static int showbar            = 1;        /* 0 means no bar */
static int topbar             = 1;        /* 0 means bottom bar */

static const int vertpad            = 35;       /* vertical padding of bar */
static const int sidepad            = 140;       /* horizontal padding of bar */

//static char *fonts[] = { "Haskplex:pixelsize=17:antialias=true:autohint=true" };
//static char *emoji_font[] = { "NotoColorEmoji:pixelsize=10:antialias=true:autohint=true" };
static char *fonts[] = {
    "JetBrainsMono Nerd Font:pixelsize=20:antialias=true:autohint=true",
};




static char normbgcolor[]           = "#9C9FA5";/*derde kleur*/
static char normbordercolor[]       = "#444444";
static char normfgcolor[]           = "#bbbbbb";
static char selfgcolor[]            = "#eeeeee";
static char selbordercolor[]        = "#1C1F22";/*eerste kleur*/
static char selbgcolor[]            = "#72AEF5";/*tweede kleur*/

// alpha patch
static const unsigned int baralpha = 0x55;
static const unsigned int borderalpha = OPAQUE;

#include "/home/dyntif/.cache/wal/colors-wal-dwm.h"
//static char *colors[][3] = {
       /*               fg           bg           border   */
       //[SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
       //[SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor  },
//};
// Uitgecomment voor het gebruik van wal kleuren
// tbf ik denk niet dat ik de wal kleuren helemaal correct heb toegepast hier,
// maar het lijkt te werken dus ik laat het zo staan.
//
// Andere code voor alpha patch;
static const unsigned int alphas[][3]      = {
    /*               fg      bg        border*/
    	[SchemeNorm] = { OPAQUE, baralpha, borderalpha },
	[SchemeSel]  = { OPAQUE, baralpha, borderalpha },
};





/* terminal */
typedef struct {
	const char *name;
	const void *cmd;
} Sp;
const char *spcmd1[] = {TERMINAL, "-n", "spterm", "-g", "40x15", NULL };
const char *spcmd2[] = {TERMINAL, "-n", "spcalc", "-f", "monospace:size=16", "-g", "50x20", "-e", "bc", "-lq", NULL };
static Sp scratchpads[] = {
	/* name          cmd  */
	{"spterm",      spcmd1},
	{"spcalc",      spcmd2},
};




/* tagging */
//static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };
//static const char *tags[] = {
    //"", "", "", "", "", "", "", "", ""
//};
static const char *tags[] = { "①", "②", "③", "④", "⑤", "⑥", "⑦", "⑧", "⑨" };



static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	*/
	/* class    instance      title       	 tags mask    isfloating   isterminal  noswallow  monitor */
	{ "Gimp",     NULL,       NULL,       	    1 << 8,       0,           0,         0,        -1 },
	{ TERMCLASS,  NULL,       NULL,       	    0,            0,           1,         0,        -1 },
	{ NULL,       NULL,       "Event Tester",   0,            0,           0,         1,        -1 },
	{ TERMCLASS,      "floatterm", NULL,       	    0,       1,           1,         0,        -1 },
	{ TERMCLASS,      "bg",        NULL,       	    1 << 7,       0,           1,         0,        -1 },
	{ TERMCLASS,      "spterm",    NULL,       	    SPTAG(0),     1,           1,         0,        -1 },
	{ TERMCLASS,      "spcalc",    NULL,       	    SPTAG(1),     1,           1,         0,        -1 },
	/*Inkscape beter openen*/
	{ "Inkscape",  NULL,       NULL,       0,       1,           0,         0,        -1 },
};




/* layout(s) */
static float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static int nmaster     = 1;    /* number of clients in master area */
static int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */
#define FORCE_VSPLIT 1  /* nrowgrid layout: force two clients to always split vertically */
#include "vanitygaps.c"

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[@]",	spiral },		/* Fibonacci spiral */
	{ "[]=",	tile },			/* Default: Master on left, slaves on right */
	{ "TTT",	bstack },		/* Master on top, slaves on bottom */

	{ "[\\]",	dwindle },		/* Decreasing in size right and leftward */

	{ "[D]",	deck },			/* Master on left, slaves in monocle-like mode on right */
	{ "[M]",	monocle },		/* All windows on top of eachother */

	{ "|M|",	centeredmaster },		/* Master in middle, slaves on sides */
	{ ">M>",	centeredfloatingmaster },	/* Same but master floats */

	{ "><>",	NULL },			/* no layout function means floating behavior */
	{ NULL,		NULL },
};




/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },
#define STACKKEYS(MOD,ACTION) \
	{ MOD,	XK_j,	ACTION##stack,	{.i = INC(+1) } }, \
	{ MOD,	XK_k,	ACTION##stack,	{.i = INC(-1) } }, \
	{ MOD,  XK_v,   ACTION##stack,  {.i = 0 } }, \
	/* { MOD, XK_grave, ACTION##stack, {.i = PREVSEL } }, \ */
	/* { MOD, XK_a,     ACTION##stack, {.i = 1 } }, \ */
	/* { MOD, XK_z,     ACTION##stack, {.i = 2 } }, \ */
	/* { MOD, XK_x,     ACTION##stack, {.i = -1 } }, */
/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }




/* commands */
static const char *termcmd[]  = { TERMINAL, NULL };
/*
 * Xresources preferences to load at startup
 * Ik ben er redelijk zeker van dat je deze kleuren zou kunnen veranderen naar
 * waarden uit de colors-wal-dwm.h, maar voorlopig werkt het zonder dat te doen
 */
ResourcePref resources[] = {
		{ "color0",		STRING,	&normbordercolor },
		{ "color8",		STRING,	&selbordercolor },
		{ "color0",		STRING,	&normbgcolor },
		{ "color4",		STRING,	&normfgcolor },
		{ "color0",		STRING,	&selfgcolor },
		{ "color4",		STRING,	&selbgcolor },
		{ "borderpx",		INTEGER, &borderpx },
		{ "snap",		INTEGER, &snap },
		{ "showbar",		INTEGER, &showbar },
		{ "topbar",		INTEGER, &topbar },
		{ "nmaster",		INTEGER, &nmaster },
		{ "resizehints",	INTEGER, &resizehints },
		{ "mfact",		FLOAT,	&mfact },
		{ "gappih",		INTEGER, &gappih },
		{ "gappiv",		INTEGER, &gappiv },
		{ "gappoh",		INTEGER, &gappoh },
		{ "gappov",		INTEGER, &gappov },
		{ "swallowfloating",	INTEGER, &swallowfloating },
		{ "smartgaps",		INTEGER, &smartgaps },
};




/* keybinds */
#include <X11/XF86keysym.h>
#include "shiftview.c"
/* A very important thing to note here is that I use azerty, belgian, no dead
 * keys, therefore, if you have a different layout, some of these keys
 * may not exist!!!! You should look at what keys are there for you and switch
 * them if need be. */
static const Key keys[] = {
	/* modifier                     key        function        argument */
	STACKKEYS(MODKEY,                          focus)
	STACKKEYS(MODKEY|ShiftMask,                push)

	/* { MODKEY|ShiftMask,		XK_Escape,	spawn,	SHCMD("") }, */
	{ MODKEY,			XK_grave,	spawn,	{.v = (const char*[]){ "dmenuunicode", NULL } } },
	/* { MODKEY|ShiftMask,		XK_grave,	togglescratch,	SHCMD("") }, */

	/*azerty nummer keys*/
	TAGKEYS(			XK_ampersand,		0)
	TAGKEYS(			XK_eacute,		1)
	TAGKEYS(			XK_quotedbl,		2)
	TAGKEYS(			XK_apostrophe,		3)
	TAGKEYS(			XK_parenleft,		4)
	TAGKEYS(			XK_section,		5)
	TAGKEYS(			XK_egrave,		6)
	TAGKEYS(			XK_exclam,		7)
	TAGKEYS(			XK_ccedilla,		8)
	/*{ MODKEY,			XK_0,		view,		{.ui = ~0 } },*/
	/*{ MODKEY|ShiftMask,		XK_0,		tag,		{.ui = ~0 } },*/

	{ MODKEY,			XK_BackSpace,	spawn,		{.v = (const char*[]){ "sysact", NULL } } },
	{ MODKEY|ShiftMask,		XK_BackSpace,	spawn,		{.v = (const char*[]){ "sysact", NULL } } },

	{ MODKEY,			XK_Tab,		view,		{0} },
	/* { MODKEY|ShiftMask,		XK_Tab,		spawn,		SHCMD("") }, */


	/* Alle letters van het alfabet*/
	{ MODKEY,			XK_a,		togglegaps,	{0} },
	{ MODKEY|ShiftMask,		XK_a,		defaultgaps,	{0} },

	{ MODKEY,			XK_b,		spawn,		SHCMD("/home/dyntif/.local/share/dmenu-scripting/bookmarkscript.sh") },
	{ MODKEY|ShiftMask,		XK_b,		togglebar,	{0} },

	{ MODKEY,			XK_c,		spawn,		{.v = (const char*[]){ TERMINAL, "-e", "profanity", NULL } } },
	/* { MODKEY|ShiftMask,		XK_c,		spawn,		SHCMD("") }, */

	{ MODKEY,			XK_d,		spawn,          {.v = (const char*[]){ "dmenu_run", NULL } } },
	{ MODKEY|ShiftMask,		XK_d,		spawn,		{.v = (const char*[]){ "passmenu", NULL } } },

	/*{ MODKEY|ShiftMask,		XK_e,		spawn,		SHCMD(TERMINAL "") },*/

	{ MODKEY,			XK_f,		togglefullscr,	{0} },
	{ MODKEY|ShiftMask,		XK_f,		setlayout,	{.v = &layouts[8]} },

	{ MODKEY,			XK_g,		shiftview,	{ .i = -1 } },
	{ MODKEY|ShiftMask,		XK_g,		shifttag,	{ .i = -1 } },

	{ MODKEY,			XK_h,		setmfact,	{.f = -0.05} },
	{ MODKEY|ShiftMask,		XK_h,		spawn,		SHCMD("/home/dyntif/.local/bin/mount-unmounter.sh")},

	{ MODKEY,			XK_i,		setlayout,	{.v = &layouts[6]} }, /* centeredmaster */
	{ MODKEY|ShiftMask,		XK_i,		setlayout,	{.v = &layouts[7]} }, /* centeredfloatingmaster */

	/* J and K are automatically bound above in STACKEYS, deze zijn
	 * fundamenteel */

	{ MODKEY,			XK_l,		setmfact,      	{.f = +0.05} },
	/*Hoofdletter L is natuurlijk een standaard key*/
	{ MODKEY,			XK_m,		spawn,		{.v = (const char*[]){ TERMINAL, "-e", "/home/dyntif/.config/scli/scli", NULL } } },
/* Hoofdletter m zet bepaalde processen uit, ik zou het niet aanraken
	 * als ik jou was, en ik ben jou */

	{ MODKEY,			XK_n,		focusmon,	{.i = +1 } },
	{ MODKEY|ShiftMask,		XK_n,		focusmon,	{.i = -1 } },
	/* dit kan ook met left en right*/

	{ MODKEY,			XK_o,		incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,		XK_o,		incnmaster,     {.i = -1 } },
	/* Ik heb dit niet kunnen doen werken, ik gebruik namelijk pulse en
	 * geen alsa */

	{ MODKEY,			XK_p,			spawn,		{.v = (const char*[]){ "mpc", "toggle", NULL } } },
	{ MODKEY|ShiftMask,		XK_p,			spawn,		SHCMD("mpc pause; pauseallmpv") },

	{ MODKEY,			XK_q,		killclient,	{0} },
	{ MODKEY|ShiftMask,		XK_q,		spawn,		{.v = (const char*[]){ "sysact", NULL } } },
	{ MODKEY|ControlMask|ShiftMask, XK_q,      quit,           {1}  }, 

	{ MODKEY,			XK_r,		spawn,		{.v = (const char*[]){ TERMINAL, "-e", "lfub", NULL } } },
	{ MODKEY|ShiftMask,		XK_r,		spawn,		{.v = (const char*[]){ TERMINAL, "-e", "htop", NULL } } },

	{ MODKEY,			XK_s,		spawn,		SHCMD("/home/dyntif/.local/share/dmenu-scripting/openfiles.sh") },
	{ MODKEY|ShiftMask,			XK_s,		spawn,		SHCMD("/home/dyntif/.local/bin/symlink.sh") },
	/*{ MODKEY|ShiftMask,		XK_s,		spawn,		SHCMD("scrot --file /home/dyntif/dl/screenshots/screenshot%d%s.png") },*/

	{ MODKEY,			XK_t,		setlayout,	{.v = &layouts[0]} }, /* tile */
	{ MODKEY|ShiftMask,		XK_t,		setlayout,	{.v = &layouts[1]} }, /* bstack */

	{ MODKEY,			XK_u,		setlayout,	{.v = &layouts[4]} }, /* deck */
	{ MODKEY|ShiftMask,		XK_u,		setlayout,	{.v = &layouts[5]} }, /* monocle */
	/* V is automatically bound above in STACKKEYS */

	{ MODKEY,			XK_w,		spawn,		{.v = (const char*[]){ BROWSER, NULL } } },
	{ MODKEY|ShiftMask,		XK_w,		spawn,		{.v = (const char*[]){ TERMINAL, "-e", "sudo", "nmtui", NULL } } },

	{ MODKEY,			XK_x,		spawn,		SHCMD("~/dl/themas/scripts/kleuren.sh") }, 
	{ MODKEY|ShiftMask,		XK_x,		incrgaps,	{.i = -3 } },

	{ MODKEY,			XK_y,		setlayout,	{.v = &layouts[2]} }, /* spiral */
	{ MODKEY|ShiftMask,		XK_y,		setlayout,	{.v = &layouts[3]} }, /* dwindle */

	{ MODKEY,		XK_z,		spawn,		SHCMD("~/.local/share/dmenu-scripting/restartmenu.sh") }, 
	{ MODKEY|ShiftMask,	XK_z,		incrgaps,	{.i = +3 } },


	/* Een paar andere waar ik niet meer aankom*/
	{ MODKEY,			XK_bracketleft,		spawn,		{.v = (const char*[]){ "mpc", "seek", "-10", NULL } } },
	{ MODKEY|ShiftMask,		XK_bracketleft,		spawn,		{.v = (const char*[]){ "mpc", "seek", "-60", NULL } } },
	{ MODKEY,			XK_bracketright,	spawn,		{.v = (const char*[]){ "mpc", "seek", "+10", NULL } } },
	{ MODKEY|ShiftMask,		XK_bracketright,	spawn,		{.v = (const char*[]){ "mpc", "seek", "+60", NULL } } },
	{ MODKEY,			XK_backslash,		view,		{0} },
	/* { MODKEY|ShiftMask,		XK_backslash,		spawn,		SHCMD("") }, */
	{ MODKEY,			XK_semicolon,	shiftview,	{ .i = 1 } },
	{ MODKEY|ShiftMask,		XK_semicolon,	shifttag,	{ .i = 1 } },
	{ MODKEY|ControlMask,		XK_apostrophe,	togglescratch,	{.ui = 1} },
	//{ MODKEY|ShiftMask,		XK_apostrophe,	togglesmartgaps,	{0} },
	{ MODKEY,			XK_Return,	spawn,		{.v = termcmd } },
	{ MODKEY|ShiftMask,		XK_Return,	togglescratch,	{.ui = 0} },
	{ MODKEY, 			XK_comma, 	spawn, 		SHCMD(TERMINAL " -e ~/.config/newsboat/newsboat-wrapper.sh") },

	{ MODKEY|ShiftMask,		XK_comma,	spawn,		{.v = (const char*[]){ "mpc", "seek", "0%", NULL } } },
	{ MODKEY,			XK_period,	spawn,		{.v = (const char*[]){ "mpc", "next", NULL } } },
	{ MODKEY|ShiftMask,		XK_period,	spawn,		{.v = (const char*[]){ "mpc", "repeat", NULL } } },
	{ MODKEY,			XK_space,	zoom,		{0} },
	{ MODKEY|ShiftMask,		XK_space,	togglefloating,	{0} },
	{ 0,				XK_Print,	spawn,		SHCMD("maim pic-full-$(date '+%y%m%d-%H%M-%S').png") },
	{ ShiftMask,			XK_Print,	spawn,		{.v = (const char*[]){ "maimpick", NULL } } },
	{ MODKEY,			XK_Print,	spawn,		{.v = (const char*[]){ "dmenurecord", NULL } } },
	{ MODKEY|ShiftMask,		XK_Print,	spawn,		{.v = (const char*[]){ "dmenurecord", "kill", NULL } } },
	{ MODKEY,			XK_Delete,	spawn,		{.v = (const char*[]){ "dmenurecord", "kill", NULL } } },
	{ MODKEY,			XK_Scroll_Lock,	spawn,		SHCMD("killall screenkey || screenkey &") },

	{ MODKEY,			XK_Left,	focusmon,	{.i = -1 } },
	{ MODKEY|ShiftMask,		XK_Left,	tagmon,		{.i = -1 } },
	{ MODKEY,			XK_Right,	focusmon,	{.i = +1 } },
	{ MODKEY|ShiftMask,		XK_Right,	tagmon,		{.i = +1 } },
	{ MODKEY|ShiftMask,		XK_n,		tagmon,		{.i = -1 } },

	{ MODKEY,			XK_Page_Up,	shiftview,	{ .i = -1 } },
	{ MODKEY|ShiftMask,		XK_Page_Up,	shifttag,	{ .i = -1 } },
	{ MODKEY,			XK_Page_Down,	shiftview,	{ .i = +1 } },
	{ MODKEY|ShiftMask,		XK_Page_Down,	shifttag,	{ .i = +1 } },


	/*F toetsen, tbf ik ben niet zeker of het bij mij goed werkt*/
	{ MODKEY,			XK_F2,		spawn,		{.v = (const char*[]){ "tutorialvids", NULL } } },
	{ MODKEY,			XK_F3,		spawn,		{.v = (const char*[]){ "displayselect", NULL } } },
	{ MODKEY,			XK_F5,		xrdb,		{.v = NULL } },
	{ MODKEY,			XK_F9,		spawn,		{.v = (const char*[]){ "mounter", NULL } } },
	{ MODKEY,			XK_F10,		spawn,		{.v = (const char*[]){ "unmounter", NULL } } },
	//{ MODKEY,			XK_F11,		spawn,		SHCMD("mpv --untimed --no-cache --no-osc --no-input-default-bindings --profile=low-latency --input-conf=/dev/null --title=webcam $(ls /dev/video[0,2,4,6,8] | tail -n 1)") },
	{ MODKEY,			XK_F12,		spawn,		SHCMD("remaps") },


	/*anders*/
	/* je moet hier nog een goed naar kijken en zaken toevoegen/verwjideren
	 * */
	{ 0, XF86XK_AudioPrev,		spawn,		{.v = (const char*[]){ "mpc", "prev", NULL } } },
	{ 0, XF86XK_AudioNext,		spawn,		{.v = (const char*[]){ "mpc",  "next", NULL } } },
	{ 0, XF86XK_AudioPause,		spawn,		{.v = (const char*[]){ "mpc", "pause", NULL } } },
	{ 0, XF86XK_AudioPlay,		spawn,		{.v = (const char*[]){ "mpc", "play", NULL } } },

	{ 0, XF86XK_AudioRaiseVolume, 	spawn, 		SHCMD("~/.local/bin/volume/volume-up.sh") },
    	{ 0, XF86XK_AudioLowerVolume, 	spawn, 		SHCMD("~/.local/bin/volume/volume-down.sh") },


	{ 0, XF86XK_AudioStop,		spawn,		{.v = (const char*[]){ "mpc", "stop", NULL } } },
	{ 0, XF86XK_AudioRewind,	spawn,		{.v = (const char*[]){ "mpc", "seek", "-10", NULL } } },
	{ 0, XF86XK_AudioForward,	spawn,		{.v = (const char*[]){ "mpc", "seek", "+10", NULL } } },
	{ 0, XF86XK_AudioMedia,		spawn,		{.v = (const char*[]){ TERMINAL, "-e", "ncmpcpp", NULL } } },
	{ 0, XF86XK_AudioMicMute,	spawn,		SHCMD("pactl set-source-mute @DEFAULT_SOURCE@ toggle") },
	/* { 0, XF86XK_PowerOff,		spawn,		{.v = (const char*[]){ "sysact", NULL } } }, */
	{ 0, XF86XK_Calculator,		spawn,		{.v = (const char*[]){ TERMINAL, "-e", "bc", "-l", NULL } } },
	{ 0, XF86XK_Sleep,		spawn,		{.v = (const char*[]){ "sudo", "-A", "zzz", NULL } } },
	{ 0, XF86XK_WWW,		spawn,		{.v = (const char*[]){ BROWSER, NULL } } },
	{ 0, XF86XK_DOS,		spawn,		{.v = termcmd } },
	{ 0, XF86XK_ScreenSaver,	spawn,		SHCMD("slock & xset dpms force off; mpc pause; pauseallmpv") },
	{ 0, XF86XK_TaskPane,		spawn,		{.v = (const char*[]){ TERMINAL, "-e", "htop", NULL } } },
	{ 0, XF86XK_MyComputer,		spawn,		{.v = (const char*[]){ TERMINAL, "-e",  "lfub",  "/", NULL } } },
	/* { 0, XF86XK_Battery,		spawn,		SHCMD("") }, */
	{ 0, XF86XK_Launch1,		spawn,		{.v = (const char*[]){ "xset", "dpms", "force", "off", NULL } } },
	{ 0, XF86XK_TouchpadToggle,	spawn,		SHCMD("(synclient | grep 'TouchpadOff.*1' && synclient TouchpadOff=0) || synclient TouchpadOff=1") },
	{ 0, XF86XK_TouchpadOff,	spawn,		{.v = (const char*[]){ "synclient", "TouchpadOff=1", NULL } } },
	{ 0, XF86XK_TouchpadOn,		spawn,		{.v = (const char*[]){ "synclient", "TouchpadOff=0", NULL } } },

	/*Mijn F toetsen die nog een beetje moeten worden aangevuld en
	 * verplaatst*/
	{ 0, 0xffc3, 			spawn, 		SHCMD("/home/dyntif/.local/bin/vl-ss.sh") },
	{ 0, 0xffc5,			spawn,		SHCMD("~/.local/bin/brightness/brightness-up.sh") },	
	{ 0, 0xffc4,			spawn,		SHCMD("~/.local/bin/brightness/brightness-down.sh") },

	{ 0, 0xffc2, 			spawn, 		SHCMD("~/.local/bin/toggle_timew.sh") },
	{ ShiftMask, 0xffc2,    	spawn,          SHCMD("~/.local/bin/toggle_timew_focus.sh") },


	


	/*oud*/
	/* { MODKEY|Mod4Mask,              XK_h,      incrgaps,       {.i = +1 } }, */
	/* { MODKEY|Mod4Mask,              XK_l,      incrgaps,       {.i = -1 } }, */
	/* { MODKEY|Mod4Mask|ShiftMask,    XK_h,      incrogaps,      {.i = +1 } }, */
	/* { MODKEY|Mod4Mask|ShiftMask,    XK_l,      incrogaps,      {.i = -1 } }, */
	/* { MODKEY|Mod4Mask|ControlMask,  XK_h,      incrigaps,      {.i = +1 } }, */
	/* { MODKEY|Mod4Mask|ControlMask,  XK_l,      incrigaps,      {.i = -1 } }, */
	/* { MODKEY|Mod4Mask|ShiftMask,    XK_0,      defaultgaps,    {0} }, */
	/* { MODKEY,                       XK_y,      incrihgaps,     {.i = +1 } }, */
	/* { MODKEY,                       XK_o,      incrihgaps,     {.i = -1 } }, */
	/* { MODKEY|ControlMask,           XK_y,      incrivgaps,     {.i = +1 } }, */
	/* { MODKEY|ControlMask,           XK_o,      incrivgaps,     {.i = -1 } }, */
	/* { MODKEY|Mod4Mask,              XK_y,      incrohgaps,     {.i = +1 } }, */
	/* { MODKEY|Mod4Mask,              XK_o,      incrohgaps,     {.i = -1 } }, */
	/* { MODKEY|ShiftMask,             XK_y,      incrovgaps,     {.i = +1 } }, */
	/* { MODKEY|ShiftMask,             XK_o,      incrovgaps,     {.i = -1 } }, */
};




/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
#ifndef __OpenBSD__
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
#endif
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        defaultgaps,	{0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	//{ ClkClientWin,		MODKEY,		Button4,	incrgaps,	{.i = +1} },
	{ ClkClientWin,		MODKEY,		Button5,	incrgaps,	{.i = -1} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
	//{ ClkTagBar,		0,		Button4,	shiftview,	{.i = -1} },
	{ ClkTagBar,		0,		Button5,	shiftview,	{.i = 1} },
	{ ClkRootWin,		0,		Button2,	togglebar,	{0} },
};

