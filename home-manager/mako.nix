{config, ...}:

{
  services = {
    mako = {
      enable = true;
      font = "Iosevka Nerd Font 10";
      padding = "15";
      borderRadius = 10;
      maxIconSize = 48;

      # text-alignment=center;

      defaultTimeout = 8000;
      layer = "overlay";
      anchor = "top-center";
      backgroundColor = "#1e1e2ecc";
      textColor = "#CDD6F4";
      borderColor = "#89b4fa";
      progressColor = "over #94e2d5";
      extraConfig = ''
        [urgency=low]
        border-color=#313244
        default-timeout=5000
        [urgency=normal]
        border-color=#313244
        default-timeout=10000
        [urgency=high]
        border-color=#FF0000
        text-color=#FF0000
        default-timeout=0
        [category=mpd]
        border-color=#f9e2af
        default-timeout=5000
        group-by=category
      '';
    };
  };
}
