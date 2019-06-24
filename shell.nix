with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "nixbox-shell";
  buildInputs = [
    ansible
    ansible-lint
    python37
    python37Packages.libvirt
    gnumake
    packer
  ];
}
