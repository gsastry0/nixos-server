# minimal-configuration.nix
{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Boot
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  
  # Network
  networking.hostName = "nixos-do";
  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = true;
  
  # SSH with your key
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDiiBh8q76NIR1DpjFuCe+Odru4pxnT1onaWmQbStOj/CPec12Bi28K6d04RgPOqDQBNatEJA2ducrO6jBMI3n9rekcN276AyY0edXp/5DDi/qr4LircMRm6Cvdv1ynWZqG24xCTUy0Hi1ngiOXjphOo73ayf1Uoe/5JTqThKvruzyDlmzjZsvoW+6XB4r2X9yTbClRnGyIf8+2nXo/003pOy78+nkSkhJgeh+/IkDtiDKhg540So1jMwwlNYNvWuE1j5EKJBEa8Pfp4bQbT7TntKElAo/jHlkWufRgk3jML3sTirIXWp2mft4Nrjr0WV/5ASHIYqxmWwjnesxzccmuYGum/mLChoo4Jp/QTgqe8BC/RAN0RAdbWcssuPm7Aqakb/uYxa9s5hUU22pEdGzkeA6QcD94QAgXlECSDQ2aGXCiEUvsZgHZmFKGAQ77l7GLU9uhb9GzMlXEEjHol1VeR0shcrF/uLotyTdbmZQ7OaMDRUzJS48QtMVMmj6jEHcP/BR9KRJzyryPbhPX0UyIkAKKvMyCpFmarHytCt2pghTmuIRYtCeD+bAhbDEf9sfBFUP5MDLlvZa0TNDyjMfaWeXrE9rqlKDnvLK9zV5FiQfbV1WrviTPgzbkD3P1A8I/iHZCzKjUO6Ll1wVQ6eTTqSppj14u7pzyQN8mMRo4oQ== g.sastry@gmail.com"
  ];
  
  # Essential packages only
  environment.systemPackages = with pkgs; [ vim wget curl git ];
  
  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  system.stateVersion = "25.05";
}
