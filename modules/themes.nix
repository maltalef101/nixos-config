{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.themes;

in {
  options.modules.themes = { enable = mkEnableOption "themes"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gruvbox-dark-gtk
    ];

    gtk = {
      enable = true;
      theme.name = "gruvbox-dark-gtk";
    };
  };
}
