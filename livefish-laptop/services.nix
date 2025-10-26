{ config, lib, pkgs, inputs, ... }:
{
  services = {
    ntp.enable = true;
    openssh.enable = true;
    udisks2.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        addresses = true;
        domain = true;
        hinfo = true;
        userServices = true;
        workstation = true;
      };
    };

    # Enable usb analysis through wireshark  
    udev.extraRules =  ''
      SUBSYSTEM=="usbmon", GROUP="wireshark", MODE="0640"
    '';
  
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;  
    };

    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 60;
      };
    };

    fprintd = {
      enable = true;
      # tod.enable = true;
      # tod.driver = pkgs.libfprint-2-tod1-goodix; # Goodix driver module
    };

    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "1a2c:7fff" ]; # 2.4G Wireless Device keyboard
          settings.main = {
            rightcontrol = "end";
          };
        };        
      };
    };

    ratbagd.enable = true;

    logind = {
      lidSwitch = "suspend";               # Normal - suspend
      lidSwitchExternalPower = "suspend";  # Charging - suspend
      lidSwitchDocked = "ignore";          # Second monitor connected - nothing  
    };
  };    
  
  security.rtkit.enable = true; # Enable RealtimeKit for audio purposes
}
