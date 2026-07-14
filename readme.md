# Editor & Terminal Setup
A collection of fonts, themes and settings for various developer tools.

## theme-toggle

`bin/theme-toggle` flips VS Code and Ghostty between two theme pairs in one go:

| | VS Code | Ghostty |
|---|---|---|
| dark | Aura Dark | Aura |
| light | Noctis Lux | noctis-lux |

It edits `workbench.colorTheme` in VS Code's `settings.json` (applied live by VS Code) and `theme =` in `~/Library/Application Support/com.mitchellh.ghostty/config.ghostty`, then reloads Ghostty by clicking its "Reload Configuration" menu item via AppleScript.

### Install

```sh
# the script
ln -sf "$PWD/bin/theme-toggle" ~/.local/bin/theme-toggle

# ghostty themes (Aura is bundled with Ghostty, noctis-* are not)
mkdir -p ~/.config/ghostty/themes
cp ghostty/themes/* ~/.config/ghostty/themes/

# vscode themes
code --install-extension daltonmenezes.aura-theme
code --install-extension liviuschera.noctis
```

Requires:

- `~/.local/bin` on your PATH
- Accessibility permission for the app you run it from (System Settings → Privacy & Security → Accessibility → add Ghostty), needed for the AppleScript reload. Without it the themes still switch but you have to press cmd+shift+, in Ghostty manually.

### Use

```sh
theme-toggle
```

Run it again to switch back.
