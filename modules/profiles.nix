# modules/profiles.nix
{ den, ... }:
{
  den.aspects.nvim = {

    includes = with den.aspects; [
      core

      snacks
      navigation
      yazi
      television
      claude
      autopairs

      lsp
      languages
    ];
  };

  den.aspects.nvim-tex.includes = with den.aspects; [
    nvim
    vimtex
  ];
}
