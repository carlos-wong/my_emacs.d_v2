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


(if (eq system-type 'gnu/linux)
  (setq org-agenda-files (file-expand-wildcards
                          "/mnt/hgfs/Document/journal/*.org"))
  )

(if (eq system-type 'darwin)
  (setq org-agenda-files (file-expand-wildcards
                          "/Users/carlos/Documents/journal/*.org"))
  )

(setq compilation-scroll-output t)
(global-set-key [C-tab] 'other-window);;切换到另一个窗口

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

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))

(set-language-environment "utf-8")


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
(setq org-todo-keywords
      '((sequence "TODO(t)" "WORKING(w)" "WAITING(a)" "HOLD(h)" "|" "DONE(d)")
        ))

(setq org-tag-alist '(("@work" . ?w) ("@home" . ?h)))

;; smart pairing for all
(electric-pair-mode t)

(fset 'yes-or-no-p 'y-or-n-p) ; 将yes/no替换为y/n

(setq ag-highlight-search t)
(setq ag-highlight-search t)
(setq ag-reuse-buffers t)
(setq ag-reuse-window  t)
(global-set-key (kbd "C-x g") 'ag-regexp-project-at-point)


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


;; (desktop-save-mode 1)
