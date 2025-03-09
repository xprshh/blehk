{pkgs, ...}: let
  rust-dev = pkgs.writeShellScriptBin "nx-clean" ''
   sudo nix-collect-garbage --delete-older-than 2d
   sudo nix-store --gc
   sudo nix-store --optimise
  '';
in {
  home.packages = [nx-clean];
}
