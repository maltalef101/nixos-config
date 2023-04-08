# FUCK YOU NVIDIA
{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  boot.extraModulePackages = with config.boot.kernelPackages; [ nvidia ];
  
  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
  
  environment.systemPackages = with pkgs; [
    nvidia
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools
  ];

  hardware = {
    nvidia = {
      open = true;
      powerManagement.enable = true;
      modesetting.enable = true;
    
    opengl.enable = true;
  };
  opengl.extraPackages = with pkgs; [nvidia-vaapi-driver];
  };
}
