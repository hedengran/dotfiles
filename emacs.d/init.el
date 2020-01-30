;;; init.el --- emacs configuration
;;; Commentary:
;;; Code:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; initial setup setup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;
;; package setup
;;;;;;;;;;;;;;;;;;;;


(require 'package)
(setq package-archives '(("org" . "https://orgmode.org/elpa/")
			 ("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
    (package-install 'use-package))
(require 'use-package)
(setf use-package-always-ensure t)

;;;;;;;;;;;;;;;;;;;;
;; general
;;;;;;;;;;;;;;;;;;;;

(fset 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode t) ; reload files edited else-where
(global-set-key (kbd "C-x k") 'kill-this-buffer) ; default-kill this buffer

; evil-mode as fast as possible
(use-package evil
    :config
    (evil-mode 1))

; separate custom-file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

; memory-limits for 21th century
(setq gc-cons-threshold 50000000) ; increase RAM usage
(setq large-file-warning-threshold 100000000)

;;;;;;;;;;;;;;;;;;;;
;; tabs, space, indent
;;;;;;;;;;;;;;;;;;;;

(setq-default tab-width 4
              indent-tabs-mode nil)

;;;;;;;;;;;;;;;;;;;;
;; smooth scrolling
;;;;;;;;;;;;;;;;;;;;

(setq scroll-margin 0
      scroll-conservatively 100000)

;;;;;;;;;;;;;;;;;;;;
;; visual
;;;;;;;;;;;;;;;;;;;;

(if (display-graphic-p)
    (progn
        (setq initial-frame-alist
            '(
              (tool-bar-lines . 0)
              (width . 90)
              (height . 40)))))

;remove
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)

; add
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Packages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package ivy
    :config
    (ivy-mode 1))

(use-package flycheck
    :init
    (global-flycheck-mode))

(use-package company
    :config
    (global-company-mode))
    


(use-package dashboard

    :config
    (dashboard-setup-startup-hook))

(use-package magit
    :config
    (global-set-key (kbd "C-x g") 'magit-status))

(use-package smartparens
    :config
    (progn
        (require 'smartparens-config)
        (smartparens-global-mode 1)
        (show-paren-mode t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ending
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'init.el)
;;; init.el ends here
