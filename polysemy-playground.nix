{ mkDerivation, aeson, base, beam-core, beam-sqlite, hpack
, polysemy, polysemy-plugin, servant, servant-server, sqlite-simple
, stdenv, text, transformers, warp
}:
mkDerivation {
  pname = "polysemy-playground";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    aeson base beam-core beam-sqlite polysemy polysemy-plugin servant
    servant-server sqlite-simple text transformers warp
  ];
  libraryToolDepends = [ hpack ];
  executableHaskellDepends = [
    aeson base beam-core beam-sqlite polysemy polysemy-plugin servant
    servant-server sqlite-simple text transformers warp
  ];
  testHaskellDepends = [
    aeson base beam-core beam-sqlite polysemy polysemy-plugin servant
    servant-server sqlite-simple text transformers warp
  ];
  prePatch = "hpack";
  homepage = "https://github.com/barrymoo/polysemy-playground#readme";
  license = stdenv.lib.licenses.bsd3;
}
