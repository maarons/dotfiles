;cc.el
;The author disclaims copyright to this source code. It is placed in
;the public domain. In case this is not legally possible I grant anyone
;the right to use it for any purpose, without any conditions, unless
;such conditions are required by law.

;; If you want to edit indent features:
;; use C-c C-o command and then C-x Esc Esc to see line to paste

;; bsd style without arguments list aligned to parentheses
(c-add-style "custom-bsd"
  '("bsd"
     (c-offsets-alist .
       (
         (arglist-intro . ++)
         (arglist-cont-nonempty . ++)
         (arglist-close . ++)))
     )
  nil)

;; java style without arguments list aligned to parentheses
(c-add-style "custom-java"
  '("java"
     (c-offsets-alist .
       (
         (arglist-intro . ++)
         (arglist-cont-nonempty . ++)
         (arglist-close . ++)))
     )
  nil)

(defun c-setup ()
  (c-set-style "custom-bsd")
  (setq tab-width 4)
  (setq c-basic-offset 4))
(defun java-setup ()
  (c-set-style "custom-java")
  (setq tab-width 4)
  (setq c-basic-offset 4))
(defun linux-c-mode ()
  "C mode with adjusted defaults for use with the Linux kernel."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq tab-width 8)
  (setq indent-tabs-mode t)
  (setq c-basic-offset 8))

(add-hook 'c++-mode-hook 'c-setup)
(add-hook 'c-mode-hook 'c-setup)
(add-hook 'java-mode-hook 'java-setup)
