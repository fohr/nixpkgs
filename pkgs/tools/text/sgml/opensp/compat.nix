{ stdenv, opensp }:

stdenv.mkDerivation {
  name = "sp-compat-${builtins.substring 7 100 opensp.name}";

  buildCommand = ''
    mkdir -pv $out/bin
    for i in ${opensp}/bin/o*; do
      ln -sv $i $out/bin/''${i#${opensp}/bin/o}
    done
    '';

  meta.description =
    "Compatibility wrapper for old programs looking for original sp programs";
}
