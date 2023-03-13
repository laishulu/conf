;; disable META key sequence of interpreting ESC to META
(global-set-key [escape] 'keyboard-escape-quit)

(setq confirm-kill-processes nil)

(after! company
  (setq company-idle-delay 0.5))

(use-package! sis
  :after (evil tmux-pane)
  :config
  (delete "C-h" sis-prefix-override-keys)
  (sis-global-respect-mode t)
  (sis-global-inline-mode t)
  (sis-global-context-mode t)
  (sis-global-cursor-color-mode t))
