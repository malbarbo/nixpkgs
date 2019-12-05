{ stdenv
, lib
, fetchurl
, pkgs
, qt5
, qtbase
, python3Packages
}:
let
  inherit (python3Packages) buildPythonPackage python pyqt5;
  inherit (pyqt5) sip;
in stdenv.mkDerivation rec {
  pname = "pyqtchart";
  version = "5.12";

  src = fetchurl {
    url = "https://www.riverbankcomputing.com/static/Downloads/PyQtChart/${version}/PyQtChart_gpl-${version}.tar.gz";
    sha256 = "1my07cksnsxbcc7h7i0429xj712jrs3sqwdmifjv3pw1kyhcdsmc";
  };

  nativeBuildInputs = [ sip qtbase ];
  buildInputs = [ qt5.qtcharts ];
  propagatedBuildInputs = [ pyqt5 ];

  postPatch = ''
    substituteInPlace configure.py \
      --replace \
      "target_config.py_module_dir" \
      "'$out/${python.sitePackages}'"
  '';

  preConfigure = with pkgs; ''
    mkdir -p "$out/share/sip/PyQt5"
    ${python.executable} ./configure.py \
      --destdir=$out/${python.sitePackages}/PyQt5 \
      --stubsdir=$out/${python.sitePackages}/PyQt5 \
      --apidir=$out/api/${python.libPrefix} \
      --pyqt-sipdir=${pyqt5}/share/sip/PyQt5 \
      --sip-incdir=${sip}/include \
      --qtchart-sipdir="$out/share/sip/PyQt5"
  '';

  meta = with lib; {
    description = "Python bindings for Qt5";
    homepage    = http://www.riverbankcomputing.co.uk;
    license     = licenses.gpl3;
    platforms   = platforms.mesaPlatforms;
  };
}
