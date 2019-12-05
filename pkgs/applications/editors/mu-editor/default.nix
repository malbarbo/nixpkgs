{ lib
, python3Packages
, fetchFromGitHub
, wrapQtAppsHook
}:

python3Packages.buildPythonApplication rec {
  pname = "mu-editor";
  version = "1.1.0-alpha.2";

  src = fetchFromGitHub {
    owner = "mu-editor";
    repo = "mu";
    rev = version;
    sha256 = "1gv0vy6dam6r4j8gy90k5m9fk9q3vmch0rr3qjnl4c9ba35hjzr3";
  };

  patches = [ ./soften-dependency-versions.patch ];

  nativeBuildInputs = [
    wrapQtAppsHook
  ];

  dontWrapQtApps = true;

  preFixup = ''
    wrapQtApp $out/bin/mu-editor
  '';

  propagatedBuildInputs = with python3Packages; [
    appdirs
    black
    flask
    nudatus
    pgzero
    pycodestyle
    pyflakes
    pyqt5
    pyqtchart
    pyserial
    pytest
    qscintilla-qt5
    qtconsole
    semver
  ];

  doCheck = false;

  meta = with lib; {
    homepage = "https://codewith.mu/";
    license = licenses.gpl3Plus;
    maintainers = [ maintainers.das-g ];
    platforms = platforms.all;
  };
}
