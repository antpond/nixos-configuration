#{ config, lib, pkgs, inputs, ... }:
{ config, pkgs, ... }:
{
  programs.mango.enable = true;

  environment.systemPackages = with pkgs; [
  	# the STACK
	waybar
	awww
	dunst
	fuzzel

	# utils
	nautilus
	feh
	wl-clipboard
	pwvucontrol

	# screenshot
	grim
	satty
	slurp

	# misc. for handling bindings
	brightnessctl
	playerctl
	libnotify

	# bluetooth
	bluez
	bluez-tools
	blueman
  ];

  programs.ssh.startAgent = true;
}
