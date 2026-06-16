{ den, ... }:
{
  den.aspects.nvim = {

    includes = with den.aspects; [
      core

      snacks
      yazi
      television
      claude
      autopairs
      tmux-nav

      lsp
      languages
    ];
  };

  den.aspects.nvim-tex.includes = with den.aspects; [
    nvim
    vimtex
  ];
}
