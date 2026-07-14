# modules/zellij.nix
# Self-contained IDE package: `vimzuna` launches (or re-attaches to) a
# zellij session bundling its own config — vim-zellij-navigator bound to
# Ctrl/Alt+hjkl (matching smart-splits.nvim in aspects/navigation.nix),
# session serialization, and a layout that starts nvim. Nothing to
# configure system-side: the consuming repo just installs `packages.ide`.
{ den, ... }:
{
  den.aspects.flake.packages =
    { pkgs, ... }:
    let
      nvim = den.lib.nvf.package pkgs den.aspects.nvim;

      vim-zellij-navigator = pkgs.fetchurl {
        url = "https://github.com/hiasr/vim-zellij-navigator/releases/download/0.3.0/vim-zellij-navigator.wasm";
        hash = "sha256-d+Wi9i98GmmMryV0ST1ddVh+D9h3z7o0xIyvcxwkxY0=";
      };

      moveBind = key: payload: ''
        bind "Ctrl ${key}" {
            MessagePlugin "file:${vim-zellij-navigator}" {
                name "move_focus";
                payload "${payload}";
                move_mod "ctrl";
            };
        }
      '';

      resizeBind = key: payload: ''
        bind "Alt ${key}" {
            MessagePlugin "file:${vim-zellij-navigator}" {
                name "resize";
                payload "${payload}";
                resize_mod "alt";
            };
        }
      '';

      # NB: default_layout resolves a NAME inside layout_dir — a bare file
      # path there is silently ignored (zellij 0.44), hence the directory.
      layouts = pkgs.writeTextDir "vimzuna.kdl" ''
        layout {
            default_tab_template {
                pane size=1 borderless=true {
                    plugin location="zellij:tab-bar"
                }
                children
                pane size=2 borderless=true {
                    plugin location="zellij:status-bar"
                }
            }
            tab name="nvim" focus=true {
                pane command="nvim" close_on_exit=true
            }
        }
      '';

      config = pkgs.writeText "vimzuna-zellij-config.kdl" ''
        layout_dir "${layouts}"
        default_layout "vimzuna"

        // Layout/session resurrection: the vimzuna session survives
        // reboots; relaunching `vimzuna` revives it.
        session_serialization true

        keybinds {
            shared_except "locked" {
                ${moveBind "h" "left"}
                ${moveBind "j" "down"}
                ${moveBind "k" "up"}
                ${moveBind "l" "right"}
                ${resizeBind "h" "left"}
                ${resizeBind "j" "down"}
                ${resizeBind "k" "up"}
                ${resizeBind "l" "right"}
            }
        }
      '';
    in
    {
      ide = pkgs.writeShellApplication {
        name = "vimzuna";
        runtimeInputs = [
          pkgs.zellij
          nvim
        ];
        text = ''
          session="vimzuna"
          if zellij --config ${config} list-sessions --short --no-formatting 2>/dev/null \
              | grep -qx "$session"; then
            exec zellij --config ${config} attach "$session"
          else
            exec zellij --config ${config} --session "$session"
          fi
        '';
      };
    };
}
