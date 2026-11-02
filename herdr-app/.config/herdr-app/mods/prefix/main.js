// Herdr TUI-style prefix: ctrl-a (keys.json "ctrl-a": "mod.open:prefix") opens this
// popup and takes the next key, runs the matching TUI-equivalent command, then closes.
// Esc or any unmapped key just closes. Table mirrors ~/.config/herdr/config.toml [keys].

import { View, div } from "gpui-kit";
import { v_flex } from "gpui-base";
import { run, props, closeOverlay, theme } from "herdr";

// key (as typed, shift applied) -> [command, args]
const MAP = {
  c: ["tab.new"],
  n: ["tab.next"],
  p: ["tab.prev"],
  "&": ["tab.close"],
  ",": ["tab.rename"],
  x: ["pane.close"],
  z: ["pane.zoom"],
  "\\": ["pane.split", { direction: "right" }],
  "-": ["pane.split", { direction: "down" }],
  h: ["pane.go", { direction: "left" }],
  j: ["pane.go", { direction: "down" }],
  k: ["pane.go", { direction: "up" }],
  l: ["pane.go", { direction: "right" }],
  e: ["layout.toggle", { id: "sidebar" }],
  w: ["mod.open", { name: "picker" }],
  s: ["app.settings"],
  "?": ["app.help"],
  N: ["space.new"],
  W: ["space.rename"],
  D: ["space.close"],
  // detach (prefix+d) has no desktop equivalent; left unbound on purpose.
};
for (let i = 1; i <= 9; i++) MAP[String(i)] = ["tab.select", { index: i }];

export default class Prefix extends View {
  init(_props, cx) {
    this.handle = cx.focus_handle();
    this.handle.focus();
  }

  done(e) {
    const ch = e.key_char ?? (e.modifiers.shift && /^[a-z]$/.test(e.key) ? e.key.toUpperCase() : e.key);
    const hit = e.key === "escape" ? null : MAP[ch] ?? null;
    closeOverlay(props().overlay);
    if (hit) run(hit[0], hit[1] ?? {});
  }

  render(cx) {
    const t = theme();
    return v_flex()
      .id("prefix")
      .track_focus(this.handle)
      .on_key_down((e, cx) => this.done(e, cx))
      .size_full()
      .p(18)
      .gap(8)
      .bg(t.popover)
      .text_color(t.foreground)
      .text_size(13)
      .child(div().text_size(15).font_semibold().child("Prefix: ctrl-a"))
      .child(div().text_color(t.dim).child("Next key runs the command. Esc cancels."));
  }
}
