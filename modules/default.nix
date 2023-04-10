{ inputs, pkgs, config, ... }:

{
  home.stateVersion = "22.11";

  imports = [
    ./alacritty.nix
    ./bottom.nix
    ./dunst.nix
    ./firefox.nix
    ./git.nix
    ./leftwm.nix
    ./neovim.nix
    ./nushell.nix
    ./rofi.nix
    ./zellij.nix

    ./xdg.nix
    ./startx.nix
	./storage.nix
    ./packages.nix
  ];
}
