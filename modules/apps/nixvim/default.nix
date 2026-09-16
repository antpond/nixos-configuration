{ pkgs, lib, ... }: {
	imports = [
		./plugins/lsp.nix
		./plugins/nvim-cmp.nix
	];

	programs.nixvim = {
		enable = true;
		defaultEditor = true;

		colorschemes.melange.enable = true;

		opts = {
			number = true;
			relativenumber = true;
			mouse = "a";

		};
	};
}
