{ self
, stdenv
, lib
, wrapQtAppsHook
, qmake
, pkg-config
, qtbase
, qtsvg
, qtmultimedia
, qtscript
# , qttools
, qtserialport
, which
# , boost
# , libngspice
# , libgit2
# , quazip
}:

let
  buildX = "build_XX"; # the real build dir used by the project (pro file is tuned toward this, even though a bit flakey)
in

stdenv.mkDerivation rec {
  pname = "simulide";
  revision = "1425";
  version = "1.0.1-${revision}";

  src = ././../..;

  outputs = [ "out" ];

  buildInputs = [ qtbase qtsvg qtserialport qtscript qtmultimedia /* boost  libgit2 quazip libngspice */ ];
  nativeBuildInputs = [ qmake pkg-config /* qttools */ wrapQtAppsHook which ];

  # https://nixos.org/manual/nixpkgs/stable/#ssec-unpack-phase

  dontMakeSourcesWritable = false;

  # dontUnpack = true;
  # prePatch = ''
  #   substitute ${src}/SimulIDE.pro ${src}/SimulIDE.pro \
  #     --replace "$$system( bzr revno )" "${revision}"
  # '';

  preConfigure = ''
    echo "src=$src out=$out TMP=$TMP" >&2
    cp -r $src/src $src/resources $src/build_XX $TMP/
    chmod 775 $TMP/build_XX
    substitute $src/SimulIDE.pro $TMP/SimulIDE.pro \
      --replace "\$\$system( bzr revno )" "${revision}" \
      && cd ${buildX}
  '';

  preBuild = ''cd $TMP/${buildX}'';
  # buildPhase = ''
  #   cd /tmp/build
  #   qmake BUILD_DIR=/tmp/build
  #   make
  # '';
  # postPatch = ''
  # '';

  # env.NIX_CFLAGS_COMPILE = "-I${lib.getDev quazip}/include/QuaZip-Qt${lib.versions.major qtbase.version}-${quazip.version}/quazip";
  # makeFlags = [ "-j1" ]; # at least with -j24 we get an error during translation generation which looks parallelity-related
  
  qmakeFlags = [
    "SimulIDE.pro"
  ];

  # postFixup = ''
  #   # generate the parts.db file
  #   QT_QPA_PLATFORM=offscreen "$out/bin/Fritzing" \
  #     -db "$out/share/fritzing/parts/parts.db" \
  #     -pp "$out/share/fritzing/parts" \
  #     -folder "$out/share/fritzing"
  # '';

  meta = with lib; {
    description = ''
      A simple real time electronic circuit simulator, intended for hobbyist or students to
      learn and experiment with simple electronic circuits and microcontrollers, supporting PIC,
      AVR and Arduino
    '';
    homepage = "https://www.simulide.com";
    license = with licenses; [ gpl3 ];
    maintainers = with maintainers; [ ppenguin ];
    platforms = platforms.linux;
    mainProgram = "simulide";
  };
}
