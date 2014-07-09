;html.el
;The author disclaims copyright to this source code. It is placed in
;the public domain. In case this is not legally possible I grant anyone
;the right to use it for any purpose, without any conditions, unless
;such conditions are required by law.

;; Loads html-mode-map definition.
(require 'sgml-mode)
(define-key html-mode-map (kbd "TAB") 'tab-to-tab-stop)

(add-hook 'html-mode-hook (lambda () (set-tab-stop-width 2)))
