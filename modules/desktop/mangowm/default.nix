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

	xdg-desktop-portal-wlr

	opentabletdriver
  ];

  services.logind.settings.Login = {
	HandleLidSwitch = "suspend";
	HandleLidSwitchExternalPower = "suspend";
	HandleLidSwitchDocked = "ignore";
  };

  # services.power-profiles-daemon.enable = true;

  services.tuned.enable = true;
  services.tuned.ppdSupport = true; # Enabled by default when tuned is enabled, but good to set explicitly
  
  # Recommended: ensure UPower is enabled so battery-aware profile switching works
  services.upower.enable = true;

  hardware.opentabletdriver.enable = true;

  programs.ssh.startAgent = true;
}
