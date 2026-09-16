{ config, pkgs, ... }:

{
  imports = [
    ../modules/apps/nixvim
    ../modules/apps/git
    ../modules/apps/ghostty
  ];

  home.username = "antpond";
  home.homeDirectory = "/home/antpond";

  home.stateVersion = "24.11";
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
	neovim
	ghostty
	tmux
	git
	vscode
	modemmanager
	libmbim
	discord-ptb
	anki
	prismlauncher
	corefonts
	libreoffice
	zed-editor

	cmake
	ninja
	gcc
	libgcc
	boost
	doxygen
	odin


	alsa-lib
	alsa-plugins
	pipewire
	pulseaudio
	raylib
	enet
  ];

  home.sessionVariables = {
    # EDITOR = "emacs";
    EDITOR = "nvim";
    TERMINAL = "ghostty";
    XDG_CACHE_HOME = "/home/antpond/.cache";
  };
  
  # auto-mounting
  services.udiskie = {
    enable = true;
    settings = {
        # workaround for
        # https://github.com/nix-community/home-manager/issues/632
        program_options = {
            # replace with your favorite file manager
            file_manager = "${pkgs.nautilus}/bin/nemo";
        };
    };
};

  programs.home-manager.enable = true;
}
