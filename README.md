# Miscellaneous scripts

These are some scripts I use:

- [`autotype.js`](#autotypejs) allows to type text programmatically in macOS;

- [`finder`](#finder) opens a new macOS Finder tab at a given path;

- [`notes`](#notes) helps in managing a collection of plain-text notes;

- [`pw`](#pw) can be used together with [pass](https://www.passwordstore.org)
  to select passwords quickly.

- [`remind.rb`](#remindrb) sets reminders on Apple's Reminders.app.

## autotype.js

This script types out text
using the JavaScript for Automation functionality of macOS.
It should be used from the “hotkey window” of iTerm 2.

Use as follows:

- place the cursor on a text field;
- open the hotkey window and run `autotype <text>`;
- the hotkey window should close and the text should be typed out.

If `<text>` is composed of more than one argument,
then they are typed separated by tabs.
If the first argument is `--enter`, Enter is pressed at the end.
(A short delay is inserted around tabs and before Enter.)

The script [`pw`](#pw) uses `autotype` to type out usernames and passwords.

## finder

Run `finder <path>` to open a new macOS Finder tab (in the last used Finder window)
and focuses the given `<path>` (which can be relative or absolute).

If no argument is given,
the script allows to select a path interactively with fuzzy finding.
This relies on [fd](https://github.com/sharkdp/fd)
to list all directories below `$HOME`
and on the interactive fuzzy finder [FZF](https://github.com/junegunn/fzf).

## notes

A script to organize and search through a collection of plain-text notes.
Searching is done using [FZF](https://github.com/junegunn/fzf).

## pw

A script to make it faster to select passwords
from the password store of [pass](https://www.passwordstore.org).
Running `pw` displays the passwords in the password store
– i.e. the `.gpg` files under `~/.password-store` –
using [FZF](https://github.com/junegunn/fzf)
to allow to search for passwords by fuzzy finding.
(An initial query can be passed as argument to `pw`.)
The selected password can be copied to the clipboard (by selecting it with Enter),
printed out (using `Ctrl-S`),
typed out (using `Ctrl-T`),
typed out preceded by the username (using `Ctrl-Y`),
or the tail of the password file (all but the first line) can be printed out
(using `Ctrl-U`).
All commands invoke `pass` to decrypt the password file.
To type out passwords, [`autotype`](#autotype) is used.
To print out the tail, the `pass` extension
[`tail`](https://github.com/palortoff/pass-extension-tail#readme) is used.

## remind.rb

The script sets reminders in the macOS Reminders app.
It attempts
to parse either the first or the last argument as a reminder time (see below):
if it succeeds, the reminder is set for that time,
using the concatenation of all other arguments as the reminder text.

A reminder time can be specified in an absolute way by setting the time as `hh:mm`
or relative to when it is set as e.g. `1h`, `30m`, `1h30m`.
A relative time in minutes can also be written omitting `m`.

For example:
`remind phone call 25` sets a reminder with text “phone call” in 25 minutes;
`remind 15:30 meeting` sets a reminder with text “meeting” at 15:30.
