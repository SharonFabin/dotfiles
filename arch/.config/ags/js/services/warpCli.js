import * as Utils from "resource:///com/github/Aylur/ags/utils.js";
import Service from "resource:///com/github/Aylur/ags/service.js";
import options from "../options.js";
import { dependencies } from "../utils.js";

class WarpCLI extends Service {
  static {
    Service.register(
      this,
      {},
      {
        connected: ["boolean", "rw"],
      },
    );
  }

  #connected = false;

  get connected() {
    return this.#connected;
  }

  set connected(value) {
    if (!dependencies(["warp-cli"])) return;

    Utils.execAsync(
      `warp-cli status | awk '/Disconnected|Connected/{gsub(/.$/,"",$3); print $3}'`,
    )
      .then(() => {
        this.#connected = value;
        this.changed("connected");
      })
      .catch(console.error);
  }

  constructor() {
    super();

    if (dependencies(["warp-cli"])) {
      this.#connected =
        String(
          Utils.exec(
            `warp-cli status | awk '/Disconnected|Connected/{gsub(/.$/,"",$3); print $3}'`,
          ),
        ) === "Connected";
    }
  }
}

export default new WarpCLI();
