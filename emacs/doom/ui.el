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

;; startup maximized
;; toggle-frame-maximized in EMP seems does not respect
;; frame-resize-pixelwise, so don't use it.
(when (eq (window-system) 'mac)
  (add-to-list 'initial-frame-alist '(fullscreen . maximized)))

;; doom default to be 'character, but it's ugly for selections
;; but 'column does not work in terminal Emacs
(when (window-system)
  (setq highlight-indent-guides-method 'column))

(after! centaur-tabs
  (unless (window-system)
    (setq centaur-tabs-set-bar nil)))
