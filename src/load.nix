{lib}: let
  self.lib.path.splitRelPath = path: let
    parts = builtins.split "/+(\\./+)*" path;
    partCount = lib.lists.length parts / 2 + 1;
    skipStart =
      if lib.lists.head parts == "."
      then 1
      else 0;
    skipEnd =
      if lib.lists.last parts == "." || lib.lists.last parts == ""
      then 1
      else 0;
    componentCount = partCount - skipEnd - skipStart;
  in
    if path == "."
    then []
    else
      lib.lists.genList (
        index:
          lib.lists.elemAt parts ((skipStart + index) * 2)
      )
      componentCount;

  self.lib.subpath.components = subpath:
    self.lib.path.splitRelPath (builtins.toString subpath);

  load =
    builtins.elemAt (
      lib.lists.forEach
      (lib.filesystem.listFilesRecursive
        ./.)
      self.lib.subpath.components
    )
    0;
in
  load
