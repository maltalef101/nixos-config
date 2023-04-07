{ inputs, pkgs, config, ... };

{
  home.stateVersion = "22.11";

  imports = [
    alacritty
    bottom
    dunst
    firefox
    git
    leftwm
    neovim
    nushell
    nvidia
    rofi
    zellij

    xdg
    packages
  ];
}
