;sh.el
;The author disclaims copyright to this source code. It is placed in
;the public domain. In case this is not legally possible I grant anyone
;the right to use it for any purpose, without any conditions, unless
;such conditions are required by law.

;; Loads sh-mode-map definition.
(require 'sh-script)
(define-key sh-mode-map (kbd "TAB") 'tab-to-tab-stop)
