;;(toggle-debug-on-error)
(load! "encoding")
(load! "ui")
(load! "mouse")
(load! "tmux")
(load! "edit")
(load! "tree")
(load! "evil")

(defun ke ()
  "kill-emacs"
  (interactive)
  (kill-emacs))

(when (file-exists-p "~/.site/init.el")
  (load-file "~/.site/init.el"))
