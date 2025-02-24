{lib}: {
  root,
  view,
  entry,
}: let
  aggregate = {
    src,
    matchers,
    inputs,
    tree,
  }: let
    aggregateEntry = path: type: let
      parsed = root.parse path type;
      inherit (parsed) name visibility stripped;
      matches = lib.filter (m: m.matches stripped) matchers;
    in
      if parsed == null
      then null
      else if type == "directory"
      then
        lib.attrsets.nameValuePair name
        {
          inherit path visibility;
          isDir = true;
          children = aggregate {
            inherit inputs matchers;
            src = src + "/${path}";
            tree =
              tree
              // {
                pov = tree.pov ++ [name];
              };
          };
        }
      else if type == "regular" && matches != []
      then
        lib.attrsets.nameValuePair name
        {
          inherit path visibility;
          isDir = false;
          content = lib.fix (self:
            (lib.lists.head matches).loader
            (inputs
              // {
                inherit self;
                super = lib.attrsets.getAttrFromPath tree.pov (view tree);
                root = view tree;
              })
            (src + "/${path}"));
        }
      else null;
  in
    lib.pipe src [
      builtins.readDir
      (lib.mapAttrs aggregateEntry)
      lib.attrValues
      (lib.remove null)
      (lib.flip lib.foldl' {}
        (acc: {
          name,
          value,
        }:
          if acc ? ${name}
          then
            throw ''
              haumea failed when traversing ${toString src}
              - ${entry acc.${name}} conflicts with ${entry value}
            ''
          else
            acc
            // {
              ${name} = value;
            }))
    ];
in
  aggregate
