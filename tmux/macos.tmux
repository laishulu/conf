# Set prefix to ctrl+a
unbind-key C-b

# Set default prefix.
set-option -g prefix C-a

# Bind 'C-a C-a' to send 'C-a'.
bind-key -T prefix C-a send-prefix

set -g @themepack 'powerline/default/gray'
