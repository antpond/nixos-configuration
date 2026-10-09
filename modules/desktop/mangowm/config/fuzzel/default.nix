{ config, pkgs, ... }:
{
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        terminal = "${pkgs.ghostty}/bin/ghostty";
        layer = "overlay";

        width = 45;
        lines = 12;

        horizontal-pad = 20;
        vertical-pad = 16;

        inner-pad = 8;

        line-height = 28;

        prompt = "";
        placeholder = "Search applications...";

        icon-theme = "Zafiro";
        icons-enabled = true;

        image-size-ratio = 1.0;
      };

      border = {
        width = 2;
        radius = 0;
      };

      colors = {
        background = "161616ff";
        text = "f4f4f4ff";

        match = "e0e0e0ff";
        selection = "262626ff";
        selection-text = "f4f4f4ff";
        selection-match = "e0e0e0ff";

        border = "393939ff";
      };

      dmenu = {
        mode = "text";
      };
    };
  };
}
