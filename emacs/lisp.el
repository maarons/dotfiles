;lisp.el
;The author disclaims copyright to this source code. It is placed in
;the public domain. In case this is not legally possible I grant anyone
;the right to use it for any purpose, without any conditions, unless
;such conditions are required by law.

(define-key emacs-lisp-mode-map (kbd "TAB") 'tab-to-tab-stop)
(define-key lisp-mode-map (kbd "TAB") 'tab-to-tab-stop)

(defun lisp-indent-setup () (set-tab-stop-width 2))
(add-hook 'scheme-mode-hook 'lisp-indent-setup)
(add-hook 'lisp-mode-hook 'lisp-indent-setup)
(add-hook 'emacs-lisp-mode-hook 'lisp-indent-setup)
