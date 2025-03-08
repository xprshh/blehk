{pkgs, ...}: let
  c-dev = pkgs.writeShellScriptBin "c-dev" ''
   nix-shell -p gcc make cmake pkg-config
  '';
in {
  home.packages = [c-dev];
}
