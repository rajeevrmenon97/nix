{
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ./gpu-env.nix

    ../../nixos/basic.nix
    ../../nixos/gaming.nix
    ../../nixos/media.nix

    ../../nixos/desktop/hyprland.nix
    ../../nixos/desktop/plasma.nix
    ../../nixos/desktop/sddm.nix

    ../../nixos/hardware/amdgpu.nix
    ../../nixos/hardware/audio.nix
    ../../nixos/hardware/nvidia.nix

    ../../nixos/system/ios.nix
    ../../nixos/system/plymouth.nix
    ../../nixos/system/secureboot.nix
    ../../nixos/system/users.nix
  ];

  # Known issue, kernel freeze when type c port is used
  boot.blacklistedKernelModules = ["ucsi_acpi"];

  # WiFi card doesn't work on the stable kernel
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.callPackage ./rog-kernel.nix {});

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Asus linux
  services.asusd.enable = true;
  services.asusd.enableUserService = true;
  services.supergfxd.enable = true;

  system.stateVersion = "24.11";
}
