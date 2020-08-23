;;; ~/conf/emacs/doom/term.el -*- lexical-binding: t; -*-
(after! (vterm evil-collection)
  (add-hook!
   'vterm-mode-hook
   ;; evil-collection for vterm overrided some keymaps defined by tmux-pane
   (evil-collection-define-key 'insert 'vterm-mode-map
     (kbd "C-h") (lambda () (interactive) (tmux-pane--windmove
                                      "left"
                                      "tmux select-pane -L"))
     (kbd "C-j") (lambda () (interactive) (tmux-pane--windmove
                                      "down"
                                      "tmux select-pane -D"))
     (kbd "C-k") (lambda () (interactive) (tmux-pane--windmove
                                      "up"
                                      "tmux select-pane -U"))
     (kbd "C-l") (lambda () (interactive) (tmux-pane--windmove
                                      "right"
                                      "tmux select-pane -R")))
   ;; change keymap to toggle sending escape to vterm
   (evil-collection-define-key '(normal insert) 'vterm-mode-map
     (kbd "C-c") 'vterm--self-insert
     ;; for CLI emacs
     (kbd "ESC <escape>") 'forward-vterm-escape-to-emacs
     ;; for GUI emacs
     (kbd "M-<escape>") 'forward-vterm-escape-to-emacs)
   ;; send escape to vterm by default
   (evil-collection-vterm-toggle-send-escape)))

(defun forward-vterm-escape-to-emacs ()
  "Forward <escape> from vterm to emacs."
  (interactive)
  (evil-collection-vterm-toggle-send-escape)
  (execute-kbd-macro (kbd "<escape>"))
  (evil-collection-vterm-toggle-send-escape)
  (message "ESC sent to emacs!"))

(use-package! vtm)
