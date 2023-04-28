{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.nushell;

in {
  options.modules.nushell = { enable = mkEnableOption "nushell"; };
  config = mkIf cfg.enable {
    programs.nushell.enable = true;

    home.file.".config/nushell" = {
      source = ../dotfiles/config/nushell;
      recursive = true;
    };

	programs.starship = {
	  enable = true;
	  enableNushellIntegration = true;
	};
  };
}
