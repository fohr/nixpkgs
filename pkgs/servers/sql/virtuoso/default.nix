{ stdenv, fetchurl, libxml2, openssl, readline, gawk }:

stdenv.mkDerivation rec {
  name = "virtuoso-opensource-6.1.5";

  src = fetchurl {
    url = "mirror://sourceforge/virtuoso/${name}.tar.gz";
    sha256 = "02aax76f51ya5slp1slv4r1ihcb7zpb040n33b581g8n1ppgj2ps";
  };

  buildInputs = [ libxml2 openssl readline gawk ];

  CPP = "${stdenv.gcc}/bin/gcc -E";

  configureFlags = "
    --enable-shared --disable-all-vads --with-readline=${readline}
    --disable-hslookup --disable-wbxml2 --without-iodbc
    --enable-openssl=${openssl}
    ";

  postInstall=''
    echo Moving documentation
    mkdir -pv $out/share/doc
    mv -v $out/share/virtuoso/doc $out/share/doc/${name}
    echo Removing jars and empty directories
    find $out -name "*.a" -delete -o -name "*.jar" -delete -o -type d -empty -delete
    '';
  
  meta = with stdenv.lib; {
    description = "SQL/RDF database used by, e.g., KDE-nepomuk";
    homepage = http://virtuoso.openlinksw.com/dataspace/dav/wiki/Main/;
    platforms = platforms.all;
    maintainers = [ maintainers.urkud ];
  };
}
