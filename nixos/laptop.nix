{
  config,
  lib,
  pkgs,
  ...
}: {
  options.lenovoLaptop = {
    enable = lib.mkEnableOption "Lenovo Laptop";
  };

  config = lib.mkIf config.lenovoLaptop.enable {
    # Intel GPU configuration
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-compute-runtime  # Intel OpenCL/Vulkan support
        mesa
        vulkan-tools
        libva
        intel-vaapi-driver  # Intel video acceleration
      ];
    };


    # Optional: Add additional Intel-specific optimizations
    environment.systemPackages = with pkgs; [
      mesa
      vulkan-tools
      libva-utils
    ];
  };
}

