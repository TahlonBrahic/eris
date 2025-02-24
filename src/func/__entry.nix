{
  isDir,
  path,
  ...
}: "${
  if isDir
  then "directory"
  else "file"
} '${path}'"
