{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.xinit;

in {
  options.modules.xinig = { enable = mkEnableOption "xinit"; };
  config = mkIf cfg.enable {
    services.xserver.displayManager.startx.enable = true;
    
    home.file.".xinitrc".source = ../dotfiles/.config/x11/xinitrc;
    home.file.".xprofile".source = ../dotfiles/.config/x11/xprofile;
  };
}
