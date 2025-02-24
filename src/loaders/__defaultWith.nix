#lib: importer: inputs: path: let
#  lambda = lib.toFunction (importer path);
#in
#  lib.pipe lambda [
#    lib.functionArgs
#    (builtins.mapAttrs (name: _: inputs.${name}))
#    lambda
#  ]
{lib}: importer: inputs: path: let
  f = builtins.trace inputs.root lib.toFunction (importer path);
in
  lib.pipe f [
    lib.functionArgs
    (builtins.mapAttrs (name: _: inputs.${name}))
    f
  ]
