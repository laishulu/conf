(setq org-confirm-babel-evaluate t)
(setq org-babel-no-eval-on-ctrl-c-ctrl-c t)

(defun cm/deft-parse-title (file contents)
  "Parse the given FILE and CONTENTS and determine the title.
  If `deft-use-filename-as-title' is nil, the title is taken to
  be the first non-empty line of the FILE.  Else the base name of the FILE is
  used as title."
  (let ((begin (string-match "^#\\+[tT][iI][tT][lL][eE]: .*$" contents)))
    (if begin
        (string-trim
         (substring contents begin (match-end 0))
         "#\\+[tT][iI][tT][lL][eE]: *" "[\n\t ]+")
      (deft-base-filename file))))

(advice-add 'deft-parse-title :override #'cm/deft-parse-title)

(after! (deft org-roam)
  (setq deft-recursive t)
  (setq deft-use-filter-string-for-filename t)
  (setq deft-strip-summary-regexp
        (concat "\\("
                "[\n\t]" ;; blank
                "\\|^#\\+[[:alpha:]_]+:.*$" ;; org-mode metadata
                "\\|^:PROPERTIES:\n\\(.+\n\\)+:END:\n"
                "\\)"))
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
