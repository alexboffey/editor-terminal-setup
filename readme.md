# Editor & Terminal Setup

My macOS development environment: shell, fonts, terminal, editors, and Claude Code config, plus the scripts that install and drive them.

## New laptop

```sh
git clone git@github.com:alexboffey/editor-terminal-setup.git ~/Projects/editor-terminal-setup
cd ~/Projects/editor-terminal-setup
./bin/bootstrap
```

That does everything below in one go. It is idempotent, so re-running it after a `git pull` is the way to sync a second machine. Anything it would overwrite is copied to `<file>.backup-<timestamp>` first, and any step whose app is missing is skipped with a note rather than failing.

Run individual steps by name:

```sh
./bin/bootstrap fonts vscode      # just those two
```

| Step | Installs | To |
|---|---|---|
| `bin` | `bootstrap`, `claude-setup`, `dev`, `persona`, `theme-toggle` (symlinked, so `git pull` updates them) | `~/.local/bin` |
| `fonts` | Fira Code + 5 Monaspace variable fonts | `~/Library/Fonts` |
| `zsh` | `.zshrc` | `~/.zshrc` |
| `git` | `.gitconfig` | `~/.gitconfig` |
| `vim` | `.vimrc` | `~/.vimrc` |
| `nvim` | kickstart-based config + `lazy-lock.json` | `~/.config/nvim` |
| `ghostty` | config + the noctis themes | `~/Library/Application Support/com.mitchellh.ghostty`, `~/.config/ghostty/themes` |
| `vscode` | `settings.json` + every extension in `extensions.txt` | `~/Library/Application Support/Code/User` |
| `claude` | global Claude Code config, geezer persona | `~/.claude` |

### Prerequisites

`bootstrap` configures apps, it does not install them. Get these first:

```sh
# homebrew, then:
brew install --cask ghostty visual-studio-code
brew install neovim tmux
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Also needed:

- The VS Code `code` CLI on PATH (command palette → *Shell Command: Install 'code' command in PATH*). Without it the `vscode` step skips itself.
- Node, for `npx`-installed Claude skills.
- Claude Code itself, for the `claude` step to be worth anything.

### Afterwards

1. **Fill in the secrets.** `zsh/.zshrc` ships with `REPLACE_ME` placeholders for `GH_REGISTRY_PACKAGES`, `LINEAR_API_KEY` and `GEMINI_API_KEY`. Real values go in the local `~/.zshrc` only — this repo is public.
2. **Grant Accessibility permission** to Ghostty (System Settings → Privacy & Security → Accessibility) so `theme-toggle` can reload it.
3. **Open Neovim once** so lazy.nvim installs plugins against the committed lockfile.
4. **Launch Claude Code once** so it reinstalls the plugins declared in `claude/settings.json`.
5. **Install the third-party Claude skills** (see [Third-party Claude skills](#third-party-claude-skills)).

## theme-toggle

`bin/theme-toggle` flips VS Code and Ghostty between two theme pairs in one go:

| | VS Code | Ghostty |
|---|---|---|
| dark | Aura Dark | Aura |
| light | Noctis Lux | noctis-lux |

It edits `workbench.colorTheme` in VS Code's `settings.json` (applied live by VS Code) and `theme =` in `~/Library/Application Support/com.mitchellh.ghostty/config.ghostty`, then reloads Ghostty by clicking its "Reload Configuration" menu item via AppleScript.

Installed by `bootstrap` (steps `bin`, `ghostty`, `vscode`). It needs Accessibility permission for whichever app you run it from (System Settings → Privacy & Security → Accessibility → add Ghostty). Without that the themes still switch, you just have to press cmd+shift+, in Ghostty yourself.

```sh
theme-toggle
```

Run it again to switch back.

## persona

`bin/persona` switches the chat register Claude Code uses when talking to me. Persona files live in `claude/personas/`; the active one is symlinked to `~/.claude/active-persona.md`, which `~/.claude/CLAUDE.md` imports (same symlink pattern as the `tone` command uses for tone-of-voice). Personas only affect chat: code, commits, PRs, and anything Claude drafts as me are untouched.

```sh
persona            # list personas, show active
persona geezer     # east-end geezer, no rhyming slang
persona standard   # plain senior-engineer register
```

New personas are just markdown files: drop `claude/personas/<name>.md` in and `persona <name>` picks it up. Switches apply to new Claude Code sessions.

## dev

`bin/dev` opens (or reattaches to) a tmux session named `dev`, four panes: nvim top-left, two plain terminals below it, and `claude` down the right-hand quarter. Run it from the project directory you want to work in. Requires tmux.

```sh
dev
```

## Shell

`zsh/.zshrc` — oh-my-zsh with the `agnoster` theme, a `prompt_context` override that puts a random emoji in the prompt, PATH entries for bun, pnpm, nvm, Antigravity and `~/.local/bin`, and `alias cl='claude --dangerously-skip-permissions'`.

API keys are `REPLACE_ME` placeholders. Fill them in on the local `~/.zshrc` only, never here.

`git/.gitconfig` — identity, `pull.rebase = false`, and a `git recents` alias listing the last five branches checked out.

## Fonts

`fonts/` holds the variable-font (`VarVF`) builds, one file per family covering every weight, width and slant:

- **Fira Code** — the Ghostty terminal font (`font-family = Fira Code` at 15pt)
- **Monaspace** Argon, Krypton, Neon, Radon, Xenon — GitHub's family, used in VS Code

## Terminal (Ghostty)

`ghostty/config` is the whole terminal config: theme, font family, font size. It installs to `~/Library/Application Support/com.mitchellh.ghostty/config.ghostty`, which is also the file `theme-toggle` rewrites.

`ghostty/themes/` holds the three Noctis themes (`noctis-lux`, `noctis-lilac`, `noctis-minimum`) that don't ship with Ghostty. They go to `~/.config/ghostty/themes/`, where Ghostty picks up custom themes by filename. Aura is built in, so it isn't vendored here.

Ghostty has no reload CLI on macOS, so config changes need cmd+shift+, in the app (or `theme-toggle`, which clicks the menu item for you).

## VS Code

`vscode/settings.json` — the full user settings: Aura Dark theme, Material icon theme, Monaspace Neon Var at 15pt with the `ss01`–`ss08` texture-healing sets and `calt`/`dlig` enabled, Fira Code as fallback, format-on-save via Prettier for every web language, render affinity for the vscode-neovim extension, and a pile of notification and telemetry noise turned off.

`vscode/extensions.txt` — every installed extension as a runnable `code --install-extension` line, so the file doubles as the install script. Regenerate it after adding extensions:

```sh
code --list-extensions | sed 's|^|code --install-extension |' > vscode/extensions.txt
```

## Vim & Neovim

`vim/.vimrc` is the minimal fallback for plain `vim`: syntax on, dark background, 4-space soft tabs.

`nvim/` is the real editor config, a copy of `~/.config/nvim`. Based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) (`lazy` branch, Neovim 0.11 compatible) with personal additions in `lua/custom/plugins/`: catppuccin, nvim-tree, lualine, vim-tmux-navigator, markdown-preview. `lazy-lock.json` is committed, so a fresh machine gets the exact same plugin versions — just open `nvim` once after installing and lazy.nvim does the rest.

## Claude Code

`claude/` holds my global Claude Code config, a snapshot of `~/.claude` on my main machine. `bin/claude-setup` installs it.

What's in it:

- `CLAUDE.md` — global instructions (writing style, persona import, vault organisation)
- `AGENTS.md` — agent orchestration notes
- `settings.json` / `settings.local.json` — model, hooks, plugins, permissions (no secrets)
- `agents/` — subagent definitions
- `commands/` — slash commands
- `hooks/` — hook scripts (worktree placement, memory persistence) plus `hooks.json`
- `mcp-configs/mcp-servers.json` — MCP server catalogue, all credentials are `YOUR_*_HERE` placeholders
- `rules/` — the ECC ruleset (common + web)
- `scripts/` — ECC helper scripts
- `skills/` — skills that live only in `~/.claude` (currently just `ecc`)
- `personas/` — chat personas, managed by `bin/persona` (see above)

Deliberately not included:

- Work-internal skills and commands (GEEIQ-specific; this repo is public)
- Skills symlinked from other repos (`~/Projects/ai-agents`, the Obsidian vault) — tracked there
- Third-party skills that install and update themselves (see below)
- Machine state: sessions, history, caches, plugin installs, memory, `~/.claude.json` (holds OAuth tokens)

`bin/claude-setup` does the install on its own if you don't want the full bootstrap. It rsyncs, so it overlays rather than wipes. New Claude Code sessions pick it up.

### Plugins

Plugins aren't vendored either — `claude/settings.json` declares them under `enabledPlugins` and `extraKnownMarketplaces`, and Claude Code reinstalls them from those declarations on first launch. Currently enabled: linear, github, notion, slack, chrome-devtools-mcp, sentry, context7 (all from the official marketplace) plus `ponytail` from `DietrichGebert/ponytail`.

### Third-party Claude skills

These live under `~/.claude/skills/` on my machine but are **not** in this repo, because each one self-updates and vendoring it would just pin a stale fork. Reinstall them by hand on a new laptop:

```sh
npx impeccable install    # frontend design/craft skill, Apache 2.0
```

The `ecc` skill set (agents, rules, scripts, skills) *is* vendored, under `claude/`, because it's installed by copying files rather than by a package manager.
