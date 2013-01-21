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
(defvar my-packages '(starter-kit auto-complete org)
  "A list of packages to ensure are installed at launch.")

(setq ac-ignore-case 'smart)
;; Show 0.8 second later
(setq ac-auto-show-menu 0.8)
(setq ac-auto-start 4)

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

(setq default-fill-column 70);默认显示 80列就换行
(global-linum-mode t)

(if (eq system-type 'gnu/linux)
  (setq initial-frame-alist '((top . 0) (left . 0) (width . 1000) (height . 1000)));;; full size window
  )

(add-to-list 'load-path "~/.emacs.d/ibus-el-0.3.2")
(require 'ibus)
;; Turn on ibus-mode automatically after loading .emacs
(add-hook 'after-init-hook 'ibus-mode-on)
;; Use C-SPC for Set Mark command
(ibus-define-common-key ?\C-\s nil)
;; Use C-/ for Undo command
(ibus-define-common-key ?\C-/ nil)
(setq ibus-cursor-color '("red" "blue" "limegreen"))




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

;; (global-set-key (kbd "C-x C-s") 'magit-status)
(require 'org)

(global-set-key "\C-x\m" 'smex)
(global-set-key "\C-c\m" 'smex)

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)


;; (if (eq system-type 'gnu/linux)
;;     (setq org-default-notes-file "/tmp/.notes")
;;   )

;; author: pluskid
;; 调用 stardict 的命令行程序 sdcv 来查辞典
;; 如果选中了 region 就查询 region 的内容，否则查询当前光标所在的单词
;; 查询结果在一个叫做 *sdcv* 的 buffer 里面显示出来，在这个 buffer 里面
;; 按 q 可以把这个 buffer 放到 buffer 列表末尾，按 d 可以查询单词
(global-set-key (kbd "C-c d") 'kid-sdcv-to-buffer)
(defun kid-sdcv-to-buffer ()
  (interactive)
  (let ((word (if mark-active
                  (buffer-substring-no-properties (region-beginning) (region-end))
                (current-word nil t))))
    (setq word (read-string (format "Search the dictionary for (default %s): " word)
                            nil nil word))
    (set-buffer (get-buffer-create "*sdcv*"))
    (buffer-disable-undo)
    (erase-buffer)
    (let ((process (start-process-shell-command "sdcv" "*sdcv*" "sdcv" "-n" word)))
      (set-process-sentinel
       process
       (lambda (process signal)
         (when (memq (process-status process) '(exit signal))
           (unless (string= (buffer-name) "*sdcv*")
             (setq kid-sdcv-window-configuration (current-window-configuration))
             (switch-to-buffer-other-window "*sdcv*")
             (local-set-key (kbd "d") 'kid-sdcv-to-buffer)
             (local-set-key (kbd "q") (lambda ()
                                        (interactive)
                                        (bury-buffer)
                                        (unless (null (cdr (window-list))) ; only one window
                                          (delete-window)))))
           (goto-char (point-min))))))))




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (misterioso)))
)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
