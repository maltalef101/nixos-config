{ inputs, pkgs, config, ... }:

{
  home.stateVersion = "22.11";

  imports = [
    ./alacritty.nix
    ./bottom.nix
    ./dunst.nix
	./emacs.nix
    ./firefox.nix
    ./git.nix
    ./leftwm.nix
    ./neovim.nix
    ./nushell.nix
    ./rofi.nix
    ./zellij.nix

	./storage.nix
    ./packages.nix
    ./startx.nix
    ./themes.nix
    ./xdg.nix
  ];
}
