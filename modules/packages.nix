{ pkgs, lib, config, ... }:

with lib;
let cfg = 
  config.modules.packages;
  maimsel = pkgs.writeShellScriptBin "maimsel" ''${builtins.readFile ./scripts/maimsel}'';
  maimfull = pkgs.writeShellScriptBin "maimfull" ''${builtins.readFile ./scripts/maimfull}'';

  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-medium
	wrapfig
	capt-of;
  });

in {
  options.modules.packages = { enable = mkEnableOption "packages"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
	  bartib
	  bc
	  devour
	  tex
	  zathura
      bat
      exa
      ffmpeg
      gnupg
      maim
      mpv
      nsxiv
      pass
      polybar 
      ripgrep
      skim
      unzip

	  maimsel
	  maimfull
    ];

	xdg.desktopEntries = {
	  zathura = {
	    type = "Application";
	    name = "Zathura";
		genericName = "PDF Viewer";
		exec = ''${pkgs.devour}/bin/devour ${pkgs.zathura}/bin/zathura "%U"'';
		terminal = false;
		mimeType = [ "application/pdf" ];
	  };

	  mpv = {
	    type = "Application";
		name = "Zathura";
		genericName = "Media Player";
		exec = ''${pkgs.devour}/bin/devour ${pkgs.mpv}/bin/mpv --player-operation-mode=pseudo-gui -- "%U"'';
	  };
	};
  };
}
