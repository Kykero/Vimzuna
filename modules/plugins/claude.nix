# mtodules/claude.nix
# claudecode.nvim — bridges Neovim with the Claude Code CLI over the
# MCP WebSocket protocol. The `claude` CLI itself is NOT provided here;
# install it per-machine via the system config and run `claude` to log in.
{
  den.aspects.claude.vim =
    { pkgs, ... }:
    {
      extraPlugins.claudecode-nvim = {
        package = pkgs.vimPlugins.claudecode-nvim;
        setup = ''
          require("claudecode").setup({
            terminal = {
              provider = "snacks",
              snacks_win_opts = {
                position = "right",
                width = 0.40,
              },
            },
          })
        '';
      };

      keymaps = [
        {
          key = "<leader>ac";
          mode = [ "n" ];
          action = "<cmd>ClaudeCode<cr>";
          desc = "Claude: toggle";
        }
        {
          key = "<leader>af";
          mode = [ "n" ];
          action = "<cmd>ClaudeCodeFocus<cr>";
          desc = "Claude: focus window";
        }
        {
          key = "<leader>as";
          mode = [ "v" ];
          action = "<cmd>ClaudeCodeSend<cr>";
          desc = "Claude: send selection";
        }
        {
          key = "<leader>ab";
          mode = [ "n" ];
          action = "<cmd>ClaudeCodeAdd %<cr>";
          desc = "Claude: add current buffer";
        }
        {
          key = "<leader>aa";
          mode = [ "n" ];
          action = "<cmd>ClaudeCodeDiffAccept<cr>";
          desc = "Claude: accept diff";
        }
        {
          key = "<leader>ad";
          mode = [ "n" ];
          action = "<cmd>ClaudeCodeDiffDeny<cr>";
          desc = "Claude: deny diff";
        }
      ];
    };
}
