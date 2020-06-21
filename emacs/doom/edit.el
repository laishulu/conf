(use-package! company
  :config
  (setq company-idle-delay 0.5))

(use-package! smart-input-source
  :after (evil)
  :config
  (smart-input-source-global-respect-mode t)
  (smart-input-source-global-inline-english-mode t)
  (smart-input-source-global-follow-context-mode t)
  (defvar original-cursor-background nil)
  (add-hook 'smart-input-source-set-english-hook
            (lambda ()
              (when original-cursor-background
                (set-face-background 'cursor original-cursor-background))))
  (add-hook 'smart-input-source-set-other-hook
            (lambda ()
              (unless original-cursor-background
                (setq original-cursor-background (face-background 'cursor)))
              (set-face-background 'cursor "orange"))))
