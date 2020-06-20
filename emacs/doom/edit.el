(use-package! company
  :config
  (setq company-idle-delay 0.5))

(use-package! smart-input-source
  :config
  (smart-input-source-global-respect-mode t)
  (smart-input-source-global-inline-english-mode t)
  (smart-input-source-global-follow-context-mode t))
