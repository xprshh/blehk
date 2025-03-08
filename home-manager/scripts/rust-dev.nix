{pkgs, ...}: let
  rust-dev = pkgs.writeShellScriptBin "rust-dev" ''
   nix-shell -p  rustc cargo pkg-config gtk4 glib cairo gobject-introspection wrapGAppsHook
  '';
in {
  home.packages = [rust-dev];
}
