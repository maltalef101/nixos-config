{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.redshift;

in {
  options.modules.redshift = { enable = mkEnableOption "redshift"; };
  config = mkIf cfg.enable {
	home.packages = with pkgs; [ redshift ];
	services.redshift = {
	  enable = true;
	  enableVerboseLogging = true;

	  provider = "manual";
	  latitude = -34.6;
	  longitude = -58.4;

	  temperature = {
	    day = 5500;
		night = 3650;
	  };

	  settings = {
		redshift = {
			adjustment-method = "randr";
			fade = 1;
			gamma-night = 0.95;
		};
	  };
	};
  };
}
