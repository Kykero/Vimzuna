# modules/den.nix
{
  den,
  lib,
  inputs,
  ...
}:
{
  imports = [
    inputs.den.flakeModule
    inputs.den.flakeOutputs.packages
  ];

  # NVF integration : classe "vim" → forward vers nvf.vim
  den.lib.nvf.package =
    pkgs: vimAspect:
    (inputs.nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [ (den.lib.nvf.module vimAspect) ];
    }).neovim;

  den.lib.nvf.module =
    vimAspect:
    let
      vimClass =
        { class, aspect-chain }:
        den.batteries.forward {
          each = lib.singleton true;
          fromClass = _: "vim";
          intoClass = _: "nvf";
          intoPath = _: [ "vim" ];
          fromAspect = _: lib.head aspect-chain;
          adaptArgs = lib.id;
        };
      aspect = {
        includes = [
          vimClass
          vimAspect
        ];
      };
    in
    den.lib.aspects.resolve "nvf" aspect;

  # Expose le package
  den.schema.flake-system.includes = [ den.aspects.flake ];

  den.aspects.flake.packages =
    { pkgs, ... }:
    let
      nvf = den.lib.nvf.package pkgs;
    in
    {
      default = nvf den.aspects.nvim;

    };

}
