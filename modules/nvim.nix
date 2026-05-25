{ den, ... }:
{
  den.aspects.nvim = {

    includes = with den.aspects; [
      core

      snacks
      terminal
      yazi
      television

      lsp
      languages
    ];
  };

  den.aspects.nvim-tex.includes = with den.aspects; [
    nvim
    vimtex
  ];
}
