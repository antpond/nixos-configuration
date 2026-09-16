{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    # IMPORTANT: Setting this to false often fixes the "No Apps Available"
    # bug in Electron apps like Cursor by letting the system use xdg-open di>
    xdgOpenUsePortal = false;
    wlr = {
      enable = true;
      settings = {
        screencast = {
          max_fps = 60;
          # Tell xdpw to use a dmenu-compatible tool
          chooser_type = "dmenu";
          # Dynamically interpolate the exact store path for fuzzel
          chooser_cmd = "${pkgs.fuzzel}/bin/fuzzel --dmenu --prompt=\"Select Screen: \"";
        };
      };
    };

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
  };
}

