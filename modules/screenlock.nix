{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.screenlock;

in {
  options.modules.screenlock = { enable = mkEnableOption "screenlock"; };
  config = mkIf cfg.enable {
    services.screen-locker = {
      enable = true;

	  xautolock.enable = false;
      lockCmd = "${pkgs.xsecurelock}/bin/xsecurelock";
      xss-lock.extraOptions = [ "--ignore-sleep" ];
    };
  };
}
