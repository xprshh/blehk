{pkgs, ...}: let
  rust-dev = pkgs.writeShellScriptBin "rust-dev" ''
   nix-shell -p  rustc cargo pkg-config gtk4 glib cairo gobject-introspection wrapGAppsHook gtk3 gobject-introspection
  '';
in {
  home.packages = [rust-dev];
}
