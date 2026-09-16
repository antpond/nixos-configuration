{ config, pkgs, ... }:
{
  programs.ghostty = {
    enable = true;

    settings = {
      background = "0b151c";
      foreground = "d9ffff";

      background-opacity = 0.94;
      background-blur = true;

      cursor-color = "39d9d0";

      selection-background = "245b63";
      selection-foreground = "eaffff";

      palette = [
        # black
        "0=#0b151c"

        # red / pink
        "1=#ff5fa2"

        # green / Miku cyan
        "2=#39d9d0"

        # yellow
        "3=#f5d76e"

        # blue
        "4=#4fc3f7"

        # magenta / pink
        "5=#e56bb6"

        # cyan
        "6=#5ce1e6"

        # white
        "7=#b8dfe2"

        # bright black
        "8=#38515d"

        # bright red
        "9=#ff82b5"

        # bright green
        "10=#7debe5"

        # bright yellow
        "11=#ffe89a"

        # bright blue
        "12=#82d9ff"

        # bright magenta
        "13=#ff9bd3"

        # bright cyan
        "14=#9af5ef"

        # bright white
        "15=#eaffff"
      ];

      font-family = "Blex Nerd Font Mono";
      font-size = 12;

      font-feature = [
        "calt"
        "liga"
      ];

      window-decoration = false;

      window-padding-x = 16;
      window-padding-y = 14;

      window-padding-balance = true;

      cursor-style = "bar";
      cursor-style-blink = true;

      scrollback-limit = 10000;

      shell-integration = "detect";

      copy-on-select = "clipboard";

      mouse-hide-while-typing = true;

      confirm-close-surface = false;
      window-save-state = "never";

      resize-overlay = "never";
    };
  };
}
