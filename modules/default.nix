{ inputs, pkgs, config, ... }:

{
  home.stateVersion = "22.11";

  imports = [
	./emacs.nix
	./mpd.nix
	./redshift.nix
	./unclutter.nix
    ./alacritty.nix
    ./bottom.nix
    ./dunst.nix
    ./firefox.nix
    ./git.nix
    ./leftwm.nix
    ./neovim.nix
    ./nushell.nix
    ./rofi.nix
    ./tmux.nix
	./screenlock.nix

	./storage.nix
    ./packages.nix
    ./startx.nix
    ./themes.nix
    ./xdg.nix
  ];
}
