# Neovim configuration

[![nvf](https://img.shields.io/badge/built%20with-nvf-8b5cf6?style=flat-square&logo=neovim&logoColor=white)](https://github.com/notashelf/nvf)
[![den](https://img.shields.io/badge/framework-den-06b6d4?style=flat-square)](https://github.com/denful/den)
[![NixOS](https://img.shields.io/badge/NixOS-unstable-5277c3?style=flat-square&logo=nixos&logoColor=white)](https://nixos.org)

Modular Neovim config built on [nvf](https://github.com/notashelf/nvf) and the
[den](https://github.com/denful/den) framework. One file per plugin under
`modules/`, each exposed as a `den.aspects.<plugin>` aspect and wired in
`modules/nvim.nix`.

```sh
nix run .           # default Neovim (no LaTeX)
nix run .#latex     # Neovim + VimTeX + texlive-full
```

---

## 📦 Plugins

### ⚙️ Core

| Aspect      | File            | Notes                                            |
| ----------- | --------------- | ------------------------------------------------ |
| `core`      | `core.nix`      | Editor options, theme, leader & localleader (`<Space>`) |
| `autopairs` | `autopairs.nix` | Auto-close brackets, quotes (nvim-autopairs)     |
| `tmux-nav`  | `tmux-nav.nix`  | vim-tmux-navigator: `<C-hjkl>` across nvim splits & tmux panes |

### 🍿 Snacks

| Aspect   | File         | Notes                                                                                                               |
| -------- | ------------ | ------------------------------------------------------------------------------------------------------------------- |
| `snacks` | `snacks.nix` | gh, notifier, dashboard, picker, QoL (scroll, quickfile, bigfile, input). Run `gh auth login` on first use |

### 🔬 LSP

| Aspect      | File            | Notes                                          |
| ----------- | --------------- | ---------------------------------------------- |
| `lsp`       | `lsp.nix`       | LSP core, diagnostics, Trouble, format on save |
| `languages` | `languages.nix` | nix, markdown, bash, python, json, sql, java   |

### 🤖 AI

| Aspect   | File         | Notes                                                                       |
| -------- | ------------ | --------------------------------------------------------------------------- |
| `claude` | `claude.nix` | claudecode.nvim (right split). `claude` CLI installed per-machine; run `claude` to log in |

### 🛠️ Tools

| Aspect       | File             | Notes                                                             |
| ------------ | ---------------- | ----------------------------------------------------------------- |
| `yazi`       | `yazi.nix`       | Yazi file manager (nvf)                                           |
| `television` | `television.nix` | Television fuzzy-finder (tv.nvim). Needs `tv`, `bat`, `rg`, `fd` |

> **Terminals & git live in tmux**, not in Neovim. There is no built-in
> terminal aspect anymore. See [tmux](#-tmux) below — lazygit opens in a tmux
> popup (`Prefix g`) and new shells are just tmux panes.

### 📝 LaTeX *(`.#latex` only)*

| Aspect   | File         | Notes                                   |
| -------- | ------------ | --------------------------------------- |
| `vimtex` | `vimtex.nix` | VimTeX + texlive-full + zathura SyncTeX |

---

## ⌨️ Keybinds

> Leader: `<Space>` — LocalLeader: `<Space>`

### 🔀 Git

| Key          | Mode | Action               |
| ------------ | ---- | -------------------- |
| `<leader>gi` | `n`  | GitHub Issues (open) |
| `<leader>gI` | `n`  | GitHub Issues (all)  |
| `<leader>gp` | `n`  | GitHub PRs (open)    |
| `<leader>gP` | `n`  | GitHub PRs (all)     |

### 🤖 AI (Claude)

| Key          | Mode | Action                |
| ------------ | ---- | --------------------- |
| `<leader>ac` | `n`  | Claude: toggle        |
| `<leader>af` | `n`  | Claude: focus window  |
| `<leader>as` | `v`  | Claude: send selection|
| `<leader>ab` | `n`  | Claude: add buffer    |
| `<leader>aa` | `n`  | Claude: accept diff   |
| `<leader>ad` | `n`  | Claude: deny diff     |

In the Claude split: `<Esc><Esc>` to enter normal mode, then `<C-w>h` / `<C-w>l`
to move between Claude and your code (`<C-w>p` jumps back and forth).

### 🔔 Notifications

| Key          | Mode | Action                |
| ------------ | ---- | --------------------- |
| `<leader>uh` | `n`  | Notification history  |
| `<leader>ud` | `n`  | Dismiss notifications |

### 🖥️ Terminal / tmux

No in-editor terminal. Use tmux panes for shells and git. Navigation between
Neovim splits and tmux panes is unified via vim-tmux-navigator:

| Key     | Mode | Action                                   |
| ------- | ---- | ---------------------------------------- |
| `<C-h>` | `n`  | Move to split/pane on the left           |
| `<C-j>` | `n`  | Move to split/pane below                 |
| `<C-k>` | `n`  | Move to split/pane above                 |
| `<C-l>` | `n`  | Move to split/pane on the right          |

See the [tmux](#-tmux) section for the tmux-side bindings (lazygit, splits).

### 📁 File manager

| Key         | Mode | Action                   |
| ----------- | ---- | ------------------------ |
| `<leader>n` | `n`  | Open Yazi (current file) |
| `<leader>N` | `n`  | Open Yazi (cwd)          |

### 🔭 Find (Television)

| Key          | Mode | Action             |
| ------------ | ---- | ------------------ |
| `<leader>ff` | `n`  | Find files         |
| `<leader>fg` | `n`  | Search text (grep) |
| `<leader>fc` | `n`  | Channel selector   |

### 🔬 LSP

LSP keybinds use nvf's default mappings (go to definition, references, hover,
rename, code action, diagnostics). Browse them with `<leader>` + which-key, or
see `vim.lsp.mappings.*` in the nvf options to customize.

### 📝 LaTeX *(`.#latex` only)*

VimTeX default `<localleader>l*` mappings:

| Key               | Action             |
| ----------------- | ------------------ |
| `<localleader>ll` | Compile (toggle)   |
| `<localleader>lv` | View PDF (SyncTeX) |
| `<localleader>lc` | Clean aux files    |
| `<localleader>lt` | Table of contents  |
| `<localleader>le` | Show errors        |
| `<localleader>lk` | Stop compilation   |

---

## 🖥️ tmux

Terminals and git live in **tmux**, not in Neovim. A starter `.tmux.conf` ships
at the repo root — it is **not** part of the Nix flake (tmux is a separate
program). Install it with:

```sh
cp .tmux.conf ~/.config/tmux/tmux.conf   # tmux >= 3.1
# or wire it via Home-Manager (programs.tmux) on NixOS
```

Requires tmux >= 3.2 for the lazygit popup. The prefix is remapped to `Ctrl-a`
(edit the top of `.tmux.conf` to keep the default `Ctrl-b`).

| Key          | Action                                    |
| ------------ | ----------------------------------------- |
| `Prefix g`   | Lazygit (centered popup)                  |
| `Prefix \|`  | Split vertical (current dir)              |
| `Prefix -`   | Split horizontal (current dir)            |
| `Prefix c`   | New window (current dir)                  |
| `Prefix r`   | Reload `tmux.conf`                         |
| `<C-hjkl>`   | Move across nvim splits **and** tmux panes |

The `<C-hjkl>` bindings work seamlessly thanks to vim-tmux-navigator (nvim side,
`tmux-nav.nix`) plus the mirror bindings in `.tmux.conf`.

---

## 📡 Television channels

Channels live in `~/.config/television/` — not in this repo. The plugin
invokes them by name. Built-in channels (`files`, `text`) work out of the box.
Custom channels (e.g. `nixconf` scoped to NixOS config dirs) are provided
per-machine by the system/Home-Manager config.
