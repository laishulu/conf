(map! :leader
      (:prefix "t"
        :desc "tree"            :nv "t" #'treemacs))

(after! treemacs
  (add-to-list 'treemacs-pre-file-insert-predicates
               #'treemacs-is-file-git-ignored?)
  (setq treemacs-show-hidden-files nil
        treemacs-width 30))

(after! doom-themes
  (unless (display-graphic-p)
    (remove-hook 'doom-load-theme-hook #'doom-themes-treemacs-config)))
