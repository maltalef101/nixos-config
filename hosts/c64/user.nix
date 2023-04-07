{ config, lib, inputs, ... };

{
  imports = [ ../../config/default.nix ];
  config.modules = {
    alacritty.enable = true;
    bottom.enable = true;
    dunst.enable = true;
    firefox.enable = true;
    git.enable = true;
    leftwm.enable = true;
    neovim.enable = true;
    nushell.enable = true;
    nvidia.enable = true;
    rofi.enable = true;
    zellij.enable = true;

    packages.enable = true;
    xdg.enable = true;
  };
}
