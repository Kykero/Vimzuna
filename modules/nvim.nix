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
}
