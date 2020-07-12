(use-package! company
  :config
  (setq company-idle-delay 0.5))

(use-package! smart-input-source
  :after (evil tmux-pane)
  :init
  :config
  (delete "C-h" smart-input-source-prefix-override-keys)
  (smart-input-source-global-respect-mode t)
  (smart-input-source-global-inline-mode t)
  (smart-input-source-global-follow-context-mode t)
  (smart-input-source-global-cursor-color-mode t))
