#!/usr/bin/env bash
#
# Installs the zsh, tmux and nvim configs from this dotfiles repo.
#
#   * zsh:     writes ~/.zshrc, ~/.zsh_aliases, ~/.zprofile as thin wrappers
#              that `source` the repo files, preserving any machine-specific
#              lines that were already in them.
#   * tmux:    writes ~/.tmux.conf as a wrapper, installs tpm + plugins and
#              copies bin/tmux-sessionizer to ~/.local/bin.
#   * nvim:    symlinks ~/.config/nvim to the repo nvim/ dir.
#
# Also installs dependencies: oh-my-zsh, zsh-autosuggestions, lazy.nvim.
# Idempotent - safe to re-run. Existing files are backed up to
# ~/.dotfiles-backup-<timestamp>.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

info() { printf '\033[1;34m[*]\033[0m %s\n' "$*"; }
ok()   { printf '\033[1;32m[+]\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m[!]\033[0m %s\n' "$*"; }
die()  { printf '\033[1;31m[x]\033[0m %s\n' "$*" >&2; exit 1; }
has()  { command -v "$1" >/dev/null 2>&1; }

[[ -f "$REPO_DIR/zshrc" ]]      || die "repo config 'zshrc' not found next to script"
[[ -f "$REPO_DIR/tmux.conf" ]]  || die "repo config 'tmux.conf' not found next to script"
[[ -d "$REPO_DIR/nvim" ]]       || die "repo config dir 'nvim' not found next to script"

# Strip previously-generated wrapper lines and repo `source` lines from a file,
# leaving only machine-specific additions.
strip_repo_lines() {
    grep -vE '^[[:space:]]*#[[:space:]]*Managed by ' "$1" 2>/dev/null |
        grep -vE "^[[:space:]]*(source|source-file|\.)[[:space:]]+[^#]*dotfiles/(zshrc|zsh_aliases|zprofile|tmux\.conf)[[:space:]]*[\"']?[[:space:]]*(#.*)?$" \
        || true
}

# write_wrapper <target> <repo_file> <command>
#   <command> is 'source' for zsh or 'source-file' for tmux
write_wrapper() {
    local target="$1" repo_file="$2" cmd="$3"
    local extras="" managed=""

    if [[ -e "$target" || -L "$target" ]]; then
        mkdir -p "$BACKUP_DIR"
        cp -a "$target" "$BACKUP_DIR/" 2>/dev/null || true
        if grep -qE "dotfiles/(zshrc|zsh_aliases|zprofile|tmux\.conf)" "$target" 2>/dev/null; then
            managed=1
        fi
    fi

    if [[ -n "$managed" ]]; then
        extras="$(strip_repo_lines "$target")"
    elif [[ -e "$target" || -L "$target" ]]; then
        warn "existing $target did not reference this repo; backed up, replacing with clean wrapper"
    fi

    {
        printf '# Managed by %s - do not edit\n' "$(basename "$0")"
        printf '%s "%s"\n' "$cmd" "$REPO_DIR/$repo_file"
        if [[ -n "$extras" ]]; then
            printf '\n# Machine-specific additions (preserved)\n%s\n' "$extras"
        fi
    } > "$target"

    ok "$target -> $REPO_DIR/$repo_file"
}

install_nvim() {
    local target="$HOME/.config/nvim"

    mkdir -p "$(dirname "$target")"
    if [[ -L "$target" ]] && [[ "$(readlink -f "$target")" == "$(readlink -f "$REPO_DIR/nvim")" ]]; then
        ok "$target already linked to repo"
        return
    fi

    if [[ -e "$target" || -L "$target" ]]; then
        mkdir -p "$BACKUP_DIR"
        mv "$target" "$BACKUP_DIR/nvim"
        warn "existing $target moved to $BACKUP_DIR/nvim"
    fi

    ln -s "$REPO_DIR/nvim" "$target"
    ok "$target -> $REPO_DIR/nvim"
}

install_deps() {
    if ! has git; then
        warn "git not found - skipping dependency installation"
        return
    fi

    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        info "installing oh-my-zsh"
        git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
    else
        ok "oh-my-zsh already installed"
    fi

    mkdir -p "$HOME/.oh-my-zsh/custom/plugins"
    if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]]; then
        info "installing zsh-autosuggestions"
        git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
            "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
    else
        ok "zsh-autosuggestions already installed"
    fi

    if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
        info "installing tpm"
        git clone --depth=1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    else
        ok "tpm already installed"
    fi

    if [[ ! -d "$HOME/.config/tmux/plugins/catppuccin" ]]; then
        info "installing catppuccin tmux theme"
        git clone --depth=1 https://github.com/catppuccin/tmux.git \
            "$HOME/.config/tmux/plugins/catppuccin"
    else
        ok "catppuccin tmux theme already installed"
    fi

    mkdir -p "$HOME/.local/bin"
    if [[ -f "$REPO_DIR/bin/tmux-sessionizer" ]]; then
        cp "$REPO_DIR/bin/tmux-sessionizer" "$HOME/.local/bin/tmux-sessionizer"
        chmod +x "$HOME/.local/bin/tmux-sessionizer"
        ok "installed tmux-sessionizer to ~/.local/bin"
    fi

    if [[ -d "$HOME/.tmux/plugins/tpm" ]] && has tmux; then
        info "installing tmux plugins via tpm"
        "$HOME/.tmux/plugins/tpm/bin/install_plugins" || warn "tpm reported errors installing plugins"
    fi

    mkdir -p "$HOME/.local/share/nvim/lazy"
    if [[ ! -d "$HOME/.local/share/nvim/lazy/lazy.nvim" ]]; then
        info "pre-installing lazy.nvim"
        git clone --depth=1 --filter=blob:none --branch=stable \
            https://github.com/folke/lazy.nvim.git "$HOME/.local/share/nvim/lazy/lazy.nvim"
    else
        ok "lazy.nvim already installed"
    fi
}

main() {
    info "installing dotfiles from $REPO_DIR"

    write_wrapper "$HOME/.zshrc"        zshrc       source
    write_wrapper "$HOME/.zsh_aliases"  zsh_aliases source
    write_wrapper "$HOME/.zprofile"     zprofile    source
    write_wrapper "$HOME/.tmux.conf"    tmux.conf   source-file

    install_nvim
    install_deps

    if [[ -d "$BACKUP_DIR" ]] && [[ -n "$(find "$BACKUP_DIR" -mindepth 1 2>/dev/null)" ]]; then
        info "previous files backed up to $BACKUP_DIR"
    elif [[ -d "$BACKUP_DIR" ]]; then
        rmdir "$BACKUP_DIR"
    fi

    if has zsh && [[ "${SHELL:-}" != *zsh ]]; then
        warn "zsh is not your default shell - set it with: chsh -s $(command -v zsh)"
    fi

    ok "done!"
    info "run 'exec zsh' to reload your shell"
    info "run 'nvim' once to let lazy.nvim install plugins"
    info "inside tmux, press C-a I to (re)install tmux plugins"
}

main "$@"
