;;; -*- lexical-binding: t -*-

;; soft wrap
(global-visual-line-mode)
(blink-cursor-mode)
(global-term-cursor-mode)
(setq-default fill-column 80)
(add-hook! 'text-mode-hook 'auto-fill-mode)

(setq doom-theme 'doom-one)

;; DON'T use (`font-family-list'), it's unreliable on Linux
(when (find-font (font-spec :name "Sarasa Mono SC Nerd"))
  (setq doom-font (font-spec :family "Sarasa Mono SC Nerd" :size 16)
        doom-variable-pitch-font (font-spec :family "Sarasa Mono SC Nerd")
        doom-unicode-font (font-spec :family "Sarasa Mono SC Nerd")
        doom-big-font (font-spec :family "Sarasa Mono SC Nerd" :size 20)))

(set-display-table-slot standard-display-table
                        'vertical-border
                        (make-glyph-code ?│))

;; highlight-indent-guides
(setq highlight-indent-guides-suppress-auto-error t)
