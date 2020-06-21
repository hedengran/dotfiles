;;; --- emacs configuration
;;; Commentary:

;;; Code:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; initial setup setup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Run as server. Send new files to session with emacsclient -n
(server-start)

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


                                        ; separate custom-file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

                                        ; memory-limits for 21th century
(setq gc-cons-threshold 50000000) ; increase RAM usage
(setq large-file-warning-threshold 100000000)

;;;;;;;;;;;;;;;;;;;;
;; tabs, space, indent
;;;;;;;;;;;;;;;;;;;;

;(setq-default tab-width 4
              ;indent-tabs-mode nil)

;;;;;;;;;;;;;;;;;;;;
;; smooth scrolling
;;;;;;;;;;;;;;;;;;;;

(setq scroll-margin 0
      scroll-conservatively 100000)

;;;;;;;;;;;;;;;;;;;;
;; visual
;;;;;;;;;;;;;;;;;;;;

(if (display-graphic-p)
  
      (setq initial-frame-alist
            '(
              (tool-bar-lines . 0)
              (width . 90)
              (height . 40))))

                                        ;remove
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)

(global-visual-line-mode t)
                                        ; add
(global-hl-line-mode +1)
(when (version<= "26.0.50" emacs-version)
  (add-hook 'prog-mode-hook 'global-linum-mode))

(defun my/q-to-dashboard ()
  (interactive)
  (unless (char-equal (elt (buffer-name) 0) ?*)
   (kill-this-buffer))
  (get-buffer-create "*dashboard*"))

(defun my/wq-to-dashboard ()
  (interactive)
  (save-buffer)
  (my/q-to-dashboard))

(use-package evil
  :config
  ;(define-key evil-motion-state-map (kbd "U") 'undo-tree-redo)
  ;(define-key evil-motion-state-map (kbd "SPC") 'execute-extended-command)
  ;(define-key evil-motion-state-map (kbd "C-r") 'recentf-open-files)
  ;(define-key evil-motion-state-map (kbd "C-f") 'find-file)
  ;(define-key evil-motion-state-map (kbd "ESC") 'keyboard-quit)
  ;(define-key evil-motion-state-map (kbd "C-b") 'switch-to-buffer)

  ;; :q should kill the current buffer rather than quitting emacs entirely
  ;(evil-ex-define-cmd "wq" 'my/wq-to-dashboard)
  (evil-ex-define-cmd "q" 'my/q-to-dashboard)
  (evil-ex-define-cmd "wq" 'my/wq-to-dashboard)
  ;; Need to type out :quit to close emacs
  (evil-ex-define-cmd "quit" 'evil-quit)
  (evil-mode 1))

;;;;;;;;;;;;;;;;;;;;
;; 
;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Packages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; HOL
;(load "~/Library/HOL/tools/hol-mode")
;(load "~/Library/HOL/tools/hol-unicode")
;(transient-mark-mode 1)

(use-package ivy
  :config
  (ivy-mode 1))

(use-package projectile
  :config
  (projectile-mode +1))

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

(use-package ispell)
(use-package flyspell
  :config
  (setq ispell-program-name "/usr/local/bin/aspell")
  (setq ispell-list-command "list"))

(use-package org
  :config
  ;(setq org-agenda-files '("~/Google Drive/org/"))
  (add-hook 'org-mode-hook 'flyspell-mode))

(use-package haskell-mode)

(use-package smartparens
  :config
  (progn
    (require 'smartparens-config)
    (show-paren-mode t)))

(use-package tabbar
  :config
  (evil-define-key 'normal tabbar-mode-map (kbd "C-p") 'tabbar-backward-tab)
  (evil-define-key 'normal tabbar-mode-map (kbd "C-n") 'tabbar-forward-tab))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Latex settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package auctex
  :defer t
  :ensure t
  :config
  :init
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq font-latex-fontify-script nil)

  (setq-default TeX-master nil)
  (setq TeX-PDF-mode t); PDF mode (rather than DVI-mode)
  (add-hook 'TeX-mode-hook 'flyspell-mode)
  (add-hook 'teX-mode-hook 'turn-on-visual-line-mode)
  (add-hook 'TeX-mode-hook
	    (lambda () (TeX-fold-mode 1))))

(use-package latex-preview-pane)

(defun set-exec-path-from-shell-PATH ()
  "Sets the exec-path to the same value used by the user shell"
  (let ((path-from-shell
         (replace-regexp-in-string
          "[[:space:]\n]*$" ""
          (shell-command-to-string "$SHELL -l -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))
(set-exec-path-from-shell-PATH)


;(setq org-latex-pdf-process (list "latexmk -pdf %f"))
;(with-eval-after-load "ox-latex"
;  (add-to-list 'org-latex-classes
;               '("kththesis" "\\documentclass{kththesis}"
;                 ("\\chapter{%s}" . "\\chapter*{%s}")
;                 ("\\section{%s}" . "\\section*{%s}")
;                 ("\\subsection{%s}" . "\\subsection*{%s}")
;                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
;                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))
;
;
;(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
;(setq TeX-auto-save t)
;(setq TeX-parse-self t)
;(setq-default TeX-master nil)
;(add-hook 'LaTeX-mode-hook #'outline-minor-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ending
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'init.el)
;;; init.el ends here
