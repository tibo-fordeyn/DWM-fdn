 DWM-fdn
=============
## About
**My configuration files. Trying to get as close to a "what a computer should be" setup as possible.**
**At the moment of writing, this is not close to being finished. I've put it on github for myself to easily clone when on a new system, and for others to hopefully take some inspiration :)**
    
![Alt-tekst](/home/dyntif/dl/dwm-fdn/screenshots/blauw.png)
![Alt-tekst](/home/dyntif/dl/dwm-fdn/screenshots/geel.png)
![Alt-tekst](/home/dyntif/dl/dwm-fdn/screenshots/grijs.png)

I feel as though, when designing a perfect system, one should think about privacy and extended minimalism. This translates to using as much libre software as possible, and starting with a very minimal code base. Going forward, it means to extend and have only the features needed, but implementing them in an aesthetic and efficient manner. All while keeping the time trade-off reasonable.
    I use Artix Runit Linux, and started with a base DWM install. I use ST and dmenu application launcher. 
    
    
   Lots of functionality was added. Made things better looking, also writing a lot of scripts piped into dmenu, implemented patches. Then ended up remapping a lot of the keys.

I wrote a script that (mainly just by using wal and some patches) gives you a menu to pick a color, and it completely changes every aspect of your systems color, instantly! Within the same runtime. 
    I'm using the same technique for executing standard commands like emptying your Vim cache and opening some files. 
    There's also a script for quickly mounting and unmounting drives.
    Not all the files relating to these features are in the repo atm.

    
## efficiency
Let's talk optimal binds, there's three 'levels' of binds
- DWM system binds: super=MODKEY
- ST meta-terminal binds: alt=MODKEY
- bash in terminal binds: ctrl=MODKEY


### DWM binds in config.h
I put the keys in alphabetic order in the config.h file.
**fundamental movement**
    
    
```
mod + j; move focus to left client
mod + k; move focus to right client
mod + J; move client to the right
mod + K; move client to the left
Or up and down depending on layout and how many clients are open obviously
mod + l; make client stretch to the right
mod + h; make client stretch to the left

mod +';';move to next tag
mod + g; move to previous tag
mod +'.'; move client to next tag
mod + G; move client to previous tag

mod + 1234567890; switch to this tag (azerty keys)
mod + shift_1234567890; move client to this tag (azerty keys)

mod + n; move to monitor on the left
mod + N; move to monitor on the right
mod + shift_Right; move tag to monitor on the right
mod + shift_Left; move tag to monitor on the left
```

**other keys of note**
```
mod + a; toggle gaps
mod + d; run dmenu
mod + s; run a script that gives you a dmenu menu, select an action that you have defined in the script to run.
mod + x; select a colorscheme! Runs a script that runs dmenu and can then update your entire theme completely, including the dmenu bar, which was difficult to get to work.
mod + z; menu to reboot, poweroff, or restart dmenu.

there's other keys like q to close clients, S for taking screenshots, and more.

I won't mention all of them, it's in the config.h
```

### ST-binds
```
mod + J; zoom out
mod + K; zoom in
mod + j; scroll up
mod + k; scroll down

mod + a; decrease the terminal alpha; less transparent background
mod + s; increase the terminal alpha; more transparent background
```

### bash bound keys
```
don't have many
mod + l; clears terminal, which didn't automatically happen for me somehow

I have Vim mode enabled: set -o vi
qj exits to normal mode
all other settings are as in regular vim

mod + r; opens ranger
mod + n; opens newsboat

some aliases
v=vim
e=exit
...
```



## Usage
What it's designed for:
- take notes for school, vimLaTeX
- take notes for work, vimwiki-pandoc-markdown
- managing files easily with LUKS encryption
- other personal projects, checking mails, etc...
- follow the news, newsboat
- listen to music
 

## Installation
    
**Execute these after having a fully functional install, with a user that is part of the wheel group!**
    
```bash
$ sudo pacman -S base-devel git networkmanager networkmanager-runit firefox qutebrowser picom newsboat htop vim mpv yt-dlp zathura wal unclutter dash
```
```bash
$ git clone {this repository}
```


Check to make sure you have the user own all the needed files!!!
```bash
ls -la dwm-fdeyn
sudo chown user:user dwm-fdeyn/*
```
But if you don't clone as root, and you shouldn't, this won't be an issue.
``` bash
$ mv all the files to the right places
```
``` bash
$ install the package building
$ build the suckless things and build AUR
``` 
``` bash
$ sudo pacman -S python-pywal
$ clone zathura-pywal and install it with their script
install vim plugins, leader pi with vim opened.
``` 
sound with pulse-audio, or alsa if that's easier.
I use pavucontrol with pulse, no alsa.

``` bash
$ sudo ln -sfT /bin/dash /bin/sh
```
Add the .hook script to /usr/share/libalpm/hooks as bash-update.hook

``` bash
$ install texlive-full
```
make sure the environment variables are working and 
``` bash
$ ls -la | wc -l
```
should be less than 20!! Clean it up after this if need be.
make sure root files are correctly configured to load dwm on startup AND load .xinitrc. 

**If you want the theme and other scripts to run correctly, you should allow you ruser to execute those commands without sudo, which you should define in your visudo file.**


### Be attentive to
- I have an azerty key configuration. Some keys in the config.h might need to be changed if you'd use it with a different layout.
- I run a lot of scripts from my config.h, my Downloads folder is renamed 'dl' if you wish to use different location, obviously you should modify the config.h file


# TO DO's
Obviously this isn't a complete list, but there's a few things I still want to do with my install:
- make an install script, and make everything easier to manage. Right now this repo is all over the place.
- when I change the theme, the terminals that are open, don't change colors, they have to be restarted. Which is annoying. Not sure if it's very fixable though.
- I still need to configure qutebrowser and tor browser
- sc-im spreadsheet editing configuration is not finished yet
- signal terminal application configs, getting scli to work with wal and xresources
- There's warnings when I run sudo make install on dwm
- In general, the code and scripts used are sometimes bloated; I should go over all files and try to remove all bloat.
- a local music application

- luks scripts need to be added, and my passmenu need to be included
- better networkmanager configuration, and automatic eduroam login
- x2x configuration for my server which has a screen
    
- a dmenu patch that blurs the background while dmenu runs, vim binds on it.
   


>>>>>>> b231956 (First commit of my DWM-fdn systm :))
