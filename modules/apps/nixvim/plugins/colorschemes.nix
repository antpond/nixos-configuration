
{pkgs, ...}: {
	programs.nixvim = {
	extraPlugins = [ pkgs.vimPlugins.melange-nvim ];
	};
}
