;tex.el
;The author disclaims copyright to this source code. It is placed in
;the public domain. In case this is not legally possible I grant anyone
;the right to use it for any purpose, without any conditions, unless
;such conditions are required by law.

;; Mode for cross references
(when (require 'reftex nil t)
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex))
;; AUCTeX mode
(when (load "auctex.el" t t t)
  ;; Recomended commands
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  ;; 4 spaces for indent
  (setq LaTeX-indent-level 4)
  ;; auto-fill mode
  (add-hook 'LaTeX-mode-hook 'auto-fill-mode)
  (add-hook 'LaTeX-mode-hook 'flyspell-mode))
