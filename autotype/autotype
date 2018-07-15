#! /usr/bin/env osascript -l JavaScript

// Types out (through System Events) the arguments given to it.
//
// This is intended to be used as follows:
// - place the cursor on some text field
// - open the hotkey window of iTerm 2
// - run `autotype arg1 ... argn`
// - the hotkey window will be closed and `arg1` to `argn` will be typed
//   separated by tabs
//
// If `--enter` is given as first argument, Enter is pressed at the end.

const systemEvents = Application("System Events");
const iTerm = Application("iTerm2");

function typeText(text) {
  systemEvents.keystroke(text);
}

function typeTab() {
  delay(0.5);
  systemEvents.keystroke("\t");
  delay(0.5);
}

function typeEnter() {
  systemEvents.keyCode(36);
}

function autotype(args, pressEnter) {
  typeText(args[0]);
  args.slice(1).forEach(arg => {
    typeTab();
    typeText(arg);
  });
  if (pressEnter) {
    typeEnter();
  }
}

function run(argv) {
  let args = argv;
  let pressEnter = false;
  if (args && args[0] === "--enter") {
    pressEnter = true;
    args = args.slice(1);
  }
  if (args) {
    iTerm.currentWindow.hideHotkeyWindow();
    delay(1.0);
    autotype(args, pressEnter);
  }
}
