{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];

  networking.wireguard.enable = true;
  
  age.identityPaths = [ "/home/livefish/.ssh/id_ed25519" ];
  age.secrets = {
    wireguard-main = {
      file = ../secrets/wireguard-main.age;
      owner = "root";
      group = "root";
      mode = "600";
    };
    
     wireguard-oxff = {
      file = ../secrets/wireguard-oxff.age;
      owner = "root";
      group = "root";
      mode = "600";
    };

    wireguard-synology = {
      file = ../secrets/wireguard-synology.age;
      owner = "root";
      group = "root";
      mode = "600";
    };

    wireguard-itmo = {
      file = ../secrets/wireguard-itmo.age;
      owner = "root";
      group = "root";
      mode = "600";
    };
    
    wireguard-finka = {
      file = ../secrets/wireguard-finka.age;
      owner = "root";
      group = "root";
      mode = "640";
    };
  };

  networking.wg-quick.interfaces = {
    wg-finka = {
      autostart = false;
      dns = [ "94.140.14.14" "94.140.15.15" ];
      address = [ "10.10.10.14/32" ];
      privateKeyFile = config.age.secrets.wireguard-finka.path;
      mtu = 1300;
      listenPort = 51822;
      peers = [{
        publicKey = "y1IyAi61re9vucTKWFOY1qsWVmCCvDs2iXL1qNbsBDo=";
        allowedIPs = [ "0.0.0.0/0" "::/0"];
        endpoint = "127.0.0.1:1080";
        persistentKeepalive = 25;
      }];
    };

    wg-oxff = {
      # IP address of this machine in the *tunnel network*
      address = [ "172.17.69.70/24" ];
      # Path to the private key file.
      privateKeyFile = config.age.secrets.wireguard-oxff.path;
      listenPort = 51821;
      peers = [{
        publicKey = "yXEx8qgSgcagzqZoI3XWCLQddu+sblU0W3Ku+hAvjC8=";
        allowedIPs = [ "172.17.69.0/24" ];
        endpoint = "93.100.76.237:51820";
        persistentKeepalive = 25;
      }];
    };

    wg-syn = {
      autostart = false;

      address = [ "100.81.3.134/32" ];
      privateKeyFile = config.age.secrets.wireguard-synology.path;
      peers = [{
        publicKey = "xhTbdj00i3kmY5zVQNDxdsh9Qs6AanV2MKpy7IX/ZU4=";
        presharedKey = "efS9MkQZQaFvo74KMe9jp2na5M1i0Nxc0GWg7FfS0XY=";
        allowedIPs = [ "10.78.1.3/32" ];
        endpoint = "91.122.49.229:42145";
        persistentKeepalive = 25;
      }];
    };

    wg-itmo = {
      autostart = false;

      address = [ "10.10.19.207/32" ];
      mtu = 1420;
      dns = ["10.10.187.33" "10.10.10.10" "8.8.8.8"];
      privateKeyFile = config.age.secrets.wireguard-itmo.path;
      peers = [{
        publicKey = "Vx/1d/96BrruXtFz2REdxmHWahpWSHjUH8sUgT5uZDs=";
        allowedIPs = [ "10.10.16.1/32" "10.10.10.0/24" "10.10.187.0/24"];
        endpoint = "vpn.itmo.xyz:51820";
        persistentKeepalive = 25;
      }];
    };
  };
}
