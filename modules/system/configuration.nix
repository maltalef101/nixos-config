{ config, pkgs, inputs, ... }:

{
  environment.defaultPackages = [ ];

  environment.systemPackages = with pkgs; [
    git
    bash ## fallback
    bat
	libnotify
	man
	man-pages
	man-pages-posix
	mandoc
  ];

  # Boot settings: clean /tmp/, latest kernel and enable bootloader
  boot = {
      cleanTmpDir = true;
      loader = {
      	systemd-boot.enable = true;
      	systemd-boot.editor = false;
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot/efi";
        };
        timeout = 3;
      };
  };

  services = {
    xserver = {
      enable = true;
      layout = "es";
      displayManager.startx.enable = true;
      xkbOptions = "caps:swapescape";
      autoRepeatDelay = 160;
      autoRepeatInterval = 70;
      
      libinput = {
      	mouse = {
      		accelProfile = "flat";
      		accelSpeed = "1";
      	};
      };
    };

	openssh = {
      enable = true;
      banner = ''
             **** COMMODORE C64 BASIC V2 ****
        64K RAM SYSTEM  38911 BASIC BYTES FREE
      READY
      '';

      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
	};
  };

  # set up default channel 
  system.autoUpgrade.channel = "https://nixos.org/channels/nixos-unstable";

  # Nix settings, auto cleanup and enable flakes
  nix = {
	  settings = {
		allowed-users = [ "root", "@wheel" ];
		auto-optimise-store = true;
		experimental-features = [ "nix-command" "flakes" "nix-repl" ];
	  };
      gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 2d";
      };
  };

  # Set up locales (timezone and keyboard layout)
  time.timeZone = "America/Argentina/Buenos_Aires";
  i18n.defaultLocale = "es_AR.UTF-8";
  i18n.extraLocaleSettings = {
	LC_MESSAGES = "en_US.UTF-8";
	LC_TIME = "es_AR.UTF-8";
  };

  console = {
      keyMap = "es";
  };

  fonts = {
	  fonts = with pkgs; [
	      noto-fonts
		  noto-fonts-cjk
		  noto-fonts-emoji
		  fira-code
		  fira-code-symbols
	      (nerdfonts.override { fonts = [ "FiraCode" ]; })
	  ];

	  fontconfig = {
		  defaultFonts = {
			  serif = [ "Noto Serif" ];
			  sansSerif =  [ "Noto Sans" ];
			  monospace = [ "Fira Code" ];
		  };
	  };
  };

  environment.variables = {
      # NIXOS_CONFIG = "$HOME/.config/nixos/configuration.nix";
      NIXOS_CONFIG_DIR = "$HOME/.config/nixos/";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_CACHE_HOME = "$HOME/.cache";
      PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
      GTK_RC_FILES = "$HOME/.config/gtk-1.0/gtkrc";
      GTK2_RC_FILES = "$HOME/.config/gtk-2.0/gtkrc";
      TERMINAL = "alacritty";
      BROWSER = "firefox";
      PAGER = "less";
      EDITOR = "nvim";
      VISUAL = "emacs";
  };

  users.users.maltalef = {
      uid = 1000;
      isNormalUser = true;
      extraGroups = [ "input" "wheel" ];
      shell = pkgs.nushell;
  };

  security = {
      sudo.enable = false;
      doas = {
          enable = true;
          extraRules = [{
              users = [ "maltalef" ];
              keepEnv = true;
              persist = true;
          }];
      };

      protectKernelImage = true;
  };

  sound = {
      enable = true;
  };

  programs.dconf.enable = true; # fix for gtk apps
  programs.ssh.enableAskPassword = false; # no graphical ssh prompt

  hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;
  
  hardware = {
      bluetooth.enable = false;
      opengl = {
          enable = true;
          driSupport = true;
      };
  };

  # Do not touch
  system.stateVersion = "20.09";
}
