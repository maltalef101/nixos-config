{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.rofi;

in {
  options.modules.rofi = { enable = mkEnableOption "rofi"; };
  config = mkIf cfg.enable {
    programs.rofi.enable = true;
	programs.rofi.theme = "gruvbox-dark-hard.rasi";
  };
}
