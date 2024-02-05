{config, inputs, pkgs, user, ...}:

{
  programs = {
    firefox= {
      enable = true;
      profiles = {
        ${user} = {
          extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
            bitwarden
            cookie-autodelete
            (enhancer-for-youtube.overrideAttrs {meta.license.free = true;})
            facebook-container #
            (grammarly.overrideAttrs {meta.license.free = true;}) #
            hulu-ad-blocker # doesn't exist yet
            (languagetool.overrideAttrs {meta.license.free = true;}) #
            (momentumdash.overrideAttrs {meta.license.free = true;})
            privacy-badger
            purple-ads-blocker # doesn't exist yet
            sponsorblock #
            steam-database
            to-google-translate # doesn't exist yet
            tridactyl #
            ublock-origin
            unwanted-twitch # doesn't exist yet
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
#          userChrome = ''
#            @namespace url(http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul);

            #navigator-toolbox {
#              height: 0px !important;
#              min-height: 0px !important;
#              overflow: hidden !important;
#            }

            #navigator-toolbox:focus,
            #navigator-toolbox:focus-within,
            #navigator-toolbox:active {
#              height: auto !important;
#              overflow: visible !important;
#            }
#          '';
        };
      };
    };
  };
}
