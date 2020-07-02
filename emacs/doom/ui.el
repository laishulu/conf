;;; -*- lexical-binding: t -*-

;; soft wrap
(global-visual-line-mode)
(blink-cursor-mode)
(global-term-cursor-mode)
(setq-default fill-column 80)
(add-hook! 'text-mode-hook 'auto-fill-mode)

(setq doom-theme 'doom-monokai-pro)
(when (member "Sarasa Nerd" (font-family-list))
  (setq doom-font (font-spec :family "Sarasa Nerd" :size 16)
        doom-variable-pitch-font (font-spec :family "Sarasa Nerd")
        doom-unicode-font (font-spec :family "Sarasa Nerd")
        doom-big-font (font-spec :family "Sarasa Nerd" :size 20)))

(set-display-table-slot standard-display-table
                        'vertical-border
                        (make-glyph-code ?│))

;; highlight-indent-guides
(setq highlight-indent-guides-suppress-auto-error t)
