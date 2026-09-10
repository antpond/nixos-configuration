{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./systemd-boot
    ./network-manager
    ./pipewire
    ./xdg
    ./fonts
    ./flatpak
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "pl2";

  # services.xserver.libinput.enable = true;

  users.users.antpond = {
    isNormalUser = true;
    description = "main user";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };


  programs.nix-ld.enable = true;

  # those are all placeholders to be moved
  programs.steam.enable = true;
  programs.zsh.enable = true;
  # mango to be figured out
  # programs.mangowm.enable = true;

  # except for this obviously
  system.stateVersion = "24.11"; # Did you read the comment?
}
