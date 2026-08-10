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
    # Starship: cross-shell prompt, shows git branch/status, language
    # versions, etc. automatically based on directory context.
    if command -q starship
        starship init fish | source
    end

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
