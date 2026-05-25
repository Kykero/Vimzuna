# Neovim configuration

Modular Neovim config built on [nvf](https://github.com/notashelf/nvf) and the
[den](https://github.com/denful/den) framework. One file per plugin under
`modules/plugins`, each exposed as a `den.aspects.<plugin>` aspect and wired in
`modules/nvim.nix`. Run with `nix run .`.

## Plugins

### Core

| Aspect | File       | Notes                                     |
| ------ | ---------- | ----------------------------------------- |
| `core` | `core.nix` | Editor options, theme, leader (`<Space>`) |

### Snacks

| Aspect   | File         | Notes                                                                                                                                           |
| -------- | ------------ | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| `snacks` | `snacks.nix` | Single aspect for snacks.nvim: lazygit, gh, notifier, picker, QoL modules (scroll, quickfile, bigfile, input). Run `gh auth login` on first use |

### LSP

| Aspect      | File            | Notes                                                   |
| ----------- | --------------- | ------------------------------------------------------- |
| `lsp`       | `lsp.nix`       | LSP core, diagnostics, Trouble, format on save          |
| `languages` | `languages.nix` | Languages: nix, markdown, bash, python, json, sql, java |

### Tools

| Aspect       | File             | Notes                                                            |
| ------------ | ---------------- | ---------------------------------------------------------------- |
| `terminal`   | `terminal.nix`   | toggleterm: repositionable terminal (float/bottom/right)         |
| `yazi`       | `yazi.nix`       | Yazi file manager integration (nvf)                              |
| `television` | `television.nix` | Television fuzzy-finder (tv.nvim). Needs `tv`, `bat`, `rg`, `fd` |

## Keybinds

### Git

| Key          | Mode | Action               |
| ------------ | ---- | -------------------- |
| `<leader>gg` | `n`  | Lazygit              |
| `<leader>gi` | `n`  | GitHub Issues (open) |
| `<leader>gI` | `n`  | GitHub Issues (all)  |
| `<leader>gp` | `n`  | GitHub PRs (open)    |
| `<leader>gP` | `n`  | GitHub PRs (all)     |

### Notifications

| Key          | Mode | Action                |
| ------------ | ---- | --------------------- |
| `<leader>uh` | `n`  | Notification history  |
| `<leader>ud` | `n`  | Dismiss notifications |

### Terminal

| Key          | Mode     | Action                  |
| ------------ | -------- | ----------------------- |
| `<leader>tt` | `n`, `t` | Terminal (float/toggle) |
| `<leader>tj` | `n`, `t` | Terminal (bottom)       |
| `<leader>tl` | `n`, `t` | Terminal (right)        |

### File manager

| Key         | Mode | Action                   |
| ----------- | ---- | ------------------------ |
| `<leader>n` | `n`  | Open Yazi (current file) |
| `<leader>N` | `n`  | Open Yazi (cwd)          |

### Find (Television)

| Key          | Mode | Action             |
| ------------ | ---- | ------------------ |
| `<leader>ff` | `n`  | Find files         |
| `<leader>fg` | `n`  | Search text (grep) |
| `<leader>fc` | `n`  | Channel selector   |

### LSP

LSP keybinds use nvf's default mappings (go to definition, references, hover,
rename, code action, format, diagnostic navigation). Press `<leader>` and browse
with which-key, or see `vim.lsp.mappings.*` in the nvf options to customize
them.

## Television channels

Television channels are defined in `tv`'s config directory
(`~/.config/television/`), not in this Neovim repo. The plugin only invokes
channels by name. Generic channels (`files`, `text`) are built in. Custom
channels — e.g. a `nixconf` channel scoped to NixOS config directories — are
expected to be provided per-machine by the system/Home-Manager config; the
keymaps here will reference them once defined.
