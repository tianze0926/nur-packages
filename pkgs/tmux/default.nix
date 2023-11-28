# https://github.com/NixOS/nixpkgs/issues/268472#issuecomment-1817820348
{ tmux
, fetchFromGitHub
}: tmux.overrideAttrs (x: {
  configureFlags = (x.configureFlags or []) ++ [
    "--enable-sixel"
  ];
  src = fetchFromGitHub {
    owner = "tmux";
    repo = "tmux";
    rev = "bdf8e614af34ba1eaa8243d3a818c8546cb21812";
    hash = "sha256-ZMlpSOmZTykJPR/eqeJ1wr1sCvgj6UwfAXdpavy4hvQ=";
  };
  patches = [];
})
