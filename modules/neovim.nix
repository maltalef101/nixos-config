{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.neovim;

in {
  options.modules.neovim = { enable = mkEnableOption "neovim"; };
  config = mkIf cfg.enable {
    programs.neovim.enable = true;
    home.packages = with pkgs; [ neovim ];

    xdg.configFile."nvim" = {
      source = ../dotfiles/config/nvim;
      recursive = true;
    };
  };
}
