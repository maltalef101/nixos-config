{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.leftwm;

in {
  options.modules.leftwm = { enable = mkEnableOption "leftwm"; };
  config = mkIf cfg.enable {
    programs.leftwm.enable = true;

    home.file.".config/leftwm" = {
      source = ../dotfiles/.config/leftwm;
      recursive = true;
    };
  };
}
