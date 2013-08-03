;;; PACKAGES
(require 'package)
;; Original Emacs package.
(setq package-archives
      (cons '("tromey" . "http://tromey.com/elpa/") package-archives))

;; Add the user-contributed repository
(add-to-list 'package-archives
         '("marmalade" . "http://marmalade-repo.org/packages/"))

;; Add the official GNU packages archives
(add-to-list 'package-archives
         '("gnu" . "http://elpa.gnu.org/packages/"))

;; Go for it
(package-initialize)


;;; GENERAL PURPOSE CONFIGURATION

;; Load stuff
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/major-modes")
(add-to-list 'load-path "~/.emacs.d/minor-modes")

;; Make Emacs default to UTF-8.
(set-language-environment "UTF-8")
;; Hide menubar, toolbar and scrollbar.
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;; Display the column number in the statusbar.
(column-number-mode t)
;; Hide the startup message.
(setq inhibit-startup-message t)
;; Make Emacs use spaces instead of tabs.
(setq-default indent-tabs-mode nil)
(setq tabs-with 4) ; Of course, 4 spaces by default.
;; Tabs are only useful for makefiles, so add a special rule for them.
(setq makefile-mode-hook
      (function (lambda ()
          (setq indent-tabs-mode t))))
;; Highlight tabs so I can spot them in other people's code.
;(highlight-tabs)
;; Also highlight trailing spaces because they are hideous.
(setq show-trailing-whitespace t)
;; Highlight the current line.
(global-hl-line-mode 1)

;; Backup management.
(setq make-backup-files t) ; Enable backup files.
(setq version-control t) ; Enable version controlling of the backup files.
(setq backup-directory-alist `((".*" . "~/.emacs_backups/"))) ; Where to store.
(setq backup-by-copying t)
(setq delete-old-versions t)
(setq kept-new-versions 6)
(setq kept-old-versions 2)
;; Auto-save.
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
;; Show a right margin.
(setq-default fill-column 80)
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)
;; Automatically wrap the line when arriving at the colomn limit.
(setq-default auto-fill-function 'do-auto-fill)
(setq comment-auto-fill-only-comments t)
;; Parents matching.
(setq show-paren-delay 0)
(setq shoz-pqren-style 'parenthesis)
(show-paren-mode t)
(add-hook 'after-change-major-mode-hook 'rainbow-delimiters-mode)

;; Yes and no are too tedious to type.
(fset 'yes-or-no-p 'y-or-n-p)
;; Display the time in 24 hours format in the bar.
(display-time)
(setq disaply-time-24h-format t)

;; Zoning. Because it is fun.
(require 'zone)
(setq zone-idle (* 60 3))
(zone-when-idle zone-idle)

;; Folding.
(load "folding" 'nomessage 'noerror)
(folding-mode-add-find-file-hook)
(folding-add-to-marks-list 'python-mode "{{{" "}}}" nil t)

;; Editing .emacs
(defun eemacs ()
  (interactive)
  (split-window-horizontally)
  (windmove-right)
  (find-file "~/.emacs"))


;;; PACKAGES
(require 'package)
;; Original Emacs package.
(setq package-archives
      (cons '("tromey" . "http://tromey.com/elpa/") package-archives))

;; Add the user-contributed repository
(add-to-list 'package-archives
         '("marmalade" . "http://marmalade-repo.org/packages/"))

;; Add the official GNU packages archives
(add-to-list 'package-archives
         '("gnu" . "http://elpa.gnu.org/packages/"))

;; Go for it
(package-initialize)


;;; GENERAL PURPOSE CONFIGURATION

;; Load stuff
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/major-modes")
(add-to-list 'load-path "~/.emacs.d/minor-modes")

;; Make Emacs default to UTF-8.
(set-language-environment "UTF-8")
;; Hide menubar, toolbar and scrollbar.
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;; Display the column number in the statusbar.
(column-number-mode t)
;; Hide the startup message.
(setq inhibit-startup-message t)
;; Make Emacs use spaces instead of tabs.
(setq-default indent-tabs-mode nil)
(setq tabs-with 4) ; Of course, 4 spaces by default.
;; Tabs are only useful for makefiles, so add a special rule for them.
(setq makefile-mode-hook
      (function (lambda ()
          (setq indent-tabs-mode t))))
;; Highlight tabs so I can spot them in other people's code.
;(highlight-tabs)
;; Also highlight trailing spaces because they are hideous.
(setq show-trailing-whitespace t)
;; Highlight the current line.
(global-hl-line-mode 1)

;; Backup management.
(setq make-backup-files t) ; Enable backup files.
(setq version-control t) ; Enable version controlling of the backup files.
(setq backup-directory-alist `((".*" . "~/.emacs_backups/"))) ; Where to store.
(setq backup-by-copying t)
(setq delete-old-versions t)
(setq kept-new-versions 6)
(setq kept-old-versions 2)
;; Auto-save.
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
;; Show a right margin.
(setq-default fill-column 80)
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)
;; Automatically wrap the line when arriving at the colomn limit.
(setq-default auto-fill-function 'do-auto-fill)
(setq comment-auto-fill-only-comments t)
;; Parents matching.
(setq show-paren-delay 0)
(setq shoz-pqren-style 'parenthesis)
(show-paren-mode t)
(add-hook 'after-change-major-mode-hook 'rainbow-delimiters-mode)

;; Yes and no are too tedious to type.
(fset 'yes-or-no-p 'y-or-n-p)
;; Display the time in 24 hours format in the bar.
(display-time)
(setq disaply-time-24h-format t)

;; Spellchecking on OS X (brew info aspell)
(setq-default ispell-program-name "/usr/local/bin/aspell")

;; Zoning. Because it is fun.
(require 'zone)
(setq zone-idle (* 60 3))
(zone-when-idle zone-idle)

;; Folding.
(load "folding" 'nomessage 'noerror)
(folding-mode-add-find-file-hook)
(folding-add-to-marks-list 'python-mode "{{{" "}}}" nil t)

;; Editing .emacs
(defun eemacs ()
  (interactive)
  (split-window-horizontally)
  (windmove-right)
  (find-file "~/.emacs"))

;;; KEYBINDINGS

;; Completion at point
;; (because command + tab just does not fit, and esc + tab hurts)
(global-set-key (kbd "C-<tab>") 'completion-at-point)

;; Fly spell
(global-set-key (kbd "C-4") 'ispell-word)

;; Commenting
;; Original idea from
;; http://www.opensubscriber.com/message/emacs-devel@gnu.org/10971693.html
(defun comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
   If no region is selected and current line is not blank and we are not at the
   end of the line, then comment current line.
   Replaces default behaviour of comment-dwim, when it inserts comment at the
   end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

(global-set-key "\M-;" 'comment-dwim-line)

;; Mark
(global-set-key "\C-a" 'set-mark-command)
(global-set-key (kbd "C-x a") 'mark-whole-buffer)

;; Windows
(global-set-key "\C-w" 'move-beginning-of-line)
(global-set-key "\C-p" 'split-window-vertically)
(global-set-key "\C-o" 'split-window-horizontally)
(global-set-key "\C-\\" 'delete-window)
(if (eql system-type 'darwin)
    (progn
      (global-set-key (kbd "C-x <left>") 'windmove-left)
      (global-set-key (kbd "C-x <right>") 'windmove-right)
      (global-set-key (kbd "C-x <up>") 'windmove-up)
      (global-set-key (kbd "C-x <down>") 'windmove-down))
    (progn
      (global-set-key (kbd "ESC <left>") 'windmove-left)
      (global-set-key (kbd "ESC <right>") 'windmove-right)
      (global-set-key (kbd "ESC <up>") 'windmove-up)
      (global-set-key (kbd "ESC <down>") 'windmove-down)))

;; Killing
(global-set-key "\C-q" 'kill-region)

;; Blank lines
(global-set-key "\C-c t" 'open-line)
(defun go-newline ()
  "Add a new line bellow the current one and move to it."
  (interactive)
  (end-of-line)
  (open-line 1)
  (next-line))
(global-set-key "\C-t" 'go-newline)

;; Go to line
(global-set-key "\C-l" 'goto-line)

;;; Graphical Undo Tree
;; Install the undo-tree package.
(require 'undo-tree)
(global-undo-tree-mode)
(global-set-key (kbd "<f14>") 'undo-tree-visualize)
(global-set-key (kbd "C-U") 'undo-tree-visualize)

;;; Anything
(setq dired-use-ls-dired nil)
(global-set-key (kbd "<f13>") 'anything)
(global-set-key (kbd "C-H") 'anything)

;;; STYLE

;(set-frame-font "Menlo-for-Powerline-12")
; This is beacause of the daemon mode, which does not take the (set-frame-font)
;(add-to-list 'default-frame-alist '(font . "Menlo-14"))
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(add-to-list 'custom-theme-load-path "~/code/color-theme-molokai/")
;(load-theme 'molokai t)
;(load-theme 'mac-classic t)



;;; OS X specific configuration
(if (eql system-type 'darwin)
    (progn
      (if window-system
      (menu-bar-mode t))
      (setq mac-option-key-is-meta nil)
      (setq mac-command-key-is-meta t)
      (setq mac-command-modifier 'meta)
      (setq mac-option-modifier nil)))


;;; YaSnippets

(require 'yasnippet)
(yas/initialize)


;;; SLIME CONFIGURATION  
;; (add-to-list 'load-path "~/.emacs.d/slime")
;; (require 'slime)
;; ;; Define CLISP as the default LISP interpreter.
;; (setq inferior-lisp-program "/usr/local/bin/clisp")
;; (eval-after-load "slime" (slime-setup '(slime-repl)))
;; (slime-setup)


;;; SCHEME CONFIGURATION
(setq scheme-program-name "scheme")
(require 'quack)
(setq quack-programs '("/usr/local/bin/scheme"))


;;; OCTAVE
(setenv "GNUTERM" "x11")


;;; MARKDOWN
(require 'markdown-mode)
(setq auto-mode-alist
      (cons '("\\.md" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.markdown" . markdown-mode) auto-mode-alist))
(add-hook 'markdown-mode-hook
          (lambda () (setq comment-auto-fill-only-comments nil)))

;;; OCAML

(setq tuareg-interactive-program "/usr/local/bin/ocaml")


;;; MATLAB

(add-to-list 'load-path "~/.emacs.d/major-modes/matlab-emacs")
(require 'matlab-load)


;;; LaTeX (with auctex)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)


;;; Erlang

(if (file-exists-p "/usr/local/Cellar/erlang/R14B03")
    (progn
      (setq load-path (cons "/usr/local/Cellar/erlang/R14B03/lib/erlang/lib/tools-2.6.6.4/emacs" load-path))
      (setq erlang-root-dir "/usr/local/Cellar/erlang/R14B03/lib/erlang")
      (setq exec-path (cons "/usr/local/Cellar/erlang/R14B03/lib/erlang/bin" exec-path))
      (require 'erlang-start)
      (require 'erlang-flymake)))


;;; Git Commit

(require 'git-commit)
(add-hook 'git-commit-mode-hook 'turn-on-flyspell)
(add-hook 'git-commit-mode-hook (lambda () (taggle-save-place 0)))


;;; Django-mode

(add-to-list 'load-path "~/.emacs.d/django-mode/")
(require 'django-html-mode)
(require 'django-mode)
;(yas/load-directory "~/.emacs.d/django-mode/snippets/")
(add-to-list 'auto-mode-alist '("\\.djhtml$" . django-html-mode))
; For now I almost only work with Django HTML pages.
(add-to-list 'auto-mode-alist '("\\.html$" . django-html-mode))

;;; GDB

(setq gdb-many-windows t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("ed2638c34f860c0555141215dc23a5664a4d00df" "56f4a335e0c7005b26ed31b5881f760bec917f80" "9ea1b3405347202ed622a2e7dd61b7e03674d010" default)))
 '(quack-programs (quote ("mit-scheme" "/usr/local/bin/scheme" "scheme"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;; KEYBINDINGS

;; Commenting
;; Original idea from
;; http://www.opensubscriber.com/message/emacs-devel@gnu.org/10971693.html
(defun comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
   If no region is selected and current line is not blank and we are not at the
   end of the line, then comment current line.
   Replaces default behaviour of comment-dwim, when it inserts comment at the
   end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

(global-set-key "\M-;" 'comment-dwim-line)

;; Mark
;(global-set-key "\C-a" 'set-mark-command)

;; Windows
(global-set-key "\C-w" 'move-beginning-of-line)
(global-set-key "\C-p" 'split-window-vertically)
(global-set-key "\C-o" 'split-window-horizontally)
(global-set-key "\C-\\" 'delete-window)
(if (eql system-type 'darwin)
    (progn
      (global-set-key (kbd "C-x <left>") 'windmove-left)
      (global-set-key (kbd "C-x <right>") 'windmove-right)
      (global-set-key (kbd "C-x <up>") 'windmove-up)
      (global-set-key (kbd "C-x <down>") 'windmove-down))
    (progn
      (global-set-key (kbd "ESC <left>") 'windmove-left)
      (global-set-key (kbd "ESC <right>") 'windmove-right)
      (global-set-key (kbd "ESC <up>") 'windmove-up)
      (global-set-key (kbd "ESC <down>") 'windmove-down)))

;; Killing
(global-set-key "\C-q" 'kill-region)

;; Blank lines
(global-set-key "\C-c t" 'open-line)
(defun go-newline ()
  "Add a new line bellow the current one and move to it."
  (interactive)
  (end-of-line)
  (open-line 1)
  (next-line))
(global-set-key "\C-t" 'go-newline)

;;; Graphical Undo Tree
;; Install the undo-tree package.
(require 'undo-tree)
(global-undo-tree-mode)
(global-set-key (kbd "<f14>") 'undo-tree-visualize)
(global-set-key (kbd "C-U") 'undo-tree-visualize)

;;; Anything
(setq dired-use-ls-dired nil)
(global-set-key (kbd "<f13>") 'anything)
(global-set-key (kbd "C-H") 'anything)

;;; STYLE

;(set-frame-font "Menlo-12")
; This is beacause of the daemon mode, which does not take the (set-frame-font)
;(add-to-list 'default-frame-alist '(font . "Menlo-14"))
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(add-to-list 'custom-theme-load-path "~/code/color-theme-molokai/")
;(load-theme 'molokai t)
;(load-theme 'mac-classic t)



;;; OS X specific configuration
(if (eql system-type 'darwin)
    (progn
      (if window-system
      (menu-bar-mode t))
      (setq mac-option-key-is-meta nil)
      (setq mac-command-key-is-meta t)
      (setq mac-command-modifier 'meta)
      (setq mac-option-modifier nil)))


;;; YaSnippets

(require 'yasnippet)
(yas/initialize)
(setq yas/snippet-dirs "~/.emacs.d/snippets")

;; ;;; SL
;; (add-to-list 'load-path "~/.emacs.d/slime")
;; (require 'slime)
;; ;; Define CLISP as the default LISP interpreter.
;; (setq inferior-lisp-program "/usr/local/bin/clisp")
;; (eval-after-load "slime" (slime-setup '(slime-repl)))
;; (slime-

;;; SCHEME CONFIGURATION
(setq scheme-program-name "scheme")
(require 'quack)
(setq quack-programs '("/usr/local/bin/scheme"))


;;; OCTAVE
(setenv "GNUTERM" "x11")


;;; MARKDOWN
(require 'markdown-mode)
(setq auto-mode-alist
      (cons '("\\.md" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.markdown" . markdown-mode) auto-mode-alist))
(add-hook 'markdown-mode-hook
          (lambda () (setq comment-auto-fill-only-comments nil)))

;;; OCAML

(setq tuareg-interactive-program "/usr/local/bin/ocaml")


;;; MATLAB

(add-to-list 'load-path "~/.emacs.d/major-modes/matlab-emacs")
(require 'matlab-load)


;;; LaTeX (with auctex)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)


;;; Erlang

(if (file-exists-p "/usr/local/Cellar/erlang/R14B03")
    (progn
      (setq load-path (cons "/usr/local/Cellar/erlang/R14B03/lib/erlang/lib/tools-2.6.6.4/emacs" load-path))
      (setq erlang-root-dir "/usr/local/Cellar/erlang/R14B03/lib/erlang")
      (setq exec-path (cons "/usr/local/Cellar/erlang/R14B03/lib/erlang/bin" exec-path))
      (require 'erlang-start)
      (require 'erlang-flymake)))


;;; Git Commit

(require 'git-commit)
(add-hook 'git-commit-mode-hook 'turn-on-flyspell)
(add-hook 'git-commit-mode-hook (lambda () (taggle-save-place 0)))


;;; Django-mode

(add-to-list 'load-path "~/.emacs.d/django-mode/")
(require 'django-html-mode)
(require 'django-mode)
(add-to-list 'yas/snippet-dirs "~/.emacs.d/django-mode/snippets/")
(add-to-list 'auto-mode-alist '("\\.djhtml$" . django-html-mode))
; For now I almost only work with Django HTML pages.
(add-to-list 'auto-mode-alist '("\\.html$" . django-html-mode))


;;; RHTML, for .erb.html

(add-to-list 'load-path "~/.emacs.d/minor-modes/rhtml")
(require 'rhtml-mode)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("ed2638c34f860c0555141215dc23a5664a4d00df" "56f4a335e0c7005b26ed31b5881f760bec917f80" "9ea1b3405347202ed622a2e7dd61b7e03674d010" default)))
 '(quack-programs (quote ("mit-scheme" "/usr/local/bin/scheme" "scheme"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
