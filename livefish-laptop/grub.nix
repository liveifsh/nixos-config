{ config, lib, ... }:

{
  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      useOSProber = false;
      device = "nodev";
      gfxmodeEfi = "1920x1200";
    };
    efi.canTouchEfiVariables = true;
  };
}
