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

        prompt = "♫  ";
        placeholder = "Search applications...";

        icon-theme = "Zafiro";
        icons-enabled = true;

        image-size-ratio = 1.0;
      };

      border = {
        width = 2;
        radius = 14;
      };

      colors = {
        background = "101a24f2";
        text = "e6ffffff";

        match = "39d9d0ff";
        selection = "39d9d0ff";
        selection-text = "101a24ff";
        selection-match = "ff79c6ff";

        border = "39d9d0ff";
      };

      dmenu = {
        mode = "text";
      };
    };
  };
}
