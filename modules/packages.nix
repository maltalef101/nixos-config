{ pkgs, lib, config, ... }:

with lib;
let cfg = 
  config.modules.packages;

in {
  options.modules.packages = { enable = mkEnableOption "packages"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ripgrep ffmpeg exa gnupg bat skim nsxiv mpv pass gnupg unzip 7zip
      slop maim polybar nvtop
    ];
  };
}
