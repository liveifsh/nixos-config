{ config, lib, pkgs, inputs, ... }:
  let
    lock-false = {
      Value = false;
      Status = "locked";
    };
    lock-true = {
      Value = true;
      Status = "locked";
    };
  in
{
  programs = {
    hyprland = { 
      enable = true; # enable Hyprland
      withUWSM  = true;
    }; 
    
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };

    appimage = {
      enable = true;
      binfmt = true;
    };

    amnezia-vpn.enable = true;    
    kdeconnect.enable = true;
    wireshark.enable = true; 

    fuse.userAllowOther = true;

    nano.nanorc = ''
        set tabstospaces
        set tabsize 2
        set autoindent
        set indicator
        set multibuffer
        set magic # May consume time
        set positionlog
        set linenumbers
    '';
    usbtop.enable = true;    
    fish.enable = true;
#  firefox = {
#    enable = true;
#    languagePacks = [ "ru" "en-US" ];
#     policies = {
#        DisableTelemetry = true;
#        DisableFirefoxStudies = true;
#        EnableTrackingProtection = {
#          Valu e= true;
#          Locked = true;
#          Cryptomining = true;
#          Fingerprinting = true;
#        };
#        DisablePocket = true;
#        DisableFirefoxAccounts = true;
#        DisableAccounts = true;
#        DisableFirefoxScreenshots = true;
#        OverrideFirstRunPage = "";
#        OverridePostUpdatePage = "";
#        DontCheckDefaultBrowser = true;
#        DisplayBookmarksToolbar = "always"; # alternatives: "always" or "newtab"
#        DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
#        SearchBar = "unified"; # alternative: "separate"
#
#        /* ---- EXTENSIONS ---- */
#        # Check about:support for extension/add-on ID strings.
#        # Valid strings for installation_mode are "allowed", "blocked",
#        # "force_installed" and "normal_installed".
#        ExtensionSettings = {
#          "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
#          # AdGuard
#          "adguardadblocker@adguard.com" = {
#            install_url = "https://addons.mozilla.org/firefox/downloads/file/4562517/adguard_adblocker-5.1.139.xpi";
#            installation_mode = "force_installed";
#          };
#          # Privacy Badger:
#          "addon@darkreader.org" = {
#            install_url = "https://addons.mozilla.org/firefox/downloads/file/4535824/darkreader-4.9.110.xpi";
#            installation_mode = "force_installed";
#          };
#        };
#  
#        /* ---- PREFERENCES ---- */
#        # Check about:config for options.
#        Preferences = { 
#          "browser.contentblocking.category" = { Value = "none"; Status = "locked"; };
#          "extensions.pocket.enabled" = lock-false;
#          "extensions.screenshots.disabled" = lock-true;
#          "browser.topsites.contile.enabled" = lock-false;
#          "browser.formfill.enable" = lock-false;
#          "browser.search.suggest.enabled" = lock-false;
#          "browser.search.suggest.enabled.private" = lock-false;
#          "browser.urlbar.suggest.searches" = lock-false;
#          "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
#          "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
#          "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
#          "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
#          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
#          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
#          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
#          "browser.newtabpage.activity-stream.showSponsored" = lock-false;
#          "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
#          "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
#        };
#      };
#    };
 };
}
