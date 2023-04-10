{ config, lib, pkgs, modulesPath, ... }:
{
    imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

    boot = {
        initrd.availableKernelModules = [ "ehci_pci" "ahci" "xhci_pci" "usbhid" "usb_storage" "sd_mod" ];
        initrd.kernelModules = [ "nvidia" ];
        kernelModules = [ "kvm-intel" ];
        kernelParams = [ "nomodeset" ];
        blacklistedKernelModules = [ "nouveau" ];
        # extraModulePackages = [ ];
        kernelPackages = pkgs.linuxPackages_latest;
    };

    # hardware.opengl.extraPackages = with pkgs; [
    # ];

    fileSystems."/" = { 
        device = "/dev/disk/by-label/root";
        fsType = "ext4";
    };

    fileSystems."/boot/efi" = { 
        device = "/dev/disk/by-label/boot";
        fsType = "vfat";
    };

    fileSystems."/var/lib/mount/storage" = {
	    device = "/dev/disk/by-uuid/4c027f79-0f18-4776-9884-e6885849f2b3";
	    fsType = "ext4";
    };

    swapDevices = [ { device = "/dev/disk/by-label/swap"; } ];

    networking.useDHCP = lib.mkDefault true;
    # networking.interfaces.enp0s3.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
