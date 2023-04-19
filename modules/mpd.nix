{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.mpd;

in {
  options.modules.mpd = { enable = mkEnableOption "mpd"; };
  config = mkIf cfg.enable {
	home.packages = with pkgs; [ mpc-cli ];

	systemd.user.tmpfiles.rules = [
	  "L %h/music - - - - /var/lib/mount/storage/00music/hifi"
    ];

    services.mpd = {
		enable = true;
		musicDirectory = "~/music";
		extraConfig = ''
		  auto_update "yes"
		  restore_paused "yes"
		  follow_outside_symlinks "yes"
		  max_output_buffer_size "16384"
		  volume_normalization "yes"
		  audio_output {
			  type "pulse"
			  name "pulse"
		  }
		  audio_output {
			  type "fifo"
			  name "Visualizer Feed"
			  path "/tmp/mpd.fifo"
			  format "44100:16:2"
		  }
		'';
    };
  };
}
