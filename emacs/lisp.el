;lisp.el
;The author disclaims copyright to this source code. It is placed in
;the public domain.

(defun lisp-style-indent-setup ()
  (setq lisp-indent-offset 2)) ;; 2 spaces to indent
(add-hook 'scheme-mode-hook 'lisp-style-indent-setup)
(add-hook 'lisp-mode-hook 'lisp-style-indent-setup)
(add-hook 'emacs-lisp-mode-hook 'lisp-style-indent-setup)
