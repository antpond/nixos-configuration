{ pkgs, lib, ... }: {
	imports = [
		./plugins/lsp.nix
		./plugins/nvim-cmp.nix
	];

	programs.nixvim = {
		enable = true;
		defaultEditor = true;

		colorschemes = {
			gruvbox = {
				enable = true;
			};
		};

		opts = {
			number = true;
			relativenumber = true;
			mouse = "a";

		};
	};
}
