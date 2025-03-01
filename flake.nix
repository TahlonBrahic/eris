{
  description = "Convert your filesystem to Nix attribute sets";

  inputs = {
    nixpkgs.url = "github:nix-community/nixpkgs.lib";
  };

  outputs = {
    self,
    nixpkgs,
  }: {
    lib = import self {
      inherit (nixpkgs) lib;
    };
  };
}
