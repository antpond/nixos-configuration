{ config, pkgs, lib, ... }:

let
  keyboardIndicator = pkgs.writeShellScript "waybar-keyboard-indicator" ''
    set -u

    mango_layout="$(
      mmsg get keyboardlayout 2>/dev/null \
        | sed -n 's/.*"\([^"]*\)".*/\1/p'
    )"

    fcitx_state="$(
      fcitx5-remote 2>/dev/null || true
    )"

    fcitx_im="$(
      fcitx5-remote -n 2>/dev/null || true
    )"

    # Fcitx5 Pinyin is our Chinese state.
    if [ "$fcitx_state" = "2" ] && [ "$fcitx_im" = "pinyin" ]; then
      printf '%s\n' \
        '{"text":"中","tooltip":"中文 · Pinyin"}'
      exit 0
    fi

    case "$mango_layout" in
      us)
        printf '%s\n' \
          '{"text":"EN","tooltip":"English"}'
        ;;

      pl)
        printf '%s\n' \
          '{"text":"PL","tooltip":"Polski"}'
        ;;

      fr)
        printf '%s\n' \
          '{"text":"FR","tooltip":"Français"}'
        ;;

      de)
        printf '%s\n' \
          '{"text":"DE","tooltip":"Deutsch"}'
        ;;

      *)
        printf '%s\n' \
          "{\"text\":\"$mango_layout\",\"tooltip\":\"Keyboard layout: $mango_layout\"}"
        ;;
    esac
  '';

  keyboardNext = pkgs.writeShellScript "waybar-keyboard-next" ''
    set -eu

    mango_layout="$(
      mmsg get keyboardlayout 2>/dev/null \
        | sed -n 's/.*"\([^"]*\)".*/\1/p'
    )"

    fcitx_im="$(
      fcitx5-remote -n 2>/dev/null || true
    )"

    fcitx_state="$(
      fcitx5-remote 2>/dev/null || true
    )"

    # 中 -> EN
    if [ "$fcitx_im" = "pinyin" ] && [ "$fcitx_state" = "2" ]; then
      fcitx5-remote -c
      mmsg dispatch switch_keyboard_layout,0
      exit 0
    fi

    case "$mango_layout" in
      us)
        # EN -> PL
        mmsg dispatch switch_keyboard_layout,1
        ;;

      pl)
        # PL -> FR
        mmsg dispatch switch_keyboard_layout,2
        ;;

      fr)
        # FR -> DE
        mmsg dispatch switch_keyboard_layout,3
        ;;

      de)
        # DE -> 中
        fcitx5-remote -s pinyin
        fcitx5-remote -o
        ;;

      *)
        # Unknown state -> EN
        fcitx5-remote -c 2>/dev/null || true
        mmsg dispatch switch_keyboard_layout,0
        ;;
    esac
  '';

  keyboardPrevious = pkgs.writeShellScript "waybar-keyboard-previous" ''
    set -eu

    mango_layout="$(
      mmsg get keyboardlayout 2>/dev/null \
        | sed -n 's/.*"\([^"]*\)".*/\1/p'
    )"

    fcitx_im="$(
      fcitx5-remote -n 2>/dev/null || true
    )"

    fcitx_state="$(
      fcitx5-remote 2>/dev/null || true
    )"

    # 中 -> DE
    if [ "$fcitx_im" = "pinyin" ] && [ "$fcitx_state" = "2" ]; then
      fcitx5-remote -c
      mmsg dispatch switch_keyboard_layout,3
      exit 0
    fi

    case "$mango_layout" in
      us)
        # EN -> 中
        fcitx5-remote -s pinyin
        fcitx5-remote -o
        ;;

      pl)
        # PL -> EN
        mmsg dispatch switch_keyboard_layout,0
        ;;

      fr)
        # FR -> PL
        mmsg dispatch switch_keyboard_layout,1
        ;;

      de)
        # DE -> FR
        mmsg dispatch switch_keyboard_layout,2
        ;;

      *)
        # Unknown state -> EN
        fcitx5-remote -c 2>/dev/null || true
        mmsg dispatch switch_keyboard_layout,0
        ;;
    esac
  '';

in
{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 40;

        #margin-left = 10;
        #margin-right = 10;

        spacing = 6;

        modules-left = [
          "ext/workspaces"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "custom/keyboard"
          "pulseaudio"
          "network"
          "battery"
	  "power-profiles-daemon"
          "tray"
          "custom/screenshot"
        ];

        "custom/screenshot" = {
          format = "󰋩";
          tooltip = false;
          on-click = "grim -g \"$(slurp)\" - | wl-copy ";
        };

        "custom/keyboard" = {
          exec = "${keyboardIndicator}";

          # Re-read every second. This keeps the indicator synchronized
          # with both Mango and Fcitx5.
          interval = 1;

	  return-type = "json";
	  format = "{}";

          tooltip = true;

          # Left click:
          # EN -> PL -> FR -> DE -> 中 -> EN
          on-click = "${keyboardNext}";

          # Right click:
          # EN <- PL <- FR <- DE <- 中 <- EN
          on-click-right = "${keyboardPrevious}";
        };

        "ext/workspaces" = {
          format = "{icon}";

          ignore-hidden = true;

          # Left click -> activate workspace
          on-click = "activate";

          # Right click -> deactivate workspace
          on-click-right = "deactivate";

          sort-by-id = true;
        };

        "clock" = {
          format = "{:%H:%M}";

          format-alt = "{:%H:%M   <span>%a %d %b</span>}";

          tooltip-format =
            "<big>{:%Y %B}</big>\n<tt>{calendar}</tt>";
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";

          format-muted = "󰖁 muted";

          format-icons = {
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };

          on-click = "pwvucontrol";

          scroll-step = 5;
        };

        "network" = {
          format-wifi = " {signalStrength}%";
          format-ethernet = "󰈀 {ifname}";
          format-disconnected = "󰖪 offline";

          tooltip-format = "{ifname}: {ipaddr}";
          tooltip-format-wifi = "{essid}\n{ipaddr}";
        };

        "battery" = {
          format = "{icon} {capacity}%";

          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰚥 {capacity}%";

          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];

          states = {
            warning = 30;
            critical = 15;
          };
        };

	"power-profiles-daemon" = {
		format= "{icon}";
		tooltip-format = "Power profile: {profile}nCPU driver: {cpu_driver}nPlatform driver: {platform_driver}";
		tooltip = true;
		format-icons = {
			default = "";
			performance = "";
			balanced = "";
			power-saver = "";
		};
	};

        "tray" = {
          spacing = 8;
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;

        font-family:
          "BlexMono Nerd Font Mono",
          "Noto Sans";

        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: #161616;
        color: #f4f4f4;
      }

      #custom-screenshot,
      #custom-keyboard,
      #workspaces,
      #clock,
      #pulseaudio,
      #network,
      #battery,
      #power-profiles-daemon,
      #tray {
        padding: 0 12px;
      }

      #custom-screenshot {
        border-color: #39d9d0;

        font-weight: bold;

        padding-left: 14px;
        padding-right: 14px;
      }

      #custom-screenshot:hover {
      	background: #262626;
      }

      #custom-screenshot:active {
	background: #393939;
      }

      #custom-keyboard {
        color: #f4f4f4;

        min-width: 34px;
        padding-left: 10px;
        padding-right: 10px;
      }

      #custom-keyboard:hover {
      	background: #262626;
      }

      #custom-keyboard:active {
	background: #393939;
      }

      #workspaces {
        padding: 0 5px;
      }

      #workspaces button {
        color: #f4f4f4;
        background: #161616;

        padding: 0 9px;

        transition:
          color 150ms ease,
          background 150ms ease,
          border-color 150ms ease;
      }

      #workspaces button:hover {
        background: #262626;
      }

      #workspaces button.active {
        font-weight: bold;
	border-bottom: solid 2px #0f62fe;
      }

      #workspaces button.urgent {
        color: #f4f4f4;
        background: #f1c21b;
        font-weight: bold;
      }

      #workspaces button.empty {
        color: #e0e0e0;
        background: transparent;
        border-color: transparent;
      }

      #workspaces button.empty:hover {
        color: #f4f4f4;
        border-color: #39d9d0;
      }

      #clock {
        color: #f4f4f4;

        font-weight: bold;
      }

      #clock > span {
        color: #e0e0e0;
      }

      #pulseaudio {
        color: #f4f4f4;
      }

      #pulseaudio.muted {
      	background: #da1e28;
        border-color: #ff79c6;
      }

      #network {
        color: #f4f4f4;
      }

      #network.disconnected {
      	background: #da1e28;
      }

      #battery {
        color: #f4f4f4;
      }

      #battery.charging {
	background: #198038;
      }

      #battery.warning {
	background: #da1e28;
      }

      #battery.critical {
	background: #da1e28;
      }

      #power-profiles-daemon {
        color: #f4f4f4;
      }

      #tray {
        padding-left: 9px;
        padding-right: 9px;
      }

      tooltip {
        background: #393939;
        color: #f4f4f4;
      }

      tooltip label {
        padding: 5px;
      }
    '';
  };
}
