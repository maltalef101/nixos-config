# FUCK YOU NVIDIA
{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = ["nvidia"];
  
#  environment.variables = {
#    GBM_BACKEND = "nvidia-drm";
#    LIBVA_DRIVER_NAME = "nvidia";
#    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
# };
  
  environment.systemPackages = with pkgs; [
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools
  ];

  hardware = {
    nvidia = {
      # package = config.boot.kernelPackages.nvidiaPackages.unstable;
      powerManagement.enable = true;
      modesetting.enable = false;
      forceFullCompositionPipeline = true;
    };
    
    opengl.enable = true;
    opengl.extraPackages = with pkgs; [nvidia-vaapi-driver];
    opengl.driSupport = true;
  };
}
