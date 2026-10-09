{ config, pkgs, ... }:
{
  programs.hyprlock = {
    enable = true;

    settings = {
      hide_cursor = true;
      background = [
        {
          monitor = "";
	  path = "~/Pictures/Wallpapers/climber.png";
	  blur_passes = 2;
	  blur_size = 3;
	  noise = 0.02;
	  contrast = 0.92;
	  brightness = 0.35;
	  vibrancy = 0.0;
        }
      ];

      image = [
        {
          monitor = "";
	  path = "~/Pictures/Profile Pictures/cat.jpg";

	  size = 280;
	  rounding = -1;
	  border_color = "rgb(525252)";
	  border_size = 1;

	  position = "0, 230";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "240, 48";
          outline_thickness = 1;

          inner_color = "rgb(161616)";
	  outer_color = "rgb(525252)";
          font_color = "rgb(f4f4f4)";

          fade_on_empty = false;
          rounding = 2;

          placeholder_text = "";
          fail_text = "invalid password";

          position = "0, -20";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
      {
	monitor = "";
	text = "antpond.net";
	color = "rgb(f4f4f4)";
	font_family = "BlexMono Nerd Font Mono";
	font_size = 26;

	position = "0, 40";
	halign = "center";
	valign = "center";
      }
      {
	monitor = "";
	text = "cmd[update:1000] echo \"$(date '+%H:%M:%S')\"";
	color = "rgb(f4f4f4)";
	font_family = "BlexMono Nerd Font Mono";
	font_size = 13;

	position = "0, -80";
	halign = "center";
	valign = "center";
      }
      {
	monitor = "";
	text = "cmd[update:60000] echo \"$(date '+%Y-%m-%d')\"";
	color = "rgb(e0e0e0)";
	font_family = "BlexMono Nerd Font Mono";
	font_size = 9;

	position = "0, -105";
	halign = "center";
	valign = "center";
	}
      ];
    };
  };
}

