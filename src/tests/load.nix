{
  lib,
  root,
}: args: let
  tests = root.load args;

  results = lib.runTests (tests
    // {
      tests = builtins.attrNames tests;
    });
in
  assert tests
  ? tests
  -> "'tests' cannot be used as the name of a test";
  assert results
  != []
  -> throw (lib.generators.toPretty {} results); {}
