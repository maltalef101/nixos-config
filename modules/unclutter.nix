{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.unclutter;

in {
  options.modules.unclutter = { enable = mkEnableOption "unclutter"; };
  config = mkIf cfg.enable {
    services.unclutter = {
	  enable = true;
	  timeout = 1;
	  threshold = 11;
	};
  };
}
