let
  livefish = "ssh-ed25519 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMXZOP7fxVeMXQXbTYkqhhR6fNck72VRLOWFGX3tKdZb";
  users = [ livefish ];

  livefish-laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMXZOP7fxVeMXQXbTYkqhhR6fNck72VRLOWFGX3tKdZb livefish@livefish-laptop";
  systems = [ livefish-laptop ];
in
{
  "shadowsocks.age".publicKeys = users ++ systems;
  "wireguard-main.age".publicKeys = users ++ systems;
  "wireguard-oxff.age".publicKeys = users ++ systems;
  "wireguard-synology.age".publicKeys = users ++ systems;
  "wireguard-itmo.age".publicKeys = users ++ systems;
  "wireguard-finka.age".publicKeys = users ++ systems;
  "yggdrasil-config.age".publicKeys = users ++ systems;
}
