{ config, pkgs, ... }:
{
  programs.hyprlock = {
    enable = true;

    settings = {
      background = [
        {
          monitor = "";
	  path = "~/Pictures/Wallpapers/lockscreen.jpg";
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
	  path = "~/Pictures/Profile Pictures/jesus.jpg";

	  size = 280;
	  rounding = -1;
	  border_color = "rgb(39d9d0)";
	  border_size = 1;

	  position = "0, 260";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "280, 48";
          outline_thickness = 1;

          inner_color = "rgb(141716)";
	  outer_color = "rgb(39d9d0)";
          font_color = "rgb(d5d7d5)";

          fade_on_empty = false;
          rounding = 5;

          placeholder_text = "";
          fail_text = "i can't miku miku anymore...";

          position = "0, 20";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
      {
	monitor = "";
	text = "cmd[update:1000] echo \"$(date '+%H:%M:%S')\"";
	color = "rgb(d5d7d5)";
	font_family = "IBM Plex Mono";
	font_size = 13;

	position = "0, 80";
	halign = "center";
	valign = "center";
	}
      {
	monitor = "";
	text = "cmd[update:60000] echo \"$(date '+%Y-%m-%d')\"";
	color = "rgb(5f6460)";
	font_family = "IBM Plex Mono";
	font_size = 9;

	position = "0, 105";
	halign = "center";
	valign = "center";
	}
      ];
    };
  };
}

