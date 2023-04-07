{ config, lib, pkgs, modulesPath, ... }:
{
    imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

    boot = {
        # initrd.availableKernelModules = [ "nvlh" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
        initrd.kernelModules = [ "nvidia" ];
        # kernelModules = [];
        # extraModulePackages = [ ];
    };

    # hardware.opengl.extraPackages = with pkgs; [
    # ];

    fileSystems."/" = { 
        device = "/dev/disk/by-label/root";
        fsType = "ext4";
    };

    fileSystems."/boot/efi" = { 
        device = "/dev/disk/by-label/efi";
        fsType = "vfat";
    };

    swapDevices = [ { device = "/dev/disk/by-label/swap"; } ];

    networking.useDHCP = lib.mkDefault true;
    # networking.interfaces.enp0s3.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}
