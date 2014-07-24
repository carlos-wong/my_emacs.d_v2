(add-to-list 'load-path "~/.emacs.d/thirdParty//emacs-google-this")
(add-to-list 'load-path "~/.emacs.d/thirdParty/powerline")
(add-to-list 'load-path "~/.emacs.d/thirdParty/")

;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/thirdParty/emacsxcode"))
;;(require 'xcode)

(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(setenv "PATH" (concat "/Users/carlos/Documents/gradle-1.9/bin:" (getenv "PATH")))
;(setenv "PATH" (concat "/Users/carlos/android_work/android-ndk-r8e:" (getenv "PATH")))
;(setenv "PATH" (concat "/opt/local/bin/:" (getenv "PATH")));

;;tips
;;如何替换字符串 replace-string, query-replace, 当然也是可以使用正则表达式的只要命令改成类似 replace-regexp,regexp一般都是带正则表达的功能
;;关于多个窗口的使用。或者可以不作为多个窗口。可以将两个屏幕拼接成一个屏幕，然后分割成两个窗口
;;在多个文件中进行搜索替换
;; 如果是将emacs的配置文件迁移 到另外的机器上。需要在.emacs.d 下面执行一下 git submodule update --init 因为
					;align 可以用来将=号两边的变量对齐
					;align-regexp 可以设定用哪个符号来对齐
;; 如何在magit中实现超过窗口宽度换行？使用命令 toggle-truncate-lines
;;list-matching-lines 可以搜索当前文件中的内容并且单独输出到一个 buffer 中，如果想在 buffer 中直接跳转。只要用 next-error-follow-minor-mode 模式即可。可以通过快捷键 C-c C-f 打开
;;通过 new-frame建立的frame如何被关闭，使用命令 delete-frame
;;scroll-all-mode 打开之后能够同时滚动多个窗口，如果阅读两个文件的话可以通过这个功能同时滚动两个文件的内容


(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)


(require 'cl)

(require 'package)
 (add-to-list 'package-archives
              '("marmalade" . "http://marmalade-repo.org/packages/") t)
 (add-to-list 'package-archives
 	     '("elpa" . "http://tromey.com/elpa/"))
 ;; (add-to-list 'package-archives
 ;; 	     '("gnu" .  "http://elpa.gnu.org/packages/"))
 (add-to-list 'package-archives
 	     '("melpa" . "http://melpa.milkbox.net/packages/") 	     t)
	     

;; (require 'package)
;;  (add-to-list 'package-archives
;; 	     '("melpa" . "http://melpa.milkbox.net/packages/") 	     t)
	     

(setq user-full-name "Carlos");;名字 
(setq user-mail-address "huaixian.huang@gmail.com");邮箱地址 
;; (defcustom ag-arguments
;;   (list "--smart-case" "-U" "--nogroup" "--column" "--")
;;   "Default arguments passed to ag."
;;   :type '(repeat (string))
;;   :group 'ag)



(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))


(defun require-package (p)
  (unless (package-installed-p p)
    (package-install p))
  (require p))

;;defun set-exec-path-from-shell-PATH ()
;; "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.
;;
;;his is particularly useful under Mac OSX, where GUI apps are not started from a shell."
;; (interactive)
;; (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
;;   (setenv "PATH" path-from-shell)
;;   (setq exec-path (split-string path-from-shell path-separator))))
;;
;;set-exec-path-from-shell-PATH)
;; (require-package 'maxframe)
(require-package 'auto-async-byte-compile)
(require-package 'auto-save-buffers-enhanced)
;; (require-package 'real-auto-save)
(require-package 'auto-complete)
(require-package 'markdown-mode)
(require-package 'fuzzy)
(require-package 'ag)
(require-package 'auto-indent-mode)
(require-package 'smex)
(require-package 'solarized-theme)
;;(require-package 'scheme-complete)
(require-package 'anything)
(require-package 'magit)
(require-package 'python-mode)
(require-package 'smartparens)
(require-package 'smartscan)

;; (require-package 'autopair)
(require-package 'textmate)
(require-package 'idle-highlight-mode)
(require-package 'yasnippet)
(require-package 'rainbow-mode)
(require-package 'ace-jump-mode)
;;(require-package 'helm)
;;(require-package 'ac-helm)
;;(require-package 'helm-ag)
;;(require-package 'helm-anything)


(require 'template)
(template-initialize)
;; 
(require 'xcscope)
;;;;(require 'yasnippe)
;; 
(yas-global-mode 1)
;; 
;; 
(setq-default inhibit-startup-screen t)
(setq-default initial-scratch-message nil)
;; 
;; 
(require 'auto-complete-config)

(add-to-list 'ac-dictionary-directories  "~/.emacs.d/elpa/auto-complete-20130724.1750/dict" )
(ac-config-default)
;;;; Show 0.8 second later
(setq ac-auto-show-menu 2)
(setq ac-auto-start t)
(set-face-background 'ac-candidate-face "lightgray")
(set-face-underline 'ac-candidate-face "darkgray")
(set-face-background 'ac-selection-face "steelblue")
(setq user-mail-addres "huaixian.huang@gmail.com")
;; 
;; 
(setq ac-use-menu-map t)
;; Default settings
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)
;;;; Ignore case if completion target string doesn't include upper characters
(setq ac-ignore-case 'smart)
;; 
(global-set-key "\C-x\m" 'smex)
(global-set-key [f5] 'recompile)
;;;(setq mac-option-key-is-meta nil)
;; 					;(setq mac-option-modifier nil)
;;;(setq mac-command-key-is-meta t)
;; 					;(setq mac-command-modifier 'meta)
;; 
(load-theme 'solarized-dark t)

;;;; (load-theme 'molokai t)
;;;; (load-theme 'cyberpunk t)
;; 
(setq make-backup-files nil) ; stop creating those backup~ files 
;; (setq auto-save-default nil) ; stop creating those #auto-save# files

;; 
(global-set-key (kbd "C-x C-b") 'ibuffer)
;; 
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)
;; 
(show-paren-mode 1)
;;;; (dolist (mode '(menu-bar-mode tool-bar-mode scroll-bar-mode))
;;;;     (when (fboundp mode) (funcall mode -1)))
;; 

(smex-initialize)
;; 
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode t)
;; 
;;(require 'uniquify)
;;(setq uniquify-buffer-name-style 'forward)
;; 
;; 
(if (eq system-type 'gnu/linux)
  (setq org-agenda-files (file-expand-wildcards
			   "/mnt/hgfs/Document/journal/*.org"))
  )
 
;; (if (eq system-type 'darwin)
    
;;     (setq org-agenda-files
;; 	  (file-expand-wildcards
;; 	   "~/Documents/DynamicScreen/*.org" "~/Documents/journal/*.org"
;; 	   )
;; 	  )
  


;;   )
 
(setq compilation-scroll-output t)
;; 
(global-set-key [C-tab] 'other-window);;切换到另一个窗口
;; 
(setq require-final-newline t)
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
;; 
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
;; (global-set-key "\M-;" 'qiang-comment-dwim-line)
(global-set-key (kbd "C-;") 'qiang-comment-dwim-line)
;; 
;; 
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
;; 
(set-language-environment "utf-8")
;; 
;; 
;;;; author: pluskid
;;;; 调用 stardict 的命令行程序 sdcv 来查辞典
;;;; 如果选中了 region 就查询 region 的内容，否则查询当前光标所在的单词
;;;; 查询结果在一个叫做 *sdcv* 的 buffer 里面显示出来，在这个 buffer 里面
;;;; 按 q 可以把这个 buffer 放到 buffer 列表末尾，按 d 可以查询单词
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
	 "* %?\nEntered on %U\n	 %i\n %a")
	("n" "Note" entry (file+headline "/mnt/hgfs/Document/journal/notes.org" "Notes")
	 "* %U %?\n\n  %i" :prepend t :empty-lines 1)
	))
)
 
(if (eq system-type 'darwin)
    (setq org-capture-templates
	  '(("p" "Todo in journal" entry (file+headline "/Users/carlos/Documents/journal/todo.org" "Inbox")
	     "* TODO %?\n  %i\n  %a" :clock-resume t)
	    ("l" "Todo of LedGO" entry (file+headline "/Users/carlos/Documents/DynamicScreen/todo.org" "Inbox")
	     "* TODO %?\n  %i\n  %a" :clock-resume t)

	    ("s" "smart home project" entry (file+datetree "/Users/carlos/Documents/journal/smarthome.org")
	     "* %?\n  %U\n  %i\n" :prepend t :empty-lines 1)
	    ("j" "Journal" entry (file+datetree "/Users/carlos/Documents/journal/journal.org")
	     "* %?\nEntered on %U\n  %i\n %a")
	    ("n" "Note" entry (file+headline "/Users/carlos/Documents/journal/notes.org" "Notes")
	     "* %U %?\n\n	 %i" :prepend t :empty-lines 1)
	    ("o" "gcw0 project" entry (file+headline "/Users/carlos/Documents/journal/gcw0_prj.org" "Gcw0_prj")
	     "* %U %?\n\n	 %i" :prepend t :empty-lines 1)
	    ))
  )
;; 
(define-key global-map "\C-cc" 'org-capture)
(setq org-todo-keywords
      '((sequence "TODO(t!)" "WORKING(w!)" "HOLD(h!)" "|" "DONE(d@/!)" )
	))
(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("WORKING" :foreground "blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
)))


(setq org-tag-alist '(
		      (:startgroup . nil)
		      ("工作" . ?w) ("工具" . ?t) ("其他" . ?o)
		      (:endgroup . nil)
		      (:startgroup . nil)
		      ("简单" . ?e) ("一般" . ?n) ("困难" . ?h)
		      (:endgroup . nil)
		      ("有趣" . ?f)
		      ("LedGo")
		      ("Emacs")
		      ("微信公众号")
		      ))    
;; 
;;;; smart pairing for all
;; (electric-pair-mode t)
;; 
(fset 'yes-or-no-p 'y-or-n-p) ; 将yes/no替换为y/n
;; 
(setq ag-highlight-search t)
(setq ag-reuse-buffers t)
;;;; (setq ag-reuse-window  t)
;; 
;; (add-hook 'ag-mode-hook 'next-error-follow-minor-mode) ;; 如果要在ag的结果中不跳转再次使用快捷键c-c c-f关闭或者打开该功能
;; 
(setq-default truncate-lines nil)
;;;; (setq toggle-truncate-lines nil)
;;;; (add-hook 'ag-mode-hook 'toggle-truncate-lines );; show magit lo
(add-hook 'magit-mode-hook 'toggle-truncate-lines );; show magit log long truncate

;;;; (add-hook 'org-mode-hook 'toggle-truncate-lines );; show magit log long truncate
;;;; (add-hook 'compilation-mode-hook 'toggle-truncate-lines)
;; 
;;;; (setq-default global-visual-line-mode nil)
;;;; (turn-on-visual-line-mode)
;; 
(global-set-key (kbd "C-x g") 'ag-regexp-project-at-point)
(global-set-key (kbd "C-j") 'delete-blank-lines)
;;;; (global-set-key (kbd "C-x g") 'ag-regexp)
;; 
(defun linux-c-mode ()
  "C mode with adjusted defaults for use with the Linux kernel."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq tab-width 8)
  (setq indent-tabs-mode t)
  (setq c-basic-offset 8))
 
;;;; (add-hook 'c-mode-common-hook 'google-set-c-style)
;; 
;;;; (add-hook 'c-mode-common-hook 'google-make-newline-indent)
;; 
;;;; (add-hook 'c-mode-common-hook 'linux-c-mode)
;;;; (add-to-list 'auto-mode-alist '("\\.c\\'" . linux-c-mode))
;;;; (add-to-list 'auto-mode-alist '("\\.cpp\\'" . linux-c-mode))
;; (add-to-list 'auto-mode-alist '("\.c$" . linux-c-mode))
;; (add-to-list 'auto-mode-alist '("\.cpp$" . linux-c-mode))
;; 
;; 
(require 'recent-jump)
(recent-jump-mode)
(global-set-key "\C-x\[" 'recent-jump-backward)
(global-set-key "\C-x\]" 'recent-jump-forward)
;; 
;; 
;; 
(desktop-save-mode t)
;; 
;; 
;; 
(mouse-avoidance-mode 'animate)
;; 
;; 
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mm\\'" . objc-mode))
;; 
;; 
(require 'google-this)
(google-this-mode 1)
;; 
(setq default-fill-column 70);默认显示 80列就换行
;; 
;; 
;; 
(global-set-key (kbd "RET") 'newline-and-indent)
;; 
;; 
;; (global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
(setq-default display-buffer-reuse-frames t)
(global-set-key "\M-;" 'auto-complete)
;; 
;; 
;; 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(desktop-restore-eager 20)
 '(ediff-split-window-function (quote split-window-horizontally))
 '(global-visual-line-mode nil)
 '(menu-bar-mode nil)
 '(org-agenda-files (quote ("~/Documents/journal/ideas.org" "~/Documents/mp3_hifi/data/mp3_hifi.org" "~/Documents/camera_remote_controler/data/camera_remote_controler.org" "~/Documents/DynamicScreen/LedGo.org" "~/Documents/journal/journal.org" "~/Documents/journal/todo.org")))
 '(scroll-bar-mode nil)
 '(textmate-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:foreground "#030303" :background "#bdbdbd" :box nil))))
 '(mode-line-inactive ((t (:foreground "#f9f9f9" :background "#666666" :box nil)))))
 
(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b"))))
 
(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))
;; 
;; 
;; 
;; 
;; 
;; 
(idle-highlight-mode 1)
(global-auto-revert-mode 1)
;; 
;; 
;;;; (auto-insert-mode)  ;;; Adds hook to find-files-hook
;;;; (setq auto-insert-directory "~/.emacs.d/mytemplate/") ;;; Or use custom, *NOTE* Trailing slash important
;;;; (setq auto-insert-query nil) ;;; If you don't want to be prompted before insertion
;; 
;;;; (setq auto-insert-alist
;;;;       (append '(
;;;; 		(python-mode . "Template.py")
;;;; 		(markdown-mode . "Template.md")
;; 		
;;;; 		)
;;;; 	      auto-insert-alist))
;; 
;;;;光标显示为一竖线
;;;; (setq-default cursor-type 'bar)
(setq ac-auto-show-menu 0.05)
;; 
(global-set-key (kbd "C-x t") 'org-clock-in)
(global-set-key (kbd "C-x s") 'org-clock-out)
;; 
;; 
(defun insert-time ()
  (interactive)
  (insert (format-time-string "%04Y-%02m-%02d %02H:%02M:%02S")))
;; 
;;;;(server-start) ;;如何在emacsclient编辑成功之后退出c-x #  ;;如何使用emacsclient来输入git的log , emacsclient  "$@" 不能使用 emacsclient  "$@" & 如果在后台运行那么git就不会等待emacs运行结束。
(rainbow-mode t)
(blink-cursor-mode 1)
;; 
;; (require 'powerline)
;; 
;; 
;; 
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; you can select the key you prefer to
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
 
;; (setq powerline-arrow-shape 'arrow14) ;; best for small fonts
;; (global-set-key "\C-c\C-o" 'other-frame)
 
(setq savehist-additional-variables
      ;; search entries
      '(search ring regexp-search-ring)
      ;; save every hour
      ;; savehist-autosave-interval 600
      ;; keep the home clean
      savehist-file (expand-file-name "savehist" "~/.emacs.d/"))
(savehist-mode t)
;; 
;;;; (split-window-right)
;; 
;; 
;; 
;; 

(set-default-font "-adobe-Source Code Pro-normal-normal-*-13-*-*-*-m-0-iso10646-1");
;;------------------------------------------------------------------------------------
;; 针对 Mac OSX 系统的特殊设置
;;------------------------------------------------------------------------------------
(when (eq system-type 'darwin)
  ;; disable 所有的斜体显示
  ;;  (set-face-italic-p 'italic nil))

  ;; mavericks 下默认的中文字体 Wawati SC 太有艺术感了，如果觉得小，
  ;; 可以从默认的 12 号字放大到 13 号 (point * 10)
  ;;  (set-face-attribute 'default nil :height 130)

  ;; 或者直接将默认的字体改为流行的、源自日本的 冬青黑 "Hiragino Sans GB"
  ;; 我更喜欢 mavericks 新加的 手札体 "Hannotate SC"
  (set-fontset-font
   (frame-parameter nil 'font)
   'han
   (font-spec :family "Hannotate SC" )))

;; (setq mac-option-key-is-meta nil)
;; (setq mac-command-key-is-meta t)
;; (setq mac-command-modifier 'meta)
;; (setq mac-option-modifier nil)

(global-smartscan-mode 1)

;; (auto-save-buffers-enhanced t)

(add-hook 'org-mode-hook 'turn-on-font-lock)

(add-hook 'org-mode-hook (lambda () (setq toggle-truncate-lines nil)))

(setq x-select-enable-clipboard t)

;关于在org-mode下如何自动换行,使用 refill-mode 并快捷键 M-q 来启动它。如果想暂停自动换行功能只需要refill-mode disable掉


(require 'gud)
(define-key gud-mode-map '[f9] 'gud-step)                    
(define-key gud-mode-map '[f10] 'gud-next)
(define-key gud-mode-map '[f5] 'gud-cont)
(define-key gud-mode-map '[f12] 'gud-break)
(define-key gud-mode-map '[f11] 'gud-remove)


(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
(global-set-key "\C-ca" 'org-agenda)


;; Compact the block agenda view
(setq org-agenda-compact-blocks t)
;; Separate drawers for clocking and logs
(setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
;; Save clock data and state changes and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
(setq org-log-into-drawer t)
;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)
;; Clock out when moving task to a done state
(setq org-clock-out-when-done t)

(add-hook 'org-clock-in-prepare-hook
          'sacha/org-mode-ask-effort)

;; (add-hook 'org-todo-statistics-hook
;; 	  'org-set-effort)


(defun sacha/org-clock-in-if-starting ()
  "Clock in when the task is marked WORKING."
  (when (and (string= state "WORKING")
             (not (string= last-state state)))
    (org-clock-in)))
(add-hook 'org-after-todo-state-change-hook
	  'sacha/org-clock-in-if-starting)
(defadvice org-clock-in (after sacha activate)
  "Set this task's status to 'WORKING'."
  (org-todo "WORKING"))

(defun sacha/org-clock-out-if-waiting ()
  "Clock out when the task is marked DONE."
  (when (and (string= state "DONE")
             (not (string= last-state state)))
    (org-clock-out)))
(add-hook 'org-after-todo-state-change-hook
	  'sacha/org-clock-out-if-waiting)

;; (add-hook 'org-after-todo-state-change-hook
;; 	  'sacha/org-mode-ask-effort)

(defun sacha/org-mode-ask-effort ()
  "Ask for an effort estimate when clocking in."
  (unless (org-entry-get (point) "Effort")
    (let ((effort
           (completing-read
            "Effort: "
            (org-entry-get-multivalued-property (point) "Effort"))))
      (unless (equal effort "")
        (org-set-property "Effort" effort)))))


(setq org-agenda-custom-commands
      '(("g" "LedGo Project Tasks"
	 (
	  (tags-todo "LedGo")
	  ))
	)
      )
;; Agenda clock report parameters
(setq org-agenda-clockreport-parameter-plist
      (quote (:link t :maxlevel 5 :fileskip0 t :compact t :narrow 80 :stepskip0 t)))
; Set default column view headings: Task Effort Clock_Summary
(setq org-columns-default-format "%80ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM")
(defvar bh/insert-inactive-timestamp t)

(defun bh/toggle-insert-inactive-timestamp ()
  (interactive)
  (setq bh/insert-inactive-timestamp (not bh/insert-inactive-timestamp))
  (message "Heading timestamps are %s" (if bh/insert-inactive-timestamp "ON" "OFF")))

(defun bh/insert-inactive-timestamp ()
  (interactive)
  (org-insert-time-stamp nil t t nil nil nil))

(defun bh/insert-heading-inactive-timestamp ()
  (save-excursion
    (when bh/insert-inactive-timestamp
      (org-return)
      (org-cycle)
      (bh/insert-inactive-timestamp))))

(add-hook 'org-insert-heading-hook 'bh/insert-heading-inactive-timestamp 'append)
;;make ret to follows link in org mode
(setq org-return-follows-link t)


;;codeing system
(setq org-export-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-charset-priority 'unicode)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))


