;; -*- no-byte-compile: t; -*-
(package! evil-textobj-column)
(package! evil-textobj-line)
(package! evil-textobj-syntax)
(package! evil-textobj-entire)
(package! tmux-pane)
(package! smart-input-source)
(package! evil-pinyin :recipe
  (:host github :repo "laishulu/evil-pinyin"))
;; word around to the session restore issue
(package! treemacs-persp :disable t)
