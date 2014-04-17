;text.el
;The author disclaims copyright to this source code. It is placed in
;the public domain. In case this is not legally possible I grant anyone
;the right to use it for any purpose, without any conditions, unless
;such conditions are required by law.

(define-key text-mode-map (kbd "TAB") 'tab-to-tab-stop)
(add-hook 'text-mode-hook '(lambda()
  (setq truncate-lines nil) ;; wrap long lines
  (set-tab-stop-width 4)))

(define-derived-mode git-commit-mode text-mode
  (setq mode-name  "git commit")
  (setq-default fill-column 72))

(add-to-list 'auto-mode-alist '("/COMMIT_EDITMSG\\'" . git-commit-mode))
