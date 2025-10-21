{ config, lib, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    shadowsocks-rust
  ];

  age.secrets.shadowsocks = {
    file = ../secrets/shadowsocks.age;
    owner = "root";
    group = "root";
    mode = "600";
  };

  
  systemd.services.shadowsocks-proxy = {
    description = "Finka shadowsocks proxy";
    requires = [ "network.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.shadowsocks-rust}/bin/sslocal -v -c ${config.age.secrets.shadowsocks.path}";
      ExecStop = "${pkgs.toybox}/bin/killall sslocal";
    };
  };  
}
