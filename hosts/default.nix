{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      ../modules/core
    ];

  networking.hostName = "ant2"; # Define your hostname.
}
