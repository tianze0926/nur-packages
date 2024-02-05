{ lib
, stdenv
, fetchFromGitHub
, fetchpatch
, makeWrapper
, file
, openssl
, atool
, bat
, chafa
, delta
, ffmpeg
, ffmpegthumbnailer
, fontforge
, glow
, imagemagick
, jq
, ueberzug
}:

stdenv.mkDerivation rec {
  pname = "ctpv";
  version = "4efa0f976eaf8cb814e0aba4f4f1a1d12ee9262e";

  src = fetchFromGitHub {
    owner = "NikitaIvanovV";
    repo = pname;
    rev = version;
    hash = "sha256-tFBXCUey1lsNAg1mB0iQjDoH70qL8aytE6h9rhHlBe4=";
  };

  patches = [
    (fetchpatch {
      url = "https://patch-diff.githubusercontent.com/raw/NikitaIvanovV/ctpv/pull/90.patch";
      hash = "sha256-uFrXM0CkfCAeHSo+oWAsI+qu0DrTpX6cGjqhevHULc4=";
    })
  ];

  nativeBuildInputs = [ makeWrapper ];

  buildInputs = [
    file # libmagic
    openssl
  ];

  makeFlags = [ "PREFIX=$(out)" ];

  preFixup = ''
    wrapProgram $out/bin/ctpv \
      --prefix PATH ":" "${lib.makeBinPath [
        atool # for archive files
        bat
        chafa # for image files on Wayland
        delta # for diff files
        ffmpeg
        ffmpegthumbnailer
        fontforge
        glow # for markdown files
        imagemagick
        jq # for json files
        ueberzug # for image files on X11
      ]}";
  '';

  meta = with lib; {
    description = "File previewer for a terminal";
    homepage = "https://github.com/NikitaIvanovV/ctpv";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = [ maintainers.wesleyjrz ];
  };
}
