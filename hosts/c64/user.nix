{ config, lib, inputs, ... }:

{
  imports = [ ../../modules/default.nix ];
  config.modules = {
    alacritty.enable = true;
    bottom.enable = true;
    dunst.enable = true;
    firefox.enable = true;
    git.enable = true;
    leftwm.enable = true;
    neovim.enable = true;
    nushell.enable = true;
    rofi.enable = true;
    zellij.enable = true;

    packages.enable = true;
    startx.enable = true;
    xdg.enable = true;
  };
}
