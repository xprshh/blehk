{pkgs, ...}: let
  vala-dev = pkgs.writeShellScriptBin "vala-dev" ''
   nix-shell -p gtk4 gtk3 vala meson ninja pkg-config gcc glib ligee gobject-introspection gtk-doc clang gtk-layer-shell clang 
  '';
in {
  home.packages = [vala-dev];
}
