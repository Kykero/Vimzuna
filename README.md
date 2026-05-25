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

| Aspect | File       | Notes                                     |
| ------ | ---------- | ----------------------------------------- |
| `core` | `core.nix` | Editor options, theme, leader (`<Space>`) |

### 🍿 Snacks

| Aspect   | File         | Notes                                                                                                               |
| -------- | ------------ | ------------------------------------------------------------------------------------------------------------------- |
| `snacks` | `snacks.nix` | lazygit, gh, notifier, dashboard, picker, QoL (scroll, quickfile, bigfile, input). Run `gh auth login` on first use |

### 🔬 LSP

| Aspect      | File            | Notes                                          |
| ----------- | --------------- | ---------------------------------------------- |
| `lsp`       | `lsp.nix`       | LSP core, diagnostics, Trouble, format on save |
| `languages` | `languages.nix` | nix, markdown, bash, python, json, sql, java   |

### 🛠️ Tools

| Aspect       | File             | Notes                                                             |
| ------------ | ---------------- | ----------------------------------------------------------------- |
| `terminal`   | `terminal.nix`   | toggleterm: float / bottom / right                                |
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

### 🔔 Notifications

| Key          | Mode | Action                |
| ------------ | ---- | --------------------- |
| `<leader>uh` | `n`  | Notification history  |
| `<leader>ud` | `n`  | Dismiss notifications |

### 🖥️ Terminal

| Key          | Mode     | Action                  |
| ------------ | -------- | ----------------------- |
| `<leader>tt` | `n`, `t` | Terminal (float/toggle) |
| `<leader>tj` | `n`, `t` | Terminal (bottom)       |
| `<leader>tl` | `n`, `t` | Terminal (right)        |

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

## 📡 Television channels

Channels live in `~/.config/television/` — not in this repo. The plugin
invokes them by name. Built-in channels (`files`, `text`) work out of the box.
Custom channels (e.g. `nixconf` scoped to NixOS config dirs) are provided
per-machine by the system/Home-Manager config.
