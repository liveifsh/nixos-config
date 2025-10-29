{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    yggstack
  ];

  age.identityPaths = [ "/home/livefish/.ssh/id_ed25519" ];
  age.secrets = {
    yggdrasil-config = {
      file = ../secrets/yggdrasil-config.age;
      owner = "root";
      group = "root";
      mode = "600";
    };
  };
  
  services.yggdrasil = {
    enable = true;
    configFile = config.age.secrets.yggdrasil-config.path;
    openMulticastPort = true;
  };
  networking.nameservers = [  
    "301:84f7:4bc0:2f3a::53"
    "302:db60::53 308:84:68:55::"
    "300:6223::53 308:25:40:bd:: "
  ];
}

