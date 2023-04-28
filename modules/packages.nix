{ pkgs, lib, config, ... }:

with lib;
let cfg = 
  config.modules.packages;
  maimsel = pkgs.writeShellScriptBin "maimsel" ''${builtins.readFile ./scripts/maimsel}'';
  maimfull = pkgs.writeShellScriptBin "maimfull" ''${builtins.readFile ./scripts/maimfull}'';

in {
  options.modules.packages = { enable = mkEnableOption "packages"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ripgrep
      ffmpeg
      exa
      gnupg
      bat
      skim
      nsxiv
      mpv
      pass
      unzip
      maim
      polybar 

	  maimsel
	  maimfull
    ];
  };
}
