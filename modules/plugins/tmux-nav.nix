# modules/plugins/tmux-nav.nix
# vim-tmux-navigator — seamless <C-h/j/k/l> movement between Neovim splits
# and tmux panes. VimScript plugin: load at startup so its mappings exist.
# The mirror bindings live in the tmux config (see .tmux.conf at repo root).
{ ... }:
{
  den.aspects.tmux-nav.vim =
    { pkgs, ... }:
    {
      # lazygit runs from the tmux popup (Prefix g), provided here via the
      # Neovim wrapper environment.
      extraPackages = [ pkgs.lazygit ];

      startPlugins = [ pkgs.vimPlugins.vim-tmux-navigator ];
    };
}
