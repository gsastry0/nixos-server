{
  description = "NixOS configuration for DigitalOcean droplet";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations.droplet = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        {
          # Enable cloud-init for userdata
          services.cloud-init.enable = true;
          
          # Optimize for small memory
          nix.settings.max-jobs = 1;
          nix.settings.cores = 1;
          
          # Hardware config for DigitalOcean
          boot.loader.grub.enable = true;
          boot.loader.grub.device = "/dev/vda";
          boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "xen_blkfront" "vmw_pvscsi" ];
          boot.initrd.kernelModules = [ "nvme" ];
          
          fileSystems."/" = { 
            device = "/dev/vda1"; 
            fsType = "ext4"; 
          };
        }
      ];
    };
  };
}
