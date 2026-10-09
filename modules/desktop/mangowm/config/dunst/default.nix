{ config, pkgs, ... }:
{
  services.dunst = {
    enable = true;

    settings = {
      global = {
        width = 380;
        height = 120;

        origin = "top-right";
        offset = "12x12";

        notification_limit = 5;

        frame_width = 2;
        frame_color = "#878d96";

        separator_height = 2;
        separator_color = "frame";

        padding = 14;
        horizontal_padding = 14;

        text_icon_padding = 10;

        font = "BlexMono Nerd Font Mono 10";

        title = "<b>%s</b>";
        title_color = "#f4f4f4";

        summary = "<b>%s</b>";
        summary_color = "#f4f4f4";

        body = "%b";
        body_color = "#f4f4f4";

        icon_position = "left";
        min_icon_size = 48;
        max_icon_size = 64;

        # icon_path = "/usr/share/icons/hicolor:/usr/share/icons/Adwaita";

        markup = "full";

        format = "<b>%s</b>\\n%b";

        mouse_left_click = "close_current";
        mouse_middle_click = "do_action";
        mouse_right_click = "close_all";

        idle_threshold = 120;

        sticky_history = true;
        history_length = 20;

        show_indicators = true;

        follow = "mouse";

        transparency = 0;

        sort = "urgency_ascending";

        stack_duplicates = true;
        hide_duplicate_count = false;
      };

      urgency_low = {
        background = "#161616";
        foreground = "#f4f4f4";
        frame_color = "#393939";

        timeout = 4;
      };

      urgency_normal = {
        background = "#161616";
        foreground = "#f4f4f4";
        frame_color = "#525252";

        timeout = 6;
      };

      urgency_critical = {
        background = "#161616";
        foreground = "#f4f4f4";
        frame_color = "#da1e28";

        timeout = 0;
      };
    };
  };
}
