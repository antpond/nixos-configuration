{ config, pkgs, ... }:

{
  imports = [
    ./dunst
    ./waybar
    ./hyprlock
    ./fuzzel
    ./miku_cursor
  ];

  # Fcitx5 + Pinyin
  #
  # This is the Home Manager Fcitx5 module. Pinyin is provided by
  # fcitx5-chinese-addons.
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";

    fcitx5 = {
      waylandFrontend = true;

      addons = with pkgs; [
	qt6Packages.fcitx5-chinese-addons
      	fcitx5-gtk
      	fcitx5-rime
      ];

      settings = {
        # Make Fcitx5 start in the normal US keyboard mode.
        inputMethod = {
          GroupOrder."0" = "Default";

          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
            DefaultIM = "keyboard-us";
          };

          "Groups/0/Items/0" = {
            Name = "keyboard-us";
            Layout = "us";
          };

          "Groups/0/Items/1" = {
            Name = "pinyin";
          };
        };

        globalOptions = {
          # Ctrl+Space toggles Fcitx5's active state.
          Hotkey = {
            TriggerKeys = "CTRL+SPACE";
            EnumerateWithTriggerKeys = true;
            EnumerateSkipFirst = false;
          };
        };
      };
    };
  };

  wayland.windowManager.mango = {
    enable = true;

    settings = {
      borderpx = 1;
      bordercolor = "0x39d9d0ff";
      focuscolor = "0xff79c6ff";

      blur = 1;
      border_radius = 12;

      # Keyboard layouts handled by Mango/XKB.
      #
      # 0 = us
      # 1 = pl
      # 2 = fr
      # 3 = de
      #
      # Chinese is deliberately NOT an XKB layout. It is handled by
      # Fcitx5/Pinyin instead.
      xkb_rules_layout = "us,pl,fr,de";

      # monitors
      monitorrule = [
        "make:AOC,model:Q27G2WG4,width:2560,height:1440,refresh:143,x:0,y:0"
        "name:^eDP-1$,model:0x403D,width:1920,height:1200,refresh:60,x:2560,y:800"
      ];

      # tile,scroller,grid,deck,monocle,center_tile,vertical_tile,
      # vertical_scroller
      tagrule = [
        "id:1,layout_name:tile"
        "id:2,layout_name:tile"
        "id:3,layout_name:tile"
        "id:4,layout_name:tile"
        "id:5,layout_name:tile"
        "id:6,layout_name:tile"
        "id:7,layout_name:tile"
        "id:8,layout_name:vertical_scroller"
        "id:9,layout_name:scroller"
      ];

      bind = [
        "SUPER,Return,spawn,ghostty"
        "SUPER+SHIFT,c,killclient,"
        "SUPER,r,spawn,fuzzel"
        "SUPER+SHIFT,r,reload_config"
        "SUPER+SHIFT,e,quit,"
        "SUPER,p,spawn,hyprlock"

        "SUPER,h,focusdir,left"
        "SUPER,j,focusdir,down"
        "SUPER,k,focusdir,up"
        "SUPER,l,focusdir,right"

        "SUPER+SHIFT,h,exchange_client,left"
        "SUPER+SHIFT,j,exchange_client,down"
        "SUPER+SHIFT,k,exchange_client,up"
        "SUPER+SHIFT,l,exchange_client,right"

        "SUPER,1,view,1"
        "SUPER,2,view,2"
        "SUPER,3,view,3"
        "SUPER,4,view,4"
        "SUPER,5,view,5"
        "SUPER,6,view,6"
        "SUPER,7,view,7"
        "SUPER,8,view,8"
        "SUPER,9,view,9"
        "SUPER,0,view,10"

        "SUPER+SHIFT,1,tag,1"
        "SUPER+SHIFT,2,tag,2"
        "SUPER+SHIFT,3,tag,3"
        "SUPER+SHIFT,4,tag,4"
        "SUPER+SHIFT,5,tag,5"
        "SUPER+SHIFT,6,tag,6"
        "SUPER+SHIFT,7,tag,7"
        "SUPER+SHIFT,8,tag,8"
        "SUPER+SHIFT,9,tag,9"
        "SUPER+SHIFT,0,tag,10"

        # Keep your existing floating shortcut.
        "SUPER,space,togglefloating"

        # Language/layout cycle:
        #
        # EN -> PL -> FR -> DE -> 中 -> EN
        #
        # The actual five-state cycle is implemented by the Waybar
        # helper so that Chinese/Fcitx5 participates in the cycle.
        "SUPER+SHIFT,space,spawn,${pkgs.writeShellScript "mango-next-input" ''
          set -eu

          mango_layout="$(
            mmsg get keyboardlayout 2>/dev/null \
              | sed -n 's/.*"\([^"]*\)".*/\1/p'
          )"

          fcitx_im="$(
            fcitx5-remote -n 2>/dev/null || true
          )"

          fcitx_state="$(
            fcitx5-remote 2>/dev/null || true
          )"

          # If Pinyin is currently active:
          # Chinese -> English
          if [ "$fcitx_im" = "pinyin" ] && [ "$fcitx_state" = "2" ]; then
            fcitx5-remote -c
            mmsg dispatch switch_keyboard_layout,0
            exit 0
          fi

          case "$mango_layout" in
            us)
              mmsg dispatch switch_keyboard_layout,1
              ;;
            pl)
              mmsg dispatch switch_keyboard_layout,2
              ;;
            fr)
              mmsg dispatch switch_keyboard_layout,3
              ;;
            de)
              fcitx5-remote -s pinyin
              fcitx5-remote -o
              ;;
            *)
              mmsg dispatch switch_keyboard_layout,0
              ;;
          esac
        ''}"

        "NONE,XF86MonBrightnessUp,spawn,brightnessctl s +2%"
        "SHIFT,XF86MonBrightnessUp,spawn,brightnessctl s 100%"
        "NONE,XF86MonBrightnessDown,spawn,brightnessctl s 2%-"
        "SHIFT,XF86MonBrightnessDown,spawn,brightnessctl s 1%"

        "NONE,XF86AudioRaiseVolume,spawn,wpctl set-volume @DEFAULT_SINK@ 5%+"
        "NONE,XF86AudioLowerVolume,spawn,wpctl set-volume @DEFAULT_SINK@ 5%-"
        "NONE,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_SINK@ toggle"
        "NONE,XF86AudioMicMute,spawn,wpctl set-mute @DEFAULT_SOURCE@ toggle"

        "NONE,XF86AudioNext,spawn,playerctl next"
        "NONE,XF86AudioPrev,spawn,playerctl previous"
        "NONE,XF86AudioPlay,spawn,playerctl play-pause"
      ];

      switchbind = [
	"fold, spawn, hyprlock"
      ];

      mousebind = [
        "SUPER,btn_left,moveresize,curmove"
        "SUPER,btn_right,moveresize,curresize"
      ];

      # Fcitx5 environment required by applications under Mango.
      #
      # Mango's current documentation recommends these variables for
      # Fcitx5/Wayland.
      env = [
        "GTK_IM_MODULE,fcitx"
        "QT_IM_MODULE,fcitx"
        "QT_IM_MODULES,wayland;fcitx"
        "SDL_IM_MODULE,fcitx"
        "XMODIFIERS,@im=fcitx"
        "GLFW_IM_MODULE,ibus"
      ];

      exec-once = [
        "waybar"
        "dunst"
        "awww-daemon"
        "awww img ~/Pictures/Wallpapers/hatsune.png"
      ];
    };
  };
}
