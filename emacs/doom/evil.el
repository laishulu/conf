(after! evil:config
  (setq evil-kill-on-visual-paste nil))

(use-package! evil-pinyin
  :after (evil)
  :config
  (map! :leader
        (:prefix "t"
         :desc "pinyin search" :nv "p" #'evil-pinyin-mode)))

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
