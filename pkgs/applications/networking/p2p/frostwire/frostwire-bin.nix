{ stdenv, fetchurl, jre, makeWrapper }:

with stdenv.lib;

stdenv.mkDerivation rec {
  version = "6.7.4";
  pname = "frostwire";

  src = fetchurl {
    url = "https://dl.frostwire.com/frostwire/${version}/frostwire-${version}.amd64.tar.gz";
    sha256 = "144qmvpnfmlq1xrkbhsjh4ib79gchdcr9pcasmdy1n9hqbk6y4bq";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/share/java
    mv $(ls */*.jar) $out/share/java

    makeWrapper $out/share/java/frostwire $out/bin/frostwire \
      --prefix PATH : ${jre}/bin/
  '';

  meta = with stdenv.lib; {
    homepage = https://www.frostwire.com/;
    description = "BitTorrent Client and Cloud File Downloader";
    license = licenses.gpl2;
    maintainers = with maintainers; [ gavin ];
    platforms = [ "x86_64-linux"];
  };
}
