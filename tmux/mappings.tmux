# Restoring Clear Screen (C-l)
bind-key C-l send-keys 'C-l'

# Reload configuration.
bind-key -T prefix r \
	source-file ~/.tmux/tmux.conf \; \
	display-message ' (!) ~/.tmux/tmux.conf reloaded.'

# Select
bind-key -T copy-mode-vi v send-keys -X begin-selection
bind-key -T copy-mode-vi V send-keys -X select-line
bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle

# Smart pane switching with awareness of vim splits
is_vim_emacs='echo "#{pane_current_command}" | \
    grep -iqE "((^|\/)g?(view|n?vim?x?)(diff)?$)|emacs"'

# enable in root key table
bind -n C-h if-shell "$is_vim_emacs" "send-keys C-h" "select-pane -L"
bind -n C-j if-shell "$is_vim_emacs" "send-keys C-j" "select-pane -D"
bind -n C-k if-shell "$is_vim_emacs" "send-keys C-k" "select-pane -U"
bind -n C-l if-shell "$is_vim_emacs" "send-keys C-l" "select-pane -R"
bind -n "C-\\" if-shell "$is_vim_emacs" "send-keys C-\\" "select-pane -l"

# enable in copy mode key table
bind -Tcopy-mode-vi C-h if-shell "$is_vim_emacs" "send-keys C-h" "select-pane -L"
bind -Tcopy-mode-vi C-j if-shell "$is_vim_emacs" "send-keys C-j" "select-pane -D"
bind -Tcopy-mode-vi C-k if-shell "$is_vim_emacs" "send-keys C-k" "select-pane -U"
bind -Tcopy-mode-vi C-l if-shell "$is_vim_emacs" "send-keys C-l" "select-pane -R"
bind -Tcopy-mode-vi "C-\\" if-shell "$is_vim_emacs" "send-keys C-\\" "select-pane -l"

# vim's definition of a horizontal/vertical split is reversed from tmux's
bind s split-window -v
bind v split-window -h

# resize panes like vim

# when left border is splitter, move left the left border
# when left border is not splitter, move left the right border
bind -r < resize-pane -L 3
# when left border is splitter, move right the left border
# when left border is not splitter, move right the right border
bind -r > resize-pane -R 3
# when bottom border is splitter, move down the bottom border
# when bottom border is not splitter, move down the top border
bind -r + resize-pane -D 1
# when bottom border is splitter, move up the bottom border
# when bottom border is not splitter, move up the top border
bind -r _ resize-pane -U 1

# Kill panes without prompt.
bind-key -T prefix x kill-pane

# Kill windows without prompt.
bind-key -T prefix X kill-window
