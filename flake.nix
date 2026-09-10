{
  description = "antpond's nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
    	url = "github:nix-community/nixvim";
	inputs.nixpkgs.follows = "nixpkgs";
    };

    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
outputs = inputs@{ nixpkgs, mangowm, home-manager, nixvim, ... }: {
    nixosConfigurations = {
      gnome = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts
	  ./modules/desktop/gnome
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
	      ];
	    };
          }
        ];
      };
    };
  };
}
