{pkgs, ...}: let
  rust-dev = pkgs.writeShellScriptBin "rust-dev" ''
   nix-shell -p gcc make cmake pkg-config
  '';
in {
  home.packages = [rust-dev];
}
