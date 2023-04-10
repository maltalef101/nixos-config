{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.storage;

in {
  options.modules.storage = { enable = mkEnableOption "storage"; };
  config = mkIf cfg.enable {
    home.file."00storage" = {
	  source = /var/lib/mount/storage;
	  recursive = true;
	};
  };
}
