# Restoring Clear Screen (C-l)
bind-key C-l send-keys 'C-l'

# Reload configuration.
bind-key -T prefix r \
	source-file ~/.tmux.conf \; \
	display-message ' (!) ~/.tmux.conf reloaded.'

# Select
bind-key -T copy-mode-vi v send-keys -X begin-selection
bind-key -T copy-mode-vi V send-keys -X select-line
bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle

# switch between last windows
bind -n 'C-]' "select-window -l"

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

# Kill panes.
bind-key -T prefix X confirm-before -p "kill-pane #P? (y/n)" kill-pane

# Kill windows
bind-key -T prefix X confirm-before -p "kill-window #W? (y/n)" kill-window

