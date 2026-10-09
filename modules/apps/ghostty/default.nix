{ config, pkgs, ... }:
{
  programs.ghostty = {
    enable = true;

    settings = {
      background = "161616";
      foreground = "f4f4f4";

      background-opacity = 0.94;
      background-blur = true;

      cursor-color = "ffffff";

      selection-background = "262626";
      selection-foreground = "f4f4f4";

      palette = [

# black

	      "0=#161616"

# red

		      "1=#da1e28"

# green

		      "2=#42be65"

# yellow

		      "3=#f1c21b"

# blue

		      "4=#4589ff"

# magenta

		      "5=#ee5396"

# cyan

		      "6=#1192e8"

# white

		      "7=#c6c6c6"

# bright black

		      "8=#525252"

# bright red

		      "9=#ff8389"

# bright green

		      "10=#6fdc8c"

# bright yellow

		      "11=#fddc69"

# bright blue

		      "12=#78a9ff"

# bright magenta

		      "13=#ff7eb6"

# bright cyan

		      "14=#33b1ff"

# bright white

		      "15=#f4f4f4"
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
