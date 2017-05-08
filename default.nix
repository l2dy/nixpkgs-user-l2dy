{ system ? builtins.currentSystem }:

let
  pkgs = import <nixpkgs> { inherit system; };
  
  callPackage = pkgs.lib.callPackageWith (self // pkgs);
  
  self = {
    # hello = callPackage ./pkgs/applications/misc/hello { };
  };
in
self
