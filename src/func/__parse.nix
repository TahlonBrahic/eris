{lib}: path: type: let
  stripped = lib.removePrefix "_" (lib.removePrefix "_" path);
in
  if stripped == ""
  then null
  else {
    inherit stripped;

    name =
      {
        directory = stripped;

        regular = let
          dots = lib.pipe stripped [
            builtins.stringLength
            (builtins.genList lib.id)
            builtins.tail
            (builtins.filter (i: builtins.substring i 1 stripped == "."))
          ];
        in
          if lib.hasSuffix "." stripped || dots == []
          then stripped
          else builtins.substring 0 (lib.last dots) stripped;
      }
      .${type};

    visibility =
      if lib.hasPrefix "__" path
      then "super"
      else if lib.hasPrefix "_" path
      then "root"
      else "public";
  }
