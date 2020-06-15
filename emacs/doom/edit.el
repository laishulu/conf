(use-package! company
  :config
  (setq company-idle-delay 0.5))

(use-package! aggressive-indent
  :config
  (global-aggressive-indent-mode))

(use-package! evil-find-char-pinyin
  :config
  (evil-find-char-pinyin-mode 1)
  (evil-find-char-pinyin-toggle-snipe-integration t))

(use-package! smart-input-source
  :config
  (smart-input-source-global-auto-english-mode t)
  (add-hook! '(text-mode-hook prog-mode-hook)
             #'smart-input-source-inline-english-mode)
  (add-hook! '(text-mode-hook prog-mode-hook)
             #'smart-input-source-remember-input-source-mode)
  (add-hook! '(text-mode-hook prog-mode-hook)
             #'smart-input-source-follow-context-mode))
