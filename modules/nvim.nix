{ den, ... }:
{
  den.aspects.nvim = {

    includes = with den.aspects; [
      core

      snacks
      terminal
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
