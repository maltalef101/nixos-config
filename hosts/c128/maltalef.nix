{ config, lib, inputs, ... }:

{
  imports = [ ../../modules/default.nix ];

  config.modules = {
	emacs.enable = true;
	mpd.enable = true;
	redshift.enable = true;
    alacritty.enable = true;
    bottom.enable = true;
    dunst.enable = true;
    firefox.enable = true;
    git.enable = true;
    leftwm.enable = true;
    neovim.enable = true;
    nushell.enable = true;
    rofi.enable = true;
    tmux.enable = true;

	storage.enable = true;
    packages.enable = true;
    startx.enable = true;
    themes.enable = true;
    xdg.enable = true;
  };
}
