(use-package! company
  :config
  (setq company-idle-delay 0.5))

(use-package! smart-input-source
  :after (evil tmux-pane)
  :init
  :config
  (delete "C-h" smart-input-source-prefix-override-keys)
  (setq smart-input-source-preserve-save-triggers
        (append smart-input-source-preserve-save-triggers
                (list 'tmux-pane-omni-window-last
                      'tmux-pane-omni-window-up
                      'tmux-pane-omni-window-down
                      'tmux-pane-omni-window-left
                      'tmux-pane-omni-window-right)))
  (smart-input-source-global-respect-mode t)
  (smart-input-source-global-inline-english-mode t)
  (smart-input-source-global-follow-context-mode t)
  (smart-input-source-global-cursor-color-mode t))
