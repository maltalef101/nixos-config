{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.startx;

in {
  options.modules.startx = { enable = mkEnableOption "startx"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      xorg.xinit
    ];

    home.file.".xinitrc".source = ../dotfiles/config/x11/xinitrc;
    home.file.".xprofile".source = ../dotfiles/config/x11/xprofile;
  };
}
