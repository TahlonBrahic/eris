# Contributing to Eris

Unless explicitly stated, all contributions are licensed under
[MPL-2.0](http://mozilla.org/MPL/2.0), the license used by haumea.

## Making Changes to the API

This doesn't apply to bug fixes.

- Discuss before opening a pull request, so your work doesn't go to waste.
  Anything from GitHub issues to Matrix discussions is fine.
- Update documentation accordingly. Everything in `haumea.lib` should be documented.
- Add [tests](https://github.com/nix-community/haumea/tree/main/tests) when necessary.
  Test your changes with `nix flake check`. Make sure new files are added to git.

## Documentation

Documentation sits in the [docs](https://github.com/nix-community/haumea/tree/main/docs)
directory. You can get started with `nix develop ./docs`, which will start up
[mdbook](https://github.com/rust-lang/mdbook) and serve the documentation on localhost.

## Scope

Eris only depends on [nixpkgs.lib](https://github.com/nix-community/nixpkgs.lib).
Features that depend on the rest of [nixpkgs] should not be added.
However, changes that are specific to, but don't depend on [nixpkgs] are allowed.

## Style

- Format all Nix files with [nixpkgs-fmt](https://github.com/nix-community/nixpkgs-fmt).
- `with` should be avoided unless absolutely necessary,
  `let inherit` is preferred at almost all times.
- `rec` attribute sets should be avoided at most times, use `self` or `let-in` instead.

[nixpkgs]: https://github.com/nixos/nixpkgs
