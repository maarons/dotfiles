;javascript.el
;The author disclaims copyright to this source code. It is placed in
;the public domain. In case this is not legally possible I grant anyone
;the right to use it for any purpose, without any conditions, unless
;such conditions are required by law.

(when (require 'js nil t)
  (setq js-indent-level 2)
  (add-hook 'js-mode-hook 'subword-mode)) ;camel case
