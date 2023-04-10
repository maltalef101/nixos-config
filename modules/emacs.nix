{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.emacs;

in {
  options.modules.emacs = { enable = mkEnableOption "emacs"; };
  config = mkIf cfg.enable {
	  services.emacs.enable = true;

	  home.file.".config/emacs" = {
		source = ../dotfiles/config/emacs;
		recursive = true;
	  };
  };
}
