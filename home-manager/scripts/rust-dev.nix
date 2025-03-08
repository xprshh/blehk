{pkgs, ...}: let
  rust-dev = pkgs.writeShellScriptBin "rust-dev" ''
   nix-shell -p clippy rustfmt cargo rustc pkg-config 
  '';
in {
  home.packages = [rust-dev];
}
