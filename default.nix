{lib}: let
  load = import ./src/load.nix {
    inherit lib;
  };
in
  load
