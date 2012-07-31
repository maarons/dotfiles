;html.el
;The author disclaims copyright to this source code. It is placed in
;the public domain. In case this is not legally possible I grant anyone
;the right to use it for any purpose, without any conditions, unless
;such conditions are required by law.

(add-hook 'html-mode-hook
  '(lambda()
     (setq truncate-lines t))) ;; don't wrap long lines

(defun hamlet-setup ()
  "Enable some stuff useful for hamlet files."
  (longlines-mode)
  (longlines-show-hard-newlines)
  (flyspell-mode)
  (ispell-change-dictionary "en_GB")
  (flyspell-buffer))
