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
          '{"text":"EN","tooltip":"English (US)"}'
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
        height = 34;

        margin-left = 10;
        margin-right = 10;

        spacing = 6;

        modules-left = [
          "custom/miku"
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
        ];

        "custom/miku" = {
          format = "01";
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

          format-icons = {
            "1" = "一";
            "2" = "二";
            "3" = "三";
            "4" = "四";
            "5" = "五";
            "6" = "六";
            "7" = "七";
            "8" = "八";
            "9" = "九";

            active = "●";
            urgent = "◆";
            empty = "○";
            default = "○";
          };

          ignore-hidden = true;

          # Left click -> activate workspace
          on-click = "activate";

          # Right click -> deactivate workspace
          on-click-right = "deactivate";

          sort-by-id = true;
        };

        "clock" = {
          format = " {:%H:%M}";

          format-alt = " {:%a %d %b • %H:%M}";

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
        background: transparent;
        color: #e6ffff;
      }

      #custom-miku,
      #custom-keyboard,
      #workspaces,
      #clock,
      #pulseaudio,
      #network,
      #battery,
      #power-profiles-daemon,
      #tray {
        background: #101a24;
        border: 1px solid #39d9d0;
        border-radius: 12px;

        margin-top: 6px;
        margin-bottom: 4px;

        padding: 0 12px;
      }

      #custom-miku {
        color: #ff79c6;
        border-color: #39d9d0;

        font-weight: bold;

        padding-left: 14px;
        padding-right: 14px;
      }

      #custom-miku:hover {
        color: #ff79c6;
        border-color: #ff79c6;
      }

      #custom-keyboard {
        color: #7debe5;
        border-color: #39d9d0;

        font-weight: bold;

        min-width: 34px;
        padding-left: 10px;
        padding-right: 10px;
      }

      #custom-keyboard:hover {
        color: #101a24;
        background: #39d9d0;
        border-color: #39d9d0;
      }

      #workspaces {
        padding: 0 5px;
      }

      #workspaces button {
        color: #587481;
        background: transparent;

        border: 1px solid transparent;
        border-radius: 9px;

        padding: 0 9px;
        margin: 3px 2px;

        transition:
          color 150ms ease,
          background 150ms ease,
          border-color 150ms ease;
      }

      #workspaces button:hover {
        color: #39d9d0;
        background: #172733;
        border-color: #39d9d0;
      }

      #workspaces button.active {
        color: #101a24;
        background: #39d9d0;
        border-color: #39d9d0;

        font-weight: bold;
      }

      #workspaces button.urgent {
        color: #101a24;
        background: #ff79c6;
        border-color: #ff79c6;

        font-weight: bold;
      }

      #workspaces button.empty {
        color: #38515d;
        background: transparent;
        border-color: transparent;
      }

      #workspaces button.empty:hover {
        color: #39d9d0;
        border-color: #39d9d0;
      }

      #clock {
        color: #e6ffff;
        border-color: #39d9d0;

        font-weight: bold;
      }

      #pulseaudio {
        color: #7debe5;
      }

      #pulseaudio.muted {
        color: #ff79c6;
        border-color: #ff79c6;
      }

      #network {
        color: #7debe5;
      }

      #network.disconnected {
        color: #ff79c6;
        border-color: #ff79c6;
      }

      #battery {
        color: #7debe5;
      }

      #battery.charging {
        color: #39d9d0;
        border-color: #39d9d0;
      }

      #battery.warning {
        color: #ffd166;
        border-color: #ffd166;
      }

      #battery.critical {
        color: #ff79c6;
        border-color: #ff79c6;
      }

      #power-profiles-daemon {
        color: #7debe5;
      }

      #tray {
        padding-left: 9px;
        padding-right: 9px;
      }

      tooltip {
        background: #101a24;
        border: 1px solid #39d9d0;
        border-radius: 10px;
        color: #e6ffff;
      }

      tooltip label {
        padding: 5px;
      }
    '';
  };
}
