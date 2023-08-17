{ config, lib, pkgs, modulesPath, ... }:
{
    imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

    boot = {
        initrd.availableKernelModules = [ "ahci" "xhci_pci" "usb_storage" "sd_mod" "sdhci_pci" ];
        kernelModules = [ "kvm-intel" ];
        extraModulePackages = [ ];
        kernelPackages = pkgs.linuxPackages_latest;
		kernelParams = [ ];
    };

    fileSystems."/" = { 
        device = "/dev/disk/by-label/root";
        fsType = "ext4";
    };

    fileSystems."/boot/efi" = { 
        device = "/dev/disk/by-label/boot";
        fsType = "vfat";
    };

    swapDevices = [ { device = "/dev/disk/by-label/swap"; } ];

    networking.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
