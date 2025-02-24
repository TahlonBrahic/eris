_: regex: f: {
  matches = file: builtins.match regex file != null;
  loader = inputs: path:
    f (builtins.match regex (baseNameOf path)) inputs path;
}
