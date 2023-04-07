{ config, pkgs, inputs, ... }:

{
  environment.defaultPackages = [ ];

  environment.systemPackages = with pkgs; [
    git
    bash ## fallback
    nushell
    bat
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
        timeout = 0;
      };
  };

  # Nix settings, auto cleanup and enable flakes
  nix = {
      settings.auto-optimise-store = true;
      settings.allowed-users = [ "maltalef" ];
      gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 7d";
      };
      extraOptions = ''
          experimental-features = nix-command flakes
          keep-outputs = true
          keep-derivations = true
      '';
  };

  # Set up locales (timezone and keyboard layout)
  time.timeZone = "America/Argentina/Buenos_Aires";
  i18n.defaultLocale = "es_AR.UTF-8";
  i18n.extraLocaleSettings = {LC_MESSAGES = "en_US.UTF-8"; LC_TIME = "es_AR.UTF-8";};

  console = {
      keyMap = "es";
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
      EDITOR = "nvim";
      VISUAL = "emacs";
      PAGER = "bat";
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
