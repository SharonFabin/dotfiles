import App from "resource:///com/github/Aylur/ags/app.js";
import Utils from "resource:///com/github/Aylur/ags/utils.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import PanelButton from "../PanelButton.js";
import { warpStatus } from "../../variables.js";

const CloudflareIcon = () =>
  Widget.Icon({
    icon: "/home/sharon/Pictures/icons/cloudflare.png",
    size: 30,
  });

const WarpIndicator = () =>
  Widget.Label({
    // css: warpStatus.bind("value").transform((v) => {
    //   return `border-radius: 15px; padding-left: 10px; padding-right: 10px; color: black; background-color: ${v === "Connected" ? "#00ff00" : "#ff0000"}`;
    // }),
    label: warpStatus.bind("value").transform((v) => {
      return ` ${v} `;
    }),
  });

export default () =>
  PanelButton({
    class_name: "quicksettings panel-button",
    // on_clicked: () => App.toggleWindow("quicksettings"),
    on_clicked: async () => {
      warpStatus.value === "Connected"
        ? Utils.exec("warp-cli disconnect")
        : Utils.exec(
            "warp-cli connect && systemctl restart systemctl-resolved",
          );
      // Utils.exec("warp-cli disconnect");
    },
    setup: (self) =>
      self.hook(App, (_, win, visible) => {
        self.toggleClassName("active", win === "quicksettings" && visible);
      }),
    content: Widget.Box({
      children: [CloudflareIcon(), WarpIndicator()],
    }),
    css: "border: 1px solid white; border-radius: 25px;",
  });
