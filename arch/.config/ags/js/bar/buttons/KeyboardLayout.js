import App from "resource:///com/github/Aylur/ags/app.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import PanelButton from "../PanelButton.js";

const KeyboardLayoutIndicator = () =>
  Widget.Label().hook(
    Hyprland,
    (label, keyboard, layout) => {
      label.label = layout || "English (US)";
      return label;
    },
    "keyboard-layout",
  );

export default () =>
  PanelButton({
    class_name: "quicksettings panel-button",
    on_clicked: () => App.toggleWindow("quicksettings"),
    setup: (self) =>
      self.hook(App, (_, win, visible) => {
        self.toggleClassName("active", win === "quicksettings" && visible);
      }),
    content: Widget.Box({
      children: [KeyboardLayoutIndicator()],
    }),
  });
