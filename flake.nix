{
  description = "antpond's nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-old.url = "github:nixos/nixpkgs/871b9fd269ff6246794583ce4ee1031e1da71895";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
    	url = "github:nix-community/nixvim";
    };

    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
outputs = inputs@{ nixpkgs, nixpkgs-old, mangowm, home-manager, nixvim, ... }: {
    nixosConfigurations = {
      gnome = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts
	  ./modules/desktop/gnome
	  ({ pkgs, ... }: {
	   nixpkgs.overlays = [
	   (final: prev: {
	    linux-firmware = nixpkgs-old.legacyPackages.${pkgs.system}.linux-firmware;
	    })
	   ];
	   })
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
	    home-manager.sharedModules = [
	  	nixvim.homeModules.nixvim
	    ];
            home-manager.users.antpond = ./hosts/home.nix;
          }
        ];
      };
      mango = nixpkgs.lib.nixosSystem {
        modules = [
	  ./hosts
	  ./modules/desktop/mangowm
    	  ./modules/core/greetd
	  ({ pkgs, ... }: {
	   nixpkgs.overlays = [
	   (final: prev: {
	    linux-firmware = nixpkgs-old.legacyPackages.${pkgs.system}.linux-firmware;
	    })
	   ];
	   })
	  mangowm.nixosModules.mango
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
	    home-manager.sharedModules = [
	  	nixvim.homeModules.nixvim
	    ];
            home-manager.users.antpond = {
	      imports = [
                ./hosts/home.nix
		mangowm.hmModules.mango
		./modules/desktop/mangowm/config
	      ];
	    };
          }
        ];
      };
    };
  };
}
