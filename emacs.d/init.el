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
(setq user-full-name    "Gustav Hedengran"
      user-mail-address "gustav.hedengran@gmail.com")

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
(menu-bar-mode -1
               )
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)

                                        ; add
(global-hl-line-mode +1)
(when (version<= "26.0.50" emacs-version)
  (add-hook 'prog-mode-hook 'global-display-line-numbers-mode))

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

(use-package flucui-themes
  :config
  (flucui-themes-load-style 'light))

;;(use-package nlinum-relative
;;    :config
;;    (nlinum-relative-setup-evil)
;;    (setq nlinum-relative-current-symbol "0")
;;    (add-hook 'prog-mode-hook 'nlinum-relative-mode))

(use-package org)


(use-package smartparens
  :config
  (progn
    (require 'smartparens-config)

    (show-paren-mode t)))

;;;;;;;;;;;;;;;;;;;;
;; HOL and SML
;;;;;;;;;;;;;;;;;;;;
(use-package sml-mode)
(autoload 'hol "~/Documents/KTH/FDD3023/HOL/tools/hol-mode"
  "Runs a HOL session in a comint window.
   With a numeric prefix argument, runs it niced to that level
   or at level 10 with a bare prefix. " t)
;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ending
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'init.el)
;;; init.el ends here
