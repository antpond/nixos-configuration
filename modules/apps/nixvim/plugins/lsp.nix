{pkgs, ...}: {
  programs.nixvim = {
    plugins.lsp = {
		    enable = true;

		    servers = {
			    zls.enable = true;
			    ols.enable = true;
			    clangd.enable = true;
			    volar.enable = true;
			    volar.extraOptions.init_options = {
				    vue = {
					    hybridMode = false;
				    };
			    };
		    };
	    };
  };
}

