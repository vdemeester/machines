
with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "nixbox-shell";
  buildInputs = [
    ansible
    ansible-lint
    gnumake
    packer
  ];
}
