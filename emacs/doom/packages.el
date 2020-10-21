;; -*- no-byte-compile: t; -*-
(package! evil-textobj-column)
(package! evil-textobj-line)
(package! evil-textobj-syntax)
(package! evil-textobj-entire)
(package! tmux-pane)
(package! sis)
(package! evil-pinyin)
(package! term-cursor :recipe
  (:host github :repo "h0d/term-cursor.el"))
(package! vtm :recipe
  (:host github :repo "laishulu/emacs-vterm-manager"))
;; word around to the session restore issue
(package! treemacs-persp :disable t)

(package! command-log-mode)

