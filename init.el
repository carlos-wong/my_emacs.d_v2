(add-to-list 'load-path "~/.emacs.d")
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("elpa" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))


(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))


(global-set-key "\C-x\m" 'smex)
;(setq mac-option-key-is-meta nil)
;(setq mac-option-modifier nil)
;(setq mac-command-key-is-meta t)
;(setq mac-command-modifier 'meta)

(load-theme 'solarized-dark t)

(setq make-backup-files nil) ; stop creating those backup~ files 
(setq auto-save-default nil) ; stop creating those #auto-save# files
(set-default-font "-adobe-Source Code Pro-semibold-normal-normal-*-15-*-*-*-m-0-iso10646-1")
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

(show-paren-mode 1)
(dolist (mode '(menu-bar-mode tool-bar-mode scroll-bar-mode))
    (when (fboundp mode) (funcall mode -1)))

(maximize-frame)
(smex-initialize)
(ido-mode t)
(setq ido-enable-flex-matching t)
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
