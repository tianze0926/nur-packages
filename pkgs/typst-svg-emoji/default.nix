{ stdenvNoCC
, fetchFromGitHub
, lib
}:

stdenvNoCC.mkDerivation rec {
  pname = "typst-svg-emoji";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "polazarus";
    repo = "typst-svg-emoji";
    fetchSubmodules = true;
    rev = "ae1ca043df91b9ec21da068b77769d9e1d4c8512";
    hash = "sha256-8gtPVHCj8pRr3kS5B4cHQyud+MCXjbVRG/nczCEma+g=";
  };

  installPhase = let
    dest = "$out/share/typst/packages/local/svg-emoji/${version}/";
  in ''
    runHook preInstall

    mkdir -pv ${dest}
    cp -rv --parents \
      typst.toml github.json raw_github.json noto.json noto.regex \
      lib.typ noto-emoji/svg/* \
      ${dest}

    runHook postInstall
  '';
}
