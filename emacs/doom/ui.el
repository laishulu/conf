;;; -*- lexical-binding: t -*-

;; soft wrap
(global-visual-line-mode)
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

;; doom default to be 'character, but it's ugly for selections
;; but 'column does not work in terminal Emacs
(add-hook (if (daemonp)
              'server-after-make-frame-hook
            'doom-load-theme-hook)
          (lambda() (when (display-graphic-p)
                 (setq highlight-indent-guides-method 'column))))
