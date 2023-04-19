{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.storage;

in {
  options.modules.storage = { enable = mkEnableOption "storage"; };
  config = mkIf cfg.enable {
	systemd.user.tmpfiles.rules = [
	  "L %h/storage - - - - /var/lib/mount/storage"
	]
  };
}
