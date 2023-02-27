(after! (deft org-roam)
  (setq deft-recursive t)
  (setq deft-use-filter-string-for-filename t)
  (setq deft-directory org-roam-directory))

(after! org-journal
  (setq org-journal-date-prefix "#+TITLE: ")
  (setq org-journal-file-format "%Y-%m-%d.org")
  (setq org-journal-date-format "%A, %d %B %Y")
  (setq org-journal-enable-agenda-integration t))

(after! org-roam
  (setq +org-roam-auto-backlinks-buffer t)
  (setq org-roam-capture-templates
        '(("d" "default" plain "%?"
           :target (file+head "${slug}.org"
                              "#+title: ${title}\n")
           :unnarrowed t))))

;; lift frequent keymap for notes
(map! :leader
      :desc "Open deft" "d" (general-simulate-key "SPC n d")
      :desc "Org journal" "j" (general-simulate-key "SPC n j")
      :desc "Org roam" "r" (general-simulate-key "SPC n r"))
