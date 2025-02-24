{lib}: {root}: {
  cursor ? [],
  node,
  pov,
  transformer,
}:
if node.isDir
then
  transformer cursor
  (lib.flip lib.concatMapAttrs node.children
    (name: node:
      lib.optionalAttrs
      {
        public = true;
        root = pov != "external";
        super = pov != "external" && lib.take (builtins.length cursor) pov == cursor;
      }
      .${node.visibility}
      {
        ${name} = root.view {
          cursor = cursor ++ [name];
          inherit node pov transformer;
        };
      }))
else node.content
