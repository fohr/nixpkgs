{ stdenv, fetchgit, cmake, mesa, libX11, freetype, libjpeg, openal, libsndfile
, glew, libXrandr, libXrender
}:
stdenv.mkDerivation rec {
  name = "sfml-git-20110428";
  src = fetchgit {
    url = "http://github.com/LaurentGomila/SFML.git";
    rev = "6eac4256f3be353f51ee";
    sha256 = "1b4f1901e0e482dbc0ad60e2821af766fb8ce093de51d678918ac2a0fb6e8587";
  };
  buildInputs = [ cmake mesa libX11 freetype libjpeg openal libsndfile glew
                  libXrandr libXrender
                ];
  patchPhase = "
    substituteInPlace CMakeLists.txt --replace '\${CMAKE_ROOT}/Modules' 'share/cmake-2.8/Modules'
  ";
  meta = with stdenv.lib; {
    homepage = http://www.sfml-dev.org/;
    description = "A multimedia C++ API that provides access to graphics, input, audio, etc.";
    license = licenses.zlib;
    maintainers = [ maintainers.astsmtl ];
  };
}
