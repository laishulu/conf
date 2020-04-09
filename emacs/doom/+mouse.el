(xterm-mouse-mode 1)

(global-set-key (kbd "<mouse-4>") 'scroll-down-line)
(global-set-key (kbd "<mouse-5>") 'scroll-up-line)

;; <leader>a: switch to previous buffer
(map! :nv "gb" #'mode-line-other-buffer)
