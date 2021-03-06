{
  description = ''Module for working with paths that is as similar as possible to Python's pathlib'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."pythonpathlib-master".dir   = "master";
  inputs."pythonpathlib-master".owner = "nim-nix-pkgs";
  inputs."pythonpathlib-master".ref   = "master";
  inputs."pythonpathlib-master".repo  = "pythonpathlib";
  inputs."pythonpathlib-master".type  = "github";
  inputs."pythonpathlib-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."pythonpathlib-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}