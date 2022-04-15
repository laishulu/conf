(setq confirm-kill-processes nil)

(after! company
  (setq company-idle-delay 0.5))

(use-package! sis
  ;; should after doom-theme, or cursor color will not be retained.
  :after (evil tmux-pane doom-theme)
  :config
  (delete "C-h" sis-prefix-override-keys)
  (sis-global-respect-mode t)
  (sis-global-inline-mode t)
  (sis-global-context-mode t)
  (sis-global-cursor-color-mode t))
