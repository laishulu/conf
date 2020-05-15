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
  (add-hook! '(text-mode-hook prog-mode-hook)
             #'smart-input-source-mode))
