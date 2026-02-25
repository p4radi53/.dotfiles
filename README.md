# My dotfiles repo

This repo is managed using a bare git repository.

Setting up from scratch:
```bash
git init --bare $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
```

Cloning:
```bash
git clone --bare <repo-url> $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles checkout
```

Configuration (required for both setup methods):
```bash
dotfiles config --local status.showUntrackedFiles no
dotfiles config --local core.excludesFile "$HOME/.config/dotfiles-ignore"
```


Contains configurations for:
- [tmux](#tmux): Terminal multiplexer for managing multiple sessions.
- nvim: Highly customized text editor configuration with plugins and key mappings.
- ghostty: Terminal emulator settings for themes, fonts, and behavior.
- bash: Shell configuration.
- aerospace: i3-like window/tiling manager
- brewfile: homebrew installation list

---

## tmux

### Sessions

tmux sessions persist as long as the tmux server is running. Key commands:

```bash
# Create a new named session
tmux new -s <name>

# List sessions
tmux ls

# Attach to a session
tmux attach -t <name>

# Detach from current session (inside tmux)
# prefix + d  (prefix is Ctrl+Space)

# Kill a session
tmux kill-session -t <name>

# Switch between sessions (inside tmux)
# prefix + s  — interactive session picker
```

### Session Persistence with Resurrect & Continuum

[tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) saves and
restores tmux sessions (windows, panes, layouts, and working directories) across
system restarts. [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum)
automates this by saving in the background and restoring on tmux server start.

Current config (`~/.config/tmux/tmux.conf`):
```
set -g @continuum-restore 'on'              # Auto-restore last saved session on tmux start
set -g @resurrect-capture-pane-contents 'on' # Save pane contents (scrollback)
set -g @resurrect-processes 'lazygit opencode lazydocker'  # Restore these running processes
```

**Manual save/restore (Resurrect):**
| Action  | Keybinding           |
|---------|----------------------|
| Save    | `prefix + Ctrl+s`    |
| Restore | `prefix + Ctrl+r`    |

**How Continuum works:**
- Automatically saves sessions every 15 minutes in the background.
- When `@continuum-restore` is `on`, the last saved session is automatically
  restored when the tmux server starts (e.g. after a reboot).
- No manual intervention needed — just start tmux and your sessions come back.

**Saved session files** are stored in `~/.tmux/resurrect/`.
