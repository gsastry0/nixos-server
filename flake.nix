# flake.nix - Based on hraban's approach
{
  description = "NixOS configuration for DigitalOcean droplet";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations.droplet = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Import DigitalOcean optimized config (like hraban's approach)
        "${nixpkgs}/nixos/modules/virtualisation/digital-ocean-image.nix"
        ./configuration.nix
        {
          # DigitalOcean specific optimizations for small droplets
          virtualisation.digitalOceanImage = {
            compressionMethod = "gzip";
            sizeMB = 2048;
          };
          
          # Enable cloud-init for userdata
          services.cloud-init.enable = true;
          
          # Optimize for small memory
          nix.settings.max-jobs = 1;
          nix.settings.cores = 1;
        }
      ];
    };
  };
}
