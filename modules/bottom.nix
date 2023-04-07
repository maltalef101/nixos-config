{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.bottom;

in {
  options.modules.bottom = { enable = mkEnableOption "bottom"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      (writeScriptBin "htop" ''exec btm'')
      (writeScriptBin "top" ''exec btm'')
    ];

    programs.bottom.enable = true;
  };
}
