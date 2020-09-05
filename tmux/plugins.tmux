# Persists tmux environment across system restarts.
# <prefix><Ctrl-s>: save
# <prefix><Ctrl-r>: restore
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @resurrect-processes ':all:'

# quick opening of a highlighted file or url
# In copy mode:
# o: "open" a highlighted selection with the system default program.
# Ctrl-o: open a highlighted selection with the $EDITOR
# Shift-s: search the highlighted selection directly inside a search engine
set -g @plugin 'tmux-plugins/tmux-open'

set -g @plugin 'NHDaly/tmux-better-mouse-mode'
set -g @scroll-without-changing-pane "on"
set -g @emulate-scroll-for-no-mouse-alternate-buffer "on"

# Search
#
#     prefix + / - regex search (strings work too)
#
# Example search entries:
#
#     foo - searches for string foo [0-9]+ - regex search for numbers
# Grep is used for searching.
# Searches are case insensitive.
# Predefined searches
#
#     prefix + ctrl-f - simple file search
#     prefix + ctrl-g - jumping over git status files (best used after git status command)
#     prefix + alt-h - jumping over SHA-1/SHA-256 hashes (best used after git log command)
#     prefix + ctrl-u - url search (http, ftp and git urls)
#     prefix + ctrl-d - number search (mnemonic d, as digit)
#     prefix + alt-i - ip address search
#
# These start "copycat mode" and jump to first match.
# "Copycat mode" bindings
#
# These are enabled when you search with copycat:
#
#     n - jumps to the next match
#     N - jumps to the previous match

set -g @plugin 'tmux-plugins/tmux-copycat'

# Copy to the system clipboard in tmux
set -g @plugin 'tmux-plugins/tmux-yank'

# highlights when you press tmux prefix key
set -g @plugin 'tmux-plugins/tmux-prefix-highlight'

# theme
set -g @plugin 'jimeh/tmux-themepack'

if-shell 'test "$(uname -s)" = Darwin' 'source ~/.config/tmux/conf/macos.tmux'
if-shell 'test "$(uname -s)" = Linux' 'source ~/.config/tmux/conf/linux.tmux'
if-shell "test -f ~/.site/tmux.conf" "source ~/.site/tmux.conf"

# tmux plugin manager, must be at the very bottom of tmux.conf
# don't use the -b flag, or it might encounter race problems
run '~/.tmux/plugins/tpm/tpm'
