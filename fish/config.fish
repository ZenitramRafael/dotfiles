# ~/dotfiles/fish/config.fish

# Only do interactive-only setup (prompt, abbreviations, bindings) when
# fish is actually being used as an interactive shell -- this file also
# gets sourced for non-interactive invocations (e.g. scp, some scripts).
if status is-interactive

    # ---- PATH ----
    # fish's own way to permanently extend PATH (writes to a universal
    # variable, unlike `export PATH=...` in bash). Homebrew lives in
    # different places on macOS (Apple Silicon) vs Linux/WSL2.
    if test -d /opt/homebrew/bin
        fish_add_path /opt/homebrew/bin
    else if test -d /home/linuxbrew/.linuxbrew/bin
        fish_add_path /home/linuxbrew/.linuxbrew/bin
    end

    # ---- Prompt ----
    # Python's own venv activation script prepends "(.venv)" to the prompt
    # by default. We show that via Starship's $python segment instead (see
    # starship.toml), so disable Python's built-in one to avoid showing it
    # twice in two different styles.
    set -gx VIRTUAL_ENV_DISABLE_PROMPT 1

    # Starship: cross-shell prompt, shows git branch/status, language
    # versions, etc. automatically based on directory context. Styled via
    # ~/.config/starship.toml (symlinked from dotfiles/fish/starship.toml)
    # to match the gruvbox palette used in nvim and tmux.
    if command -q starship
        starship init fish | source
    end

    # ---- Syntax highlighting colors ----
    # Colors fish uses live, as you type a command -- also gruvbox-dark, so
    # the terminal reads consistently with nvim/tmux.
    set -g fish_color_normal ebdbb2
    set -g fish_color_command 8ec07c --bold
    set -g fish_color_keyword fb4934
    set -g fish_color_quote b8bb26
    set -g fish_color_redirection fabd2f
    set -g fish_color_end fe8019
    set -g fish_color_error fb4934 --bold
    set -g fish_color_param 83a598
    set -g fish_color_comment 928374
    set -g fish_color_selection --background=3c3836
    set -g fish_color_search_match --background=3c3836
    set -g fish_color_autosuggestion 665c54

    # ---- Key bindings ----
    # Modal (normal/insert) editing on the command line, matching nvim
    # muscle memory. Comment this out if you'd rather keep fish's default
    # emacs-style bindings (e.g. Ctrl-a/Ctrl-e to jump to line start/end).
    fish_vi_key_bindings

    # ---- Abbreviations ----
    # Unlike `alias`, these expand inline in the command buffer when you
    # hit space/enter -- your history shows the real command, not the
    # shorthand. Edit the buffer before running to see this happen live.
    abbr -a gs  git status
    abbr -a ga  git add
    abbr -a gc  git commit
    abbr -a gco git checkout
    abbr -a gd  git diff
    abbr -a gp  git push
    abbr -a gl  git pull
    abbr -a lg  lazygit

    abbr -a dc  docker compose
    abbr -a dcu docker compose up
    abbr -a dcd docker compose down
    abbr -a dcl docker compose logs -f

end
