{ config, pkgs, ... }:
{

  imports = [
  	./dunst
	./waybar
	./hyprlock
	./fuzzel
	./miku_cursor
  ];

  wayland.windowManager.mango = {
    enable = true;
    settings = {
      borderpx = 1;
      bordercolor = "0x39d9d0ff";
      focuscolor = "0xff79c6ff";
      
      blur = 1;
      border_radius = 12;
      
      # monitors
      monitorrule = [
      	"make:AOC,model:Q27G2WG4,width:2560,height:1440,refresh:143,x:1920,y:0"
        "name:^eDP-1$,model:0x403D,width:1920,height:1200,refresh:60,x:0,y:600"
      ];

      # tile,scroller,grid,deck,monocle,center_tile,vertical_tile,vertical_scroller
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
        "SUPER, p, spawn, hyprlock"

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

        "SUPER,space,togglefloating"

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

      mousebind = [
        "SUPER,btn_left,moveresize,curmove"
        "SUPER,btn_right,moveresize,curresize"
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

