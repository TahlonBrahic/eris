{lib}: ext: f: {
  matches = file:
    lib.hasSuffix ".${ext}" file
    && builtins.stringLength file > (builtins.stringLength ext + 1);
  loader = f;
}
