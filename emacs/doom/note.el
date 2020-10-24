(after! deft
  (setq deft-recursive t)
  (setq deft-use-filter-string-for-filename t)
  (setq deft-directory "~/org"))

(after! org-journal
  (setq org-journal-date-prefix "#+TITLE: ")
  (setq org-journal-file-format "%Y-%m-%d.org")
  (setq org-journal-date-format "%A, %d %B %Y")
  (setq org-journal-enable-agenda-integration t))

(after! org-roam
  (setq org-roam-tag-sources '(prop last-directory))
  (setq org-roam-capture-templates
        '(("d" "default" plain (function org-roam--capture-get-point)
           "%?"
           :file-name "${slug}"
           :head "#+title: ${title}\n#+roam_alias:\n"
           :unnarrowed t))))
