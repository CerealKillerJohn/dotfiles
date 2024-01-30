{ pkgs, inputs, config, ... }:

{
  sops = {
    defaultSopsFile = ../hosts/secrets.yaml;
    defaultSopsFormat = "yaml";
    gnupg.sshKeyPaths = [];
    age = {
      sshKeyPaths = ["/home/jwrhine/.ssh/id_ed25519"];
      keyFile = "/home/jwrhine/.config/sops/age/keys.txt";
    };
    secrets = {
#      example-key = { };
      tailscale = {
        owner = "jwrhine";
      };
      rp = {
        neededForUsers = true;
      };
      up = {
        neededForUsers = true;
      };
      # "myservice/my_subdir/my_secret" = { }
    };
  };
}
