{
  config,
  lib,
  ...
}: {
  options.asusLaptop = {
    enable = lib.mkEnableOption "Lenovo Laptop";
  };

  config = lib.mkIf config.asusLaptop.enable {
    # asusctl (only needed if you have an ASUS laptop)
    services.asusd = {
      enable = true;
      enableUserService = true;
    };

    # Enable OpenGL and Vulkan for Intel
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    # Use the modesetting driver for Intel
    services.xserver.videoDrivers = [ "modesetting" ];

    # Make sure Mesa and Vulkan are installed
    environment.systemPackages = with config.boot.kernelPackages; [
      mesa
      vulkan-tools
      libva
      intel-vaapi-driver  # For Intel video acceleration
    ];
  };
}
