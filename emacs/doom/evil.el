(use-package! evil-textobj-column
  :config
  (define-key evil-inner-text-objects-map "c" 'evil-textobj-column-word)
  (define-key evil-outer-text-objects-map "c" 'evil-textobj-column-word)
  (define-key evil-inner-text-objects-map "C" 'evil-textobj-column-WORD)
  (define-key evil-outer-text-objects-map "C" 'evil-textobj-column-WORD))

(use-package! evil-textobj-syntax)

(use-package! evil-textobj-line)

(use-package! evil-textobj-entire
  :config
  (define-key evil-outer-text-objects-map
    evil-textobj-entire-key 'evil-entire-entire-buffer)
  (define-key evil-inner-text-objects-map
    evil-textobj-entire-key 'evil-entire-entire-buffer))

;;;###autoload
(defun replace-current-line ()
  "Replace the current line."
  (interactive)
  (kill-region (line-beginning-position) (line-end-position))
  (insert (string-trim (current-kill 1)))
  (indent-according-to-mode)
  (back-to-indentation))

(map! :nv "gl" #'replace-current-line)

(add-hook!
 'vterm-mode-hook
 ;; evil-collection for vterm overrided some keymaps defined by tmux-pane
 (evil-collection-define-key 'insert 'vterm-mode-map
   (kbd "C-c") 'vterm--self-insert
   (kbd "C-h") (lambda () (interactive) (tmux-pane--windmove
                                    "left"
                                    "tmux select-pane -L"))
   (kbd "C-j") (lambda () (interactive) (tmux-pane--windmove
                                    "down"
                                    "tmux select-pane -D"))
   (kbd "C-k") (lambda () (interactive) (tmux-pane--windmove
                                    "up"
                                    "tmux select-pane -U"))
   (kbd "C-l") (lambda () (interactive) (tmux-pane--windmove
                                    "right"
                                    "tmux select-pane -R")))
 ;; change keymap to toggle sending escape to vterm
 (evil-collection-define-key '(normal insert) 'vterm-mode-map
   (kbd "C-q") 'evil-collection-vterm-toggle-send-escape))

;; override 'C-]' defined in evil-motion-state-map
(define-key evil-motion-state-map "\C-]"
  (lambda () (interactive) (tmux-pane--windmove "last" "tmux select-pane -l")))
