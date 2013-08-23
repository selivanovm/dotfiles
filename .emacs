;; Aditional packages repositories
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; Load custom modes
(setq load-path (cons (expand-file-name "~/.emacs.d/major")
		      (cons (expand-file-name "~/.emacs.d/minor")
			    load-path)))

;; Hide various bars
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Use the Alt key as meta
(setq x-alt-keysym 'meta)

;; Ace-jump-mode
(require 'ace-jump-mode)
(define-key global-map (kbd "C-=") 'ace-jump-mode)

;; Key chords
(require 'key-chord)
(key-chord-mode 1)
(key-chord-define-global "fg" 'iy-go-to-char)
(key-chord-define-global "df" 'iy-go-to-char-backward)

;; Hide splash
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)

;; Display the column and line numbers
(setq line-number-mode t)
(setq column-number-mode t)

;; Change theme
(load-theme 'tango-dark)

;; Setup backup files

(setq make-backup-files t)
(setq version-control t)
(setq backup-directory-alist (quote ((".*" . "~/.emacs.tmp/backup"))))
(setq delete-old-versions t)
(setq kept-new-versions 6)
(setq kept-old-versions 2)

;; Fill column
(setq-default fill-column 80)
(setq auto-fill-mode 1)
(setq-default auto-fill-function 'do-auto-fill)
(require 'fill-column-indicator)
(setq fci-rule-width 7)
(setq fci-rule-color "grey")
(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode 1)

;; Highlight whitespaces
(require 'whitespace)
(setq whitespace-display-mappings
      '((space-mark 32 [32])
	(newline-mark 10 [172 10])))
(setq whitespace-style (quote
                        (face tabs spaces trailing lines newline empty
                         space-mark tab-mark newline-mark)))
(global-whitespace-mode 1)

;; Tabs are evil (sometimes)
(setq-default indent-tabs-mode nil)

;; Interactively Do Things
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

;; Comment region
(define-key global-map (kbd "C-x ;") 'comment-region)

;; CC (C, C++, Java...)
(setq c-default-style "bsd"
      c-basic-offset 2)
(global-set-key (kbd "C-x C-o") 'ff-find-other-file)

;;; Automatic indentation
(add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-state 1)))

;; Javascript
(setq js-indent-level 2)

;; CMake
(require 'cmake-mode)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
		("\\.cmake\\'" . cmake-mode))
	      auto-mode-alist))
