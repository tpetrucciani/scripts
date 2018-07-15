# autotype

Script to type out some text from a script in macOS.

In particular, it's meant to be used from the hotkey window of iTerm.

Use as follows:
- place the cursor on a text field;
- open the hotkey window and run `autotype <text>`;
- the hotkey window should close and the text should be typed out.

If more than one argument is given, they are typed separated by tabs.
If `--enter` is given as first argument, Enter is pressed at the end.
(A short delay is inserted around tabs and before Enter.)

I use this script from `pw` to type out the password.
