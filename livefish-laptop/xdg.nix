{ config, lib, pkgs, inputs, ... } :

let
  browser = [ "firefox.desktop" ];
  associations = {
    "text/html" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/chrome" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/mailto" = [ "thunderbird.desktop" ];
    "x-scheme-handler/unknown" = browser;
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/xhtml+xml" = browser;
    "application/x-extension-xhtml" = browser;
    "application/x-extension-xht" = browser;

 
    "image/jpeg" = [ "qimgv.desktop" ];
    "image/png" = [ "qimgv.desktop" ];
    "image/gif" = [ "qimgv.desktop" ];
    
    "audio/mp3" = [ "vlc.desktop" ];
    "audio/mp4" = [ "vlc.desktop" ];
    "video/mp4" = [ "vlc.dekstop" ];

    # Wine
    "application/vnd.microsoft.portable-executable" = [ "wine.deskop" ];

    
    "application/json" = browser; # ".json"  JSON format
    "application/pdf" = browser; # ".pdf"  Adobe Portable Document Format (PDF)
  };
in rec
{
  environment.variables.XDG_CONFIG_DIRS = lib.mkForce [ "/etc/xdg" ]; # we should probably have this in NixOS by default

  xdg = {
    menus.enable = true;
    mime = {
      enable = true;
      defaultApplications = associations;
      addedAssociations = associations;
#      removedAssociations = {
#        "x-scheme-handler/mailto" = [ "" ]; 
#      };
      # associations.added = associations;
    };
  };
}
