# modules/terminal.nix
{ lib, ... }:
{
  den.aspects.terminal.vim = {
    terminal.toggleterm = {
      enable = true;
      lazygit.enable = false;
      setupOpts = {
        direction = "float";
        open_mapping = null;
        float_opts.border = "rounded";
      };
    };
    keymaps = [
      {
        key = "<leader>tt";
        mode = [
          "n"
          "t"
        ];
        action = "<cmd>ToggleTerm<cr>";
        desc = "Terminal (float/toggle)";
      }
      {
        key = "<leader>tj";
        mode = [
          "n"
          "t"
        ];
        action = "<cmd>ToggleTerm direction=horizontal<cr>";
        desc = "Terminal (bottom)";
      }
      {
        key = "<leader>tl";
        mode = [
          "n"
          "t"
        ];
        action = "<cmd>ToggleTerm direction=vertical<cr>";
        desc = "Terminal (right)";
      }
    ];
  };
}
