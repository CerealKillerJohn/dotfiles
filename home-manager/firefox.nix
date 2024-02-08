{config, inputs, pkgs, user, ...}:

{
  programs = {
    firefox= {
      enable = true;
      profiles = {
        # ${user} = {
        jwrhine = {
          extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
            bitwarden
            cookie-autodelete
            (enhancer-for-youtube.overrideAttrs {meta.license.free = true;})
            facebook-container #
            (grammarly.overrideAttrs {meta.license.free = true;}) #
            hulu-ad-blocker
            (languagetool.overrideAttrs {meta.license.free = true;}) #
            (momentumdash.overrideAttrs {meta.license.free = true;})
            privacy-badger
            purpleadblock
            sponsorblock
            steam-database
            to-google-translate
            ublock-origin
            unwanted-twitch
            youtube-shorts-block #
          ];
          settings = {
            "browser.startup.homepage" = "icloud.com";
#            "browser.startup.homepage" = "mail.proton.me";
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "browser.tabs.warnOnClose" = false;
            "extensions.pocket.enabled" = false;
#             "media.ffmpeg.vaapi.enabled" = true;
          };
        webmail = {
          isDefault = false;
          extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
            bitwarden
            cookie-autodelete
            (grammarly.overrideAttrs {meta.license.free = true;}) #
            (languagetool.overrideAttrs {meta.license.free = true;}) #
            privacy-badger
            to-google-translate
            ublock-origin
          ];
          settings = {
            "browser.startup.homepage" = "mail.proton.me";
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "browser.tabs.warnOnClose" = false;
            "extensions.pocket.enabled" = false;
          };
          userChrome = ''
            @namespace url(http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul);

            #navigator-toolbox {
              height: 0px !important;
              min-height: 0px !important;
              overflow: hidden !important;
            }

            #navigator-toolbox:focus,
            #navigator-toolbox:focus-within,
            #navigator-toolbox:active {
              height: auto !important;
              overflow: visible !important;
            }
          '';
        };
      };
    };
  };
}
