
Many thanks to [@rjuju](https://github.com/rjuju) for sharing its .vimrc with
me.  I was completely lost at first, and it gave me just the amount of
frustration I needed to became obsessed with understanding it and making it my
own.  And in the process of doing so (I'm really not finished, and will likely
never be), I ended dropping my whole system configuration and starting it all
over.  Again, thank you.

# Index

Here is the main configuration files locations:

- editor
  - [.vimrc file](editor/vimrc)
- terminal
  - [termite config file](terminal/termite)
  - [.tmux.conf file](terminal/tmux)
- shell
  - [.inputrc file](shell/inputrc.sh)
  - [.bash_profile file](shell/bash_profile.sh)
  - [.bashrc file](shell/bashrc.sh)
  - [bash aliases configuration file](shell/bash_aliases.sh)
  - [bash man configuration file](shell/bash_colored_man.sh)
  - [bash path configuration file](shell/bash_path.sh)
  - [bash prompt configuration file](shell/bash_prompt.sh)
  - [env variables configuration file](shell/env.sh)
  - [lc_language configuration file](shell/lc_language.sh)
  - [postgres_manage configuration file](shell/postgres_manage.sh)
- systemd
  - [autologin unit file](systemd/getty-tty1-override)
- x
  - [.xinitrc file](x/xinitrc)
- window manager
  - [i3 configuration file](wm/i3)
  - [i3blocks configuration file](wm/i3blocks.conf)
  - [rofi configuration file](wm/rofi)
- theme files
  - [badwolf theme files](themes/badwolf/)
  - [gruvbox_dark_medium theme files](themes/gruvbox_dark_medium/)
  - [papercolor_light theme files](themes/papercolor_light/)


# Questions people may ask, frequently or not

## What is this?

These are my system configuration files, for my personal use.  This
configuration is very keyboard oriented, with mostly CLI applications, terminal
multiplexing, tiling window manager, Vim-like bindings.  There are still many
things I need to fix or customize, obviously, so you will find many "FIXME" in
there.

I tend to use my configuration files as my notebook when I learn how things
work.  As most of this knowledge came from what other people shared, I thought
it was only right to do the same.  Hopefully, this may help you to get some
ideas or solve a configuration problem.  And maybe that some of you will give
me feedback, helping me to improve my configuration and learn about new and
cooler things (or feel silly for missing something basic).


## How do I install it?

You don't.

This is not a functionnal piece of software, and there will be no stable
release.  Anything may change at any time without any warning, and there will
be breaking changes as I may decide to drop any software altogether.  There is
no guarantee that it will work at all with your environment, and if it doesn't
I will not fix it if it works for me.  In fact, if you just clone it and run it
using Ansible without understanding what it does, this will most probably
destroy several of your own configuration files.

So, seriously: *don't install it!*  Just grab anything you want and make it
your own, and leave out what you don't want, like or understand.


## What version of "software name" is compatible with your configuration file?

Usually, the latest available on the Linux distribution I'm using (currently
Arch Linux).  I don't bother to test compatibily with previous versions, and
use the newest features I'm aware of (if I understand them).


## Why is this licensed under (CC BY 4.0)?

https://creativecommons.org/licenses/by/4.0/

As I wrote previously, this is no software.  There is no source code, only
configuration files, a few shell scripts, and too many comments.  These files
are completely and utterly useless without the software they configure.  So I
consider them to be content, like a wiki, and chose a (free) license
accordingly.


## How can I contribute?

If you want to, you can contribute by raising issues, asking questions about
things you don't understand, or suggesting changes.

Feature requests and pull requests are welcome, but I will probably not include
anything very sophisticated, at least not without rewritting it completely:
that's how I understand and learn things.  My environment may not be
(compositing|responsive|plug and play|blue|mouse friendly|.*), but it will be
the sexiest... as long as I can understand it.



# Configuration sections, tips, cheatsheet, survival kit

Now, let's see what configuration sections I have at this point.

I will try to include resources to install the applications I use, and various
tips the key combos I frequently use.  Many of them are custom ones, sometimes
requiring the addition of a plugin or a custom script to work.

They are inspired from Vim bindings when relevant (like movements, splits), and
optimized for an AZERTY fr keyboard layout (sorry, that's what I use, but I
really tried not to do bindings like `M-A à` or `C-€`).


## systemd

For now, the only configuration file is used to deploy an unit file used to
autologin.

*WARNING*: This configuration is only safe for me because my disks are
encrypted, so my passphrase is asked at boot time.  Do not use it blindly.


## x

This is my xinit (very basic for now) configuration.  I'm the sole user of my
computers, so I don't really have a need for a display manager, or even a login
prompt.


## shell

This is mostly my bash configuration.  I started looking at zsh, but I'm not
there yet.

I have a few customizations here, but not much.  First, I'm using bash `vi`
mode, which allows me to switch between *Insert* mode (the default one, similar
to Vim's *Insert* mode) and *Command* mode (similar to Vim's *Normal* mode, and
not the *Command* mode as the name may suggest).  To avoid being lost in modes,
both the prompt and cursor shape change between modes.

I won't list keys that work like in Vim *Normal* mode (`h` goes one character
left, `l` one character right, `w` one word right, `A` puts you to the end of
line and into *Insert* mode, etc.).  Just some keys that act differently, or
that I customized.


| keys      | action                 |
|----------:|------------------------|
| `C-n` | *Insert* mode only: auto-completes current command or filename. |
| `jk`  | *Insert* mode only: enter *Command* mode. |
| `k`   | *Command* mode only: go to the previous line from history. |
| `j`   | *Command* mode only: go to the next line from history. |
| `v`   | *Command* mode only: open the current command line contents into editor to edit, and executes it when exiting. |

FIXME searching history? CTRL-k works, but should I remap it to ? and /
FIXME C-p should go back on auto-completion and not parse history


I did set up the usual aliases.

| alias     | action                 |
|----------:|------------------------|
| `l`  | List files by columns, with file type indicator symbols.  |
| `ll`  | List every file on a different line, with details.  |
| `lt`  | Same, but sorted in reverse modification order instead of file name.  |
| `vi`  | Launch Vim.  |
| `view`  | Launch Vim in read-only mode.  |

I use postgres_manage to quickly build binaries from any PostgreSQL commit, and
manage several instances for testing and debugging purpose.  Useful resources:
- https://github.com/rjuju/postgres-manage

| alias     | action                 |
|----------:|------------------------|
| `pgsync`  | Refreshes both PostgreSQL and postgres_manage's git local directories. |
| `pglslatest`  | List latest available versions from git repository. |
| `pgls`  | List created instances. |
| `pg <version>` | Select `<version>` to manage instance. FIXME also instance number / commit? |
| `pgbuild`  | Build PostgreSQL binaries using selected version. |
| `pgstart`  | Start selected instance (creates it if not already created). |
| `pgstop`  | Stop selected instance. |
| `pgslave`  | Create a hot standby instance using selected instance as a primary. |
| `pgtail`  | Executes `tail -f` on the log file of the selected instance. |
| `pgctags`  | Create tags on the postgresql git directory. |

## editor

This one is all about Vim, as you may have guess.  Here you will mostly find my
`vimrc` template file, and several variables and scripts used to switch themes.

Useful resources (many other links are into the `vimrc` file):
- https://www.vim.org/
- http://vim.wikia.com/wiki/Vim_Tips_Wiki
- http://stevelosh.com/
- https://github.com/tpope/vim-unimpaired

Vim has way too many useful key combos to list here.  First, the following
default keys are *disabled* for the purpose of training myself not to use them.

| disabled keys         |
|:---------------------:|
| arrow movements       |
| `ESC` (*Insert* mode) |


Then, I'll put here what I frequently use and is not part of default Vim maps.

| keys      | action                                       | plugin    |
|----------:|----------------------------------------------|-----------|
| `Space`   | Remap of the `leader` key (default to `\\`). |           |
| `Space-Space` | Save the current file if it has been modified. |    |
| `Space-n` `Space-p` | Switch to the [n]ext or [p]revious buffer. |    |
| `Space-b`   | Flip-flop between currently and previously active buffers. |    |
| `Space-X`   | Close the current buffer. |    |
| `jk`        | *Insert* mode: go back to *Normal* mode. |    |
| `C-p C-f` | Open CtrlP menu on files search mode. | CtrlP |
| `C-p C-m` | Open CtrlP menu on most recently used files mode. | CtrlP |
| `C-p C-b` | Open CtrlP menu on buffers mode. | CtrlP |
| `C-p C-t` | Open CtrlP menu on tags mode. | CtrlP |
| `F2`  | Toggle *Insert* *Paste* mode. |    |
| `F3`  | Toggle location list (errors). |  syntastic/airline  |
| `F4`  | Toggle TagBar menu list. | TagBar |
| `F5`  | Toggle Gundo windows to manage Vim's undo history. | Gundo |

FIXME Space-w: window mode
FIXME window mode: allow window resize, movement and position change
FIXME CtrlP mode
FIXME add vim-unimpaired maps

And finally, this is my own cheatsheet for all these very useful default maps I try to remember.

| keys      | action                                       |
|----------:|----------------------------------------------|
| `F1`      | Open Vim help on a split on top of the current window. |
| ` `   |    |
| ` `   |    |
| ` `   |    |
| `C-r +` | *Insert* mode: paste using system clipboard FIXME which one? |
| `C-r *` | *Insert* mode: paste using system clipboard FIXME which one? |
| ` `   |    |

FIXME useful registers list
`+`
`*`

FIXME macros?


FIXME search into code?


## terminal

I mostly use termite and tmux.  Tmux bindings are heavily modified for a better
integration with both Vim and i3.  Useful resources:
- https://github.com/thestinger/termite
- https://github.com/tmux/tmux/wiki
- https://www.hamvocke.com/blog/a-quick-and-easy-guide-to-tmux/

The key bindings I use are tmux commands with different bindings.

| keys      | action                                       |
|----------:|----------------------------------------------|
| `M-a`     | New prefix (default one is `C-b`). |
| `M-a c` `M-a C` | Open new window (`C` use current working directory). |
| `M-a s` `M-a S` | Split current window in two panes, the new one below to the current one (`S` use current working directory). |
| `M-a v` `M-a V` | Split current window in two panes, the new one right to the current one (`V` use current working directory). |
| `M-a a` | Enter *Copy* mode (move using Vim movements, copy to system clipboard. |
| `M-a p` | Paste from system clipboard |
| `M-a M-s` | Synchronize panes for current window. |
| `M-a F1`  | Open a new pane running `htop` below the current one. |
| `M-a /`   | Ask for a `string`, and open a new pane running `man <string>` below the current one. |


## wm

Apart from Vim configuration, this is most complicated part.  Here there are
several applications I use:
- [i3 window manager](https://i3wm.org/).
- [i3blocks](https://github.com/vivien/i3blocks): add customizable blocks into
  the i3 statusbar.
- [rofi](https://github.com/DaveDavenport/rofi): used as a dmenu replacement,
  and for several other things like theme or monitor layout switch.
- [dunst](https://dunst-project.org/): notification daemon.
- [select-monitor-layout](): use [mons](https://github.com/Ventto/mons) and
  [rofi](https://github.com/DaveDavenport/rofi) to switch between monitor
  layouts.
- [unified-theme-selector](): use [rofi](https://github.com/DaveDavenport/rofi)
  to swith simulaneously swith theme for several applications (i3, Vim,
  termite, tmux, etc.).

Useful resources (many other links are into the configuration files):
- https://i3wm.org/
- https://github.com/vivien/i3blocks/wiki
- https://github.com/DaveDavenport/rofi

These are some of my i3 bindings.

| keys      | action                 |
|----------:|------------------------|
| `Super` | aka `mod4` or the `<win>` key, used as the modifier key to be combined with other keys. |
| `Super-$` | Open the switch theme menu.  |
| `Super-F1` | Open the switch monitor layout menu. |
| `Super-d`  | Open menu to launch applications. |
| `Super-n` `Super-p` | Move to [n]ext and [p] previous workspaces. |
| `Super-[0-9]` | Move to the selected number's workspace (`0` gives you the workspace `10`). |
| `Super-[hjkl]` | Move between panes using Vim directions. |
| `Super-t` `Super-T` | Switch between "tabbed" (`t`) and "stacked" (`T`) panes when not tiled. |
| `Super-e` | Toggle right-left or up-down split (and return to tiled mode when tabbed or stacked). |



