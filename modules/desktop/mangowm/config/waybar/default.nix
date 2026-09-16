{ config, pkgs, ... }:
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
          "pulseaudio"
          "network"
          "battery"
          "tray"
        ];

        "custom/miku" = {
          format = "01";
          tooltip = false;
	  on-click = "grim -g \"$(slurp)\" - | wl-copy ";
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

        clock = {
          format = "  {:%H:%M}";
          format-alt = "  {:%a %d %b  •  %H:%M}";

          tooltip-format =
            "<big>{:%Y %B}</big>\n<tt>{calendar}</tt>";
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "󰖁  muted";

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

        network = {
          format-wifi = "  {signalStrength}%";
          format-ethernet = "󰈀  {ifname}";
          format-disconnected = "󰖪  offline";

          tooltip-format = "{ifname}: {ipaddr}";
          tooltip-format-wifi = "{essid}\n{ipaddr}";
        };

        battery = {
          format = "{icon}  {capacity}%";
          format-charging = "󰂄  {capacity}%";
          format-plugged = "󰚥  {capacity}%";

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

        tray = {
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
          "Noto Sans",
          sans-serif;

        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: transparent;
        color: #e6ffff;
      }

      #custom-miku,
      #workspaces,
      #clock,
      #pulseaudio,
      #network,
      #battery,
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

      /* Hover */

      #workspaces button:hover {
        color: #39d9d0;

        background: #172733;
        border-color: #39d9d0;
      }

      /* Active Mango workspace */

      #workspaces button.active {
        color: #101a24;

        background: #39d9d0;
        border-color: #39d9d0;

        font-weight: bold;
      }

      /* Urgent workspace */

      #workspaces button.urgent {
        color: #101a24;

        background: #ff79c6;
        border-color: #ff79c6;

        font-weight: bold;
      }

      /* Empty workspace */

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
