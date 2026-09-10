{ pkgs, lib, ... }: {
  programs.ghostty = {
    enable = true;
    themes.spezi = {
      palette = [
        "0=#001e3c"
        "1=#d40721"
        "2=#b1bf14"
        "3=#ff960d"
        "4=#61a0d4"
        "5=#5e269d"
        "6=#27b187"
        "7=#afb0b3"
        "8=#10263c"
        "9=#f51026"
        "10=#d4c31e"
        "11=#ff9e19"
        "12=#639dce"
        "13=#5e368b"
        "14=#38d6a5"
        "15=#eef0f4"
      ];
      foreground = "eef0f4";
      background = "071829";
      cursor-color = "eaf3fa";
      cursor-text = "eef0f4";
      selection-background = "0a223a";
      selection-foreground = "eef0f4";
    };
  };
}
