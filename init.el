(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/javadoc-lookup/")
;; (add-to-list 'load-path "/usr/share/emacs/site-lisp/w3m")
(global-set-key[f5] 'compile)
(require 'xcscope)
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages '(starter-kit markdown-mode)
  "A list of packages to ensure are installed at launch.")

;; (require 'w3m)
;; (setq w3m-default-display-inline-images t)
;; (setq w3m-use-cookies t)
(require 'org)
;; (setq ac-ignore-case 'smart)
;; Show 0.8 second later
;; (setq ac-auto-show-menu 0.8)
;; (setq ac-auto-start 4)

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


(setq org-log-done 'time)
(setq org-log-done 'note)

(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

(mouse-avoidance-mode 'animate)
;;;让 Emacs 可以直接打开和显示图片
; 
(fset 'yes-or-no-p 'y-or-n-p) ; 将yes/no替换为y/n
;; (global-linum-mode 1)
;; (cua-mode 1)
(setq frame-title-format "%f") ; 显示当前编辑的文档

(auto-image-file-mode)
;;;让 Emacs 可以直接打开和显示图片

;; (setq default-fill-column 70);默认显示 80列就换行

;; (if (eq system-type 'gnu/linux)
;;   (setq initial-frame-alist '((top . 0) (left . 0) (width . 1000) (height . 1000)));;; full size window
;;   )

(add-to-list 'load-path "~/.emacs.d/ibus-el-0.3.2")
(require 'ibus)
;; Turn on ibus-mode automatically after loading .emacs
(add-hook 'after-init-hook 'ibus-mode-on)
;; Use C-SPC for Set Mark command
(ibus-define-common-key ?\C-\s nil)
;; Use C-/ for Undo command
(ibus-define-common-key ?\C-/ nil)
(if (eq system-type 'gnu/linux)
(setq ibus-cursor-color '( "green" "limegreen" "red"))
)

(add-to-list 'load-path "~/.emacs.d/android-mode/")
(setq android-mode-sdk-dir "~/android_work/android-sdk-macosx")
(require 'android-mode)
(require 'java-mode-indent-annotations)

(setq java-mode-hook
      (function (lambda()
                  (java-mode-indent-annotations-setup))))



;; (add-hook 'android-mode-hook
;;           (lambda ()
;;             (define-key "\C-cp"
;;               'backward-paragraph)
;;             ))

(defun mp-display-message ()
  (interactive)
  ;;; Place your code below this line, but inside the bracket.
  (message "Start build and run")
  (android-ant-debug-install)
  (android-start-app)
  )

;; (define-key android-mode-map (kbd "<f4>") 'mp-display-message)
(define-key android-mode-map (kbd "<f4>") 'android-ant-debug-install)
(define-key android-mode-map (kbd "<f5>") 'android-start-app)



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


;; (global-set-key "%" 'match-paren)
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

;; (electric-pair-mode t)
;; (setq electric-pair-pairs '(
;;                             (?\" . ?\")
;;                             (?\{ . ?\})
;;                             (?\' . ?\')
;;                             (?\< . ?\>)
;;                             ) )


(defun insert-current_time ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d %H:%M:%S" (current-time))))

;; (global-set-key (kbd "C-x g") 'grep)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))

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
;; (set-default-font "-adobe-Source Code Pro-semi-bold-normal-normal-*-12-*-*-*-m-0-iso10646-1")
;; -adobe-Source Code Pro-semi-bold-normal-normal-*-12-*-*-*-m-0-iso10646-1
(set-default-font "-adobe-Source Code Pro-semibold-normal-normal-*-15-*-*-*-m-0-iso10646-1")
;; (global-set-key (kbd "C-x C-s") 'magit-status)

(setq window-system-default-frame-alist
      '(
        ;; if frame created on x display
        (x
	 ;; face
	 (font . "-adobe-Source Code Pro-semibold-normal-normal-*-15-*-*-*-m-0-iso10646-1")
	 )

        )
      )


;; (global-set-key "\C-x\m" 'smex)
;; (global-set-key "\C-c\m" 'smex)

;; (global-set-key "\C-w" 'backward-kill-word)
;; (global-set-key "\C-x\C-k" 'kill-region)
;; (global-set-key "\C-c\C-k" 'kill-region)


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
    (let ((process (start-process-shell-command "sdcv" "*sdcv*" "sdcv" "-n --utf8-output" word)))
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


(if (eq system-type 'gnu/linux)
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "/mnt/hgfs/Document/journal/todo.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "/mnt/hgfs/Document/journal/journal.org")
         "* %?\nEntered on %U\n  %i\n %a")
        ("n" "Note" entry (file+headline "/mnt/hgfs/Document/journal/notes.org" "Notes")
         "* %U %?\n\n  %i" :prepend t :empty-lines 1)
        ))
)

(if (eq system-type 'darwin)
   (setq org-capture-templates
        '(("t" "Todo" entry (file+headline "/Users/carlos/Documents/journal/todo.org" "Tasks")
           "* TODO %?\n  %i\n  %a")
          ("j" "Journal" entry (file+datetree "/Users/carlos/Documents/journal/journal.org")
           "* %?\nEntered on %U\n  %i\n %a")
          ("n" "Note" entry (file+headline "/Users/carlos/Documents/journal/notes.org" "Notes")
           "* %U %?\n\n  %i" :prepend t :empty-lines 1)
          ))
)

(define-key global-map "\C-cc" 'org-capture)

;; (require 'fuzzy)
;; (turn-on-fuzzy-isearch)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(setq org-todo-keywords
      '((sequence "TODO(t)" "WORKING(w)" "WAITING(a)" "HOLD(h)" "|" "DONE(d)")
        ))

(setq org-tag-alist '(("@work" . ?w) ("@home" . ?h)))

;; store all backup and autosave files in the tmp dir
;; (setq backup-directory-alist
;;       `((".*" . ,temporary-file-directory)))
;; (setq auto-save-file-name-transforms
;;       `((".*" ,temporary-file-directory t)))

(setq make-backup-files nil) ; stop creating those backup~ files 
(setq auto-save-default nil) ; stop creating those #auto-save# files

;; (require 'real-auto-save)
;; (add-hook 'text-mode-hook 'turn-on-real-auto-save)
;; (add-hook 'muse-mode-hook 'turn-on-real-auto-save)
;; (add-hook 'c-mode-hook 'turn-on-real-auto-save)
;; (add-hook 'c++-mode-hook 'turn-on-real-auto-save)
;; (add-hook 'org-mode-hook 'turn-on-real-auto-save)
;; (add-hook 'emacs-lisp-mode-hook 'turn-on-real-auto-save)
;; ;; Auto save interval is 10 seconds by default. You can change it:
;; (setq real-auto-save-interval 5) ;; in seconds

(global-auto-revert-mode 1)

(setq-default abbrev-mode t)
(read-abbrev-file "~/.abbrev_defs")
(setq save-abbrevs t)

(setq-default indent-tabs-mode nil)   ;; don't use tabs to indent
;; (setq-default tab-width 2)            ;; but maintain correct
;; appearance


;; smart pairing for all
(electric-pair-mode t)

;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-exec "pymacs" nil t)
;; (autoload 'pymacs-load "pymacs" nil t)

;; (pymacs-load "ropemacs" "rope-")
;; (setq ropemacs-enable-autoimport t)

;; savehist keeps track of some history
(setq savehist-additional-variables
      ;; search entries
      '(search ring regexp-search-ring)
      ;; save every hour
      ;; savehist-autosave-interval 600
      ;; keep the home clean
      savehist-file (expand-file-name "savehist" "~/.emacs.d/"))
(savehist-mode t)


;; show-paren-mode: subtle highlighting of matching parens (global-mode)
(show-paren-mode +1)
(setq show-paren-style 'parenthesis)

;; highlight the current line
(global-hl-line-mode nil)


;; ido-mode
(ido-mode t)
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-max-prospects 10
      ido-save-directory-list-file (expand-file-name "ido.hist" "~/")
      ido-default-file-method 'selected-window)

;; auto-completion in minibuffer
(icomplete-mode 99)
(set-default 'imenu-auto-rescan t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes (quote ("4c8f0d2ccaced4349d7ef6d5c17f77cf97655a6f247bf1edf00699b235dea964" default)))
 '(midnight-mode t nil (midnight))
 '(org-startup-truncated nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(setq org-clock-idle-time nil)
(setq org-log-done 'time)
(defadvice org-clock-in (after wicked activate)
  "Mark WORKING when clocked in"
  (save-excursion
    (catch 'exit
      (org-back-to-heading t)
      (if (looking-at org-outline-regexp) (goto-char (1- (match-end 0))))
      (if (looking-at (concat " +" org-todo-regexp "\\( +\\|[ \t]*$\\)"))
          (org-todo "WORKING")))))


(add-hook 'org-clock-in-prepare-hook
          'my-org-mode-ask-effort)
(add-hook 'org-after-todo-state-change-hook
          'my-org-mode-ask-effort)

(defun my-org-mode-ask-effort ()
  "Ask for an effort"
  (unless (org-entry-get (point) "Effort")
    (let ((effort
           (completing-read
            "Effort: "
            (org-entry-get-multivalued-property (point) "Effort"))))
      (unless (equal effort "")
        (org-set-property "Effort" effort)))))


(setq org-agenda-span 7)
(setq org-agenda-show-log t)
(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-time-grid
      '((daily today require-timed)
        "----------------"
        (800 1000 1200 1400 1600 1800)))
(setq org-columns-default-format "%50ITEM %12SCHEDULED %TODO %3PRIORITY %Effort{:} %TAGS")
(org-agenda-list)
(delete-other-windows)
(add-to-list 'load-path "~/.emacs.d/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)

(global-set-key "\M-/" 'auto-complete)
(setq ac-ignore-case 'smart)
(set-face-background 'ac-candidate-face "lightgray")
(set-face-underline 'ac-candidate-face "darkgray")
(set-face-background 'ac-selection-face "steelblue")
(ac-flyspell-workaround)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; (require 'zone)
;; (zone-when-idle 120)
(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.

This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(set-exec-path-from-shell-PATH)
(require 'ag)
(setq ag-highlight-search t)


(add-hook 'c-mode-common-hook
(lambda()
  (local-set-key (kbd "C-c f") 'hs-show-block)
  (local-set-key (kbd "C-c b")  'hs-hide-block)
  (local-set-key (kbd "C-c p")    'hs-hide-all)
  (local-set-key (kbd "C-c n")  'hs-show-all)
  (hs-minor-mode t)))

  
(defun linux-c-mode ()
  "C mode with adjusted defaults for use with the Linux kernel."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq tab-width 8)
  (setq indent-tabs-mode t)
  (setq c-basic-offset 8))

(add-to-list 'auto-mode-alist '("\\.c\\'" . linux-c-mode))
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . linux-c-mode))

(require 'recent-jump)
(recent-jump-mode)
(global-set-key "\C-x\[" 'recent-jump-backward)
(global-set-key "\C-x\]" 'recent-jump-forward)

(require 'textmate)
(textmate-mode)

(global-set-key "\C-css" 'cscope-find-this-symbol)
(global-set-key "\C-csd" 'cscope-find-global-definition)
(global-set-key "\C-csg" 'cscope-find-global-definition)
(global-set-key "\C-csc" 'cscope-find-functions-calling-this-function)
(global-set-key "\C-csC" 'cscope-find-called-functions)

(global-set-key "\C-ctf" 'textmate-goto-file)
(global-set-key "\C-cts" 'textmate-goto-symbol)



(if (eq system-type 'darwin)
    (maximize-frame)
  )

;; python
;; (require 'tramp)
;; (require 'ipython)
;; (require 'python-pep8)
;; (require 'python-pylint)

(require 'javadoc-lookup)
(require 'java-import)

(global-set-key (kbd "C-h j") 'javadoc-lookup)
(javadoc-add-roots "/Users/carlos/android_work/android-sdk-macosx/docs")

(add-to-list 'load-path "/.emacs.d/ag.el") ;; optional
(require 'ag)
(setq ag-highlight-search t)
;; (global-set-key (kbd "<f5>") 'ag-project-at-point)
(global-set-key (kbd "C-x g") 'ag-regexp-project-at-point)
