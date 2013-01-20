(add-to-list 'load-path "~/.emacs.d")
(global-set-key[f5] 'compile)
(require 'xcscope)
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages '(starter-kit auto-complete )
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
(auto-image-file-mode)

(mouse-avoidance-mode 'animate)
;;;让 Emacs 可以直接打开和显示图片
; 
(fset 'yes-or-no-p 'y-or-n-p) ; 将yes/no替换为y/n
;; (global-linum-mode 1)
(cua-mode 1)
(setq frame-title-format "%f") ; 显示当前编辑的文档

(auto-image-file-mode)
;;;让 Emacs 可以直接打开和显示图片

(setq default-fill-column 80);默认显示 80列就换行
                                        ; 

(if (eq system-type 'gnu/linux)
  (setq initial-frame-alist '((top . 0) (left . 0) (width . 1000) (height . 1000)));;; full size window
  )

(if (eq system-type 'gnu/linux)
  (setq org-agenda-files (file-expand-wildcards
                          "/mnt/hgfs/Document/journal/*.org"))
  )

(if (eq system-type 'darwin)
  (setq org-agenda-files (file-expand-wildcards
                          "/Users/carlos/Documents/journal/*.org"))
  )

(defun insert-current_time ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d %H:%M:%S" (current-time))))


(global-set-key (kbd "C-x t") 'org-clock-in)
(global-set-key (kbd "C-x s") 'org-clock-out)

(setq compilation-scroll-output t)

(global-set-key [C-tab] 'other-window);;切换到另一个窗口，快捷键为
;;C+Tab


(global-set-key "%" 'match-paren)
(show-paren-mode t)          
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
	(t (self-insert-command (or arg 1)))))

;;以空行结束
(setq require-final-newline t)

;;代码折叠
(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'c++-mode-hook 'hs-minor-mode)  
(add-hook 'python-mode-hook 'hs-minor-mode)


(dolist (command '(yank yank-pop))
  (eval
   `(defadvice ,command (after indent-region activate)
      (and (not current-prefix-arg)
           (member major-mode
                   '(emacs-lisp-mode
                     lisp-mode
                     clojure-mode
                     scheme-mode
                     haskell-mode
                     ruby-mode
                     rspec-mode
                     python-mode
                     c-mode
                     c++-mode
                     objc-mode
                     latex-mode
                     js-mode
                     plain-tex-mode))
           (let ((mark-even-if-inactive transient-mark-mode))
             (indent-region (region-beginning) (region-end) nil))))))

(defun qiang-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
If no region is selected and current line is not blank and we are not at the end of the line,
then comment current line.
Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'qiang-comment-dwim-line)

(defun insert-current_time ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d %H:%M:%S" (current-time))))


(global-set-key (kbd "C-x g") 'grep)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;(require 'org-agenda)
;; 
;; (setq org-agenda-files (list "/User/carlos/Document/journal/index.org"
;;                              "/User/carlos/Document/journal/project.org"
;; ))
;; (setq org-agenda-files (list "~/Documents/journal/project.org"
;;                              "~/Documents/journal/index.org"))
;(setq org-agenda-files (list "~/Documents/journal/*.org"))

;; (setq org-agenda-files (list "~/Document/journal"))

;; (setq org-directory "/User/carlos/Document/journal")

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
(setq global-auto-complete-mode t)

(setq *is-a-mac* (eq system-type 'darwin))

(defun string-rtrim (str)
  "Remove trailing white-space from a string."
  (replace-regexp-in-string "[ \t\n]*$" "" str))

(defun set-exec-path-from-shell-PATH ()
  (interactive)
  (let ((path-from-shell 
         (string-rtrim 
          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path 
          (split-string path-from-shell path-separator))))

(when (and *is-a-mac* window-system)
  (set-exec-path-from-shell-PATH))

;; (require 'color-theme)
;; (require 'color-theme-x)
;; (color-theme-dark-blue2) 

(set-language-environment "utf-8")
(set-default-font "-adobe-Source Code Pro-normal-normal-normal-*-15-*-*-*-m-0-iso10646-1")

(global-set-key (kbd "C-x C-s") 'magit-status)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (misterioso))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
