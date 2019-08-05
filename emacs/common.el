;common.el
;The author disclaims copyright to this source code. It is placed in
;the public domain. In case this is not legally possible I grant anyone
;the right to use it for any purpose, without any conditions, unless
;such conditions are required by law.

;; Don't show welcome message
(setq inhibit-startup-message t)
;; Disable toolbar
(tool-bar-mode 0)
;; Disable menubar in cli
(unless window-system (menu-bar-mode 0))
;; Don't wrap long lines
(setq-default truncate-lines t)
;; Highlight matching parentheses
(show-paren-mode t)
;; No blinking cursor
(blink-cursor-mode nil)
;; Show line and column numbers
(line-number-mode t)
(column-number-mode t)
;; Put backups in one directory
(setq make-backup-files t)
(setq backup-directory-alist (quote ((".*" . "~/.emacs_tmp/"))))
;; Keep 3 latest backup files
(setq version-control t)
(setq kept-old-versions 0)
(setq kept-new-versions 3)
;; Don't ask before deleting excess backups
(setq delete-old-versions t)
;; Use spaces to indent by default
(setq-default indent-tabs-mode nil)
;; Set tab display to 8
(setq-default tab-width 8)
;; Tab stops for tab-to-tab-stop and M-i command
(defun set-tab-stop-width (width)
  ;; n = number
  (interactive "nSet tab stop width to: ")
  (setq tab-stop-list (number-sequence width 120 width)))
(set-tab-stop-width 4)
;; Keep indentation level on RET
(global-set-key (kbd "RET") 'newline-and-indent)
;; Default auto fill 80 columns
(setq-default fill-column 80)
;; Require new line at the end of file
(setq require-final-newline t)
;; Set text mode as default
(setq default-major-mode 'text-mode)
;; Set dark background color (requires color-theme package)
(when (require 'color-theme nil t)
  (color-theme-initialize)
  (color-theme-billw))
;; Choose better names for buffers, when editing files with the same names
(when (require 'uniquify nil t)
  (setq uniquify-buffer-name-style 'post-forward))
;; Set default font
(add-to-list 'default-frame-alist '(font . "Hack-12"))

(if (eq system-type 'darwin)
  ;; Swap command and option keys
  (setq mac-command-modifier 'meta))
