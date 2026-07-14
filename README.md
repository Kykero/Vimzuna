# Neovim configuration

[![nvf](https://img.shields.io/badge/built%20with-nvf-8b5cf6?style=flat-square&logo=neovim&logoColor=white)](https://github.com/notashelf/nvf)
[![den](https://img.shields.io/badge/framework-den-06b6d4?style=flat-square)](https://github.com/denful/den)
[![NixOS](https://img.shields.io/badge/NixOS-unstable-5277c3?style=flat-square&logo=nixos&logoColor=white)](https://nixos.org)

Modular Neovim config built on [nvf](https://github.com/notashelf/nvf) and the
[den](https://github.com/denful/den) framework, designed to live inside
**zellij**. One file per aspect under `modules/aspects/`, composed into
profiles in `modules/profiles.nix`, exported as packages by `modules/den.nix`.

```sh
nix run .           # default Neovim (no LaTeX)
nix run .#latex     # Neovim + VimTeX + texlive-full
nix run .#ide       # full zellij IDE session (bundled config + nvim)
```

---

## 📦 Plugins

### ⚙️ Core

| Aspect      | File            | Notes                                            |
| ----------- | --------------- | ------------------------------------------------ |
| `core`      | `core.nix`      | Editor options, theme, leader (`<Space>`)        |
| `autopairs` | `autopairs.nix` | Auto-close brackets, quotes (nvim-autopairs)     |

### 🍿 Snacks

| Aspect   | File         | Notes                                                                                                               |
| -------- | ------------ | ------------------------------------------------------------------------------------------------------------------- |
| `snacks` | `snacks.nix` | lazygit, gh, notifier, dashboard, picker, QoL (scroll, quickfile, bigfile, input). Run `gh auth login` on first use |

### 🔬 LSP

| Aspect      | File            | Notes                                          |
| ----------- | --------------- | ---------------------------------------------- |
| `lsp`       | `lsp.nix`       | LSP core, diagnostics, Trouble, format on save |
| `languages` | `languages.nix` | nix, markdown, bash, python, json, sql, java   |

### 🤖 AI

| Aspect   | File         | Notes                                                                                                          |
| -------- | ------------ | -------------------------------------------------------------------------------------------------------------- |
| `claude` | `claude.nix` | claudecode.nvim — Claude runs in a zellij pane (native split as fallback). `claude` CLI installed per-machine; run `claude` to log in |

### 🛠️ Tools

| Aspect       | File             | Notes                                                             |
| ------------ | ---------------- | ----------------------------------------------------------------- |
| `navigation` | `navigation.nix` | smart-splits.nvim: seamless nvim ↔ zellij pane navigation         |
| `yazi`       | `yazi.nix`       | Yazi file manager (nvf)                                           |
| `television` | `television.nix` | Television fuzzy-finder (tv.nvim). Needs `tv`, `bat`, `rg`, `fd` |

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
| `<leader>gg` | `n`  | Lazygit              |
| `<leader>gi` | `n`  | GitHub Issues (open) |
| `<leader>gI` | `n`  | GitHub Issues (all)  |
| `<leader>gp` | `n`  | GitHub PRs (open)    |
| `<leader>gP` | `n`  | GitHub PRs (all)     |

### 🤖 AI (Claude)

| Key          | Mode | Action                |
| ------------ | ---- | --------------------- |
| `<leader>ac` | `n`  | Claude: toggle        |
| `<leader>as` | `v`  | Claude: send selection|
| `<leader>ab` | `n`  | Claude: add buffer    |
| `<leader>aa` | `n`  | Claude: accept diff   |
| `<leader>ad` | `n`  | Claude: deny diff     |

Claude lives in a zellij pane — move to/from it with `<C-h>` / `<C-l>`
like any other pane.

### 🔔 Notifications

| Key          | Mode | Action                |
| ------------ | ---- | --------------------- |
| `<leader>uh` | `n`  | Notification history  |
| `<leader>ud` | `n`  | Dismiss notifications |

### 🧭 Navigation (splits ↔ zellij panes)

| Key         | Mode  | Action                          |
| ----------- | ----- | ------------------------------- |
| `<C-h/j/k/l>` | `n,t` | Move between splits and panes |
| `<A-h/j/k/l>` | `n,t` | Resize split                  |

There is no in-editor terminal: shells, builds, etc. are zellij panes. Open
one with your zellij bindings and `<C-h/j/k/l>` straight into it.

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

## 🖥️ Zellij workflow

Neovim no longer manages terminals — it lives inside **zellij**, which owns
panes, tabs and session resurrection (zellij serializes sessions natively;
resurrect a dead one with `zellij attach` or the session manager).

- `<C-h/j/k/l>` moves seamlessly between Neovim splits and zellij panes
  (smart-splits.nvim on the nvim side, see contract below for the zellij side).
- `<leader>ac` spawns Claude Code in a zellij pane on the right; the MCP
  bridge (`<leader>as`, diffs, …) works exactly as before since the WebSocket
  server runs inside Neovim.
- Outside zellij, Claude falls back to a native `:terminal` split.

### Self-contained: the `ide` package

Both sides of the workflow ship in one package — `packages.ide` installs a
`vimzuna` command that starts (or re-attaches to) a zellij session with its
own bundled config (`modules/zellij.nix`):

- zellij + [vim-zellij-navigator](https://github.com/hiasr/vim-zellij-navigator)
  bound to `Ctrl/Alt+hjkl`, matching smart-splits.nvim
  (`modules/aspects/navigation.nix`) — the two sides can never drift apart
- `session_serialization` — the `vimzuna` session survives reboots,
  relaunching the command revives it
- a layout starting nvim in the first tab

Nothing to configure system-side; a consumer just installs the package:

```nix
inputs.vimzuna.packages.${system}.ide
```

Still installed per-machine: the `claude` CLI.

---

## 📡 Television channels

Channels live in `~/.config/television/` — not in this repo. The plugin
invokes them by name. Built-in channels (`files`, `text`) work out of the box.
Custom channels (e.g. `nixconf` scoped to NixOS config dirs) are provided
per-machine by the system/Home-Manager config.
