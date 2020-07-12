# Set prefix to ctrl+a
unbind-key C-a

# Set default prefix.
set-option -g prefix C-b

# Bind 'C-b C-b' to send 'C-b'.
bind-key -T prefix C-b send-prefix

set -g @themepack 'powerline/double/orange'
