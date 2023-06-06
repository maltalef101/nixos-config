{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.tmux;

in {
  options.modules.tmux = { enable = mkEnableOption "tmux"; };
  config = mkIf cfg.enable {
    programs.tmux = {
	  enable = true;

	  prefix = "C-Space";
	  baseIndex = 1;
	  clock24 = true;
	  mouse = true;
	  newSession = true;
	  sensibleOnTop = true;

	  extraConfig = ''
	  set-option -sa terminal-overrides ",xterm*:Tc"
	  set -sg escape-time 0
	  bind -n M-H previous-window
	  bind -n M-L next-window
	  '';
	};
  };
}
