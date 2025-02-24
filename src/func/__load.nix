{
  lib,
  view,
  aggregate,
  root,
}: {
  src,
  loader ? root.loaders.default,
  inputs ? {},
  transformer ? [],
}: let
  transformer' = cursor:
    lib.trivial.flip lib.trivial.pipe
    (map (t: t cursor) (lib.lists.flatten transformer));
in
  assert lib.lists.all
  (name:
    inputs
    ? ${name}
    -> throw "'${name}' cannot be used as the name of an input")
  ["self" "super" "root"];
    view {
      pov = "external";
      transformer = transformer';
      node = lib.fixedPoints.fix (node: {
        isDir = true;
        children = aggregate {
          inherit src inputs;
          matchers =
            if lib.trivial.isFunction loader
            then [(root.matchers.nix loader)]
            else loader;
          tree = {
            pov = [];
            transformer = transformer';
            inherit node;
          };
        };
      });
    }
