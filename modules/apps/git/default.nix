{ pkgs, lib, ... }: {
	programs.git = {
		enable = true;
		settings.user = {
			email = "nieflesz@gmail.com";
			name = "antpond";
		};
	};
}
