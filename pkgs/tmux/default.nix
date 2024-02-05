# https://github.com/NixOS/nixpkgs/issues/268472#issuecomment-1817820348
{ tmux
, fetchFromGitHub
}: tmux.overrideAttrs (x: rec {
  version = "bdf8e614af34ba1eaa8243d3a818c8546cb21812";
  src = fetchFromGitHub {
    owner = "tmux";
    repo = "tmux";
    rev = version;
    hash = "sha256-ZMlpSOmZTykJPR/eqeJ1wr1sCvgj6UwfAXdpavy4hvQ=";
  };
  patches = [
    ./input_buf.patch # https://github.com/tmux/tmux/issues/3668#issuecomment-1689540241
  ];
  configureFlags = (x.configureFlags or []) ++ [
    "--enable-sixel"
  ];
})
