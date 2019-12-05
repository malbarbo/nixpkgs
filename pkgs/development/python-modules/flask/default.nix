{ stdenv, buildPythonPackage, fetchPypi
, itsdangerous, click, werkzeug, jinja2, pytest }:

buildPythonPackage rec {
  version = "1.0.2";
  pname = "Flask";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0j6f4a9rpfh25k1gp7azqhnni4mb4fgy50jammgjgddw1l3w0w92";
  };

  checkInputs = [ pytest ];
  propagatedBuildInputs = [ itsdangerous click werkzeug jinja2 ];

  checkPhase = ''
    py.test
  '';

  # Tests require extra dependencies
  doCheck = false;

  meta = with stdenv.lib; {
    homepage = http://flask.pocoo.org/;
    description = "A microframework based on Werkzeug, Jinja 2, and good intentions";
    license = licenses.bsd3;
  };
}
