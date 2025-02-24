{lib}: let
  entry = import ./src/func/__entry.nix;

  viewLambda = import ./src/func/__view.nix {inherit lib;};
  view = viewLambda {inherit root;};

  aggregateLambda = import ./src/func/__aggregate.nix {inherit lib;};
  aggregate = aggregateLambda {inherit root view entry;};

  root = {
    inherit view;
    loaders.default = import ./src/loaders {
      super.defaultWith = import ./src/loaders/__defaultWith.nix {
        inherit lib;
      };
    };
    matchers.nix = import ./src/matchers/nix.nix {
      super.extension = import ./src/matchers/extension.nix {
        inherit lib;
      };
    };
    parse = import ./src/func/__parse.nix {
      inherit lib;
    };
  };

  # Better to define this a loadLambda
  load = import ./src/func/__load.nix {
    inherit lib aggregate view root;
  };
in
  load {
    src = ./src;
    inputs = {
      inherit lib;
    };
  }
