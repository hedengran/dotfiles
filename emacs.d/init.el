;;; --- emacs configuration
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

                                        ; add
(global-hl-line-mode +1)
(when (version<= "26.0.50" emacs-version)
  ;(add-hook 'prog-mode-hook 'global-display-line-numbers-mode))
  (add-hook 'prog-mode-hook 'global-linum-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Packages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;
(use-package evil
  :config
  ;(define-key evil-motion-state-map (kbd "U") 'undo-tree-redo)
  ;(define-key evil-motion-state-map (kbd "SPC") 'execute-extended-command)
  ;(define-key evil-motion-state-map (kbd "C-r") 'recentf-open-files)
  ;(define-key evil-motion-state-map (kbd "C-f") 'find-file)
  ;(define-key evil-motion-state-map (kbd "ESC") 'keyboard-quit)
  ;(define-key evil-motion-state-map (kbd "C-b") 'switch-to-buffer)
  (evil-mode 1))

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
(use-package flyspell)

(use-package org
  :config
  (add-hook 'org-mode-hook 'flyspell-mode))



(use-package olivetti)

(use-package smartparens
  :config
  (progn
    (require 'smartparens-config)
    (show-paren-mode t)))

(use-package neotree
  :config
  (global-set-key [f8] 'neotree-toggle)
  (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
  (evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
  (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "g") 'neotree-refresh)
  (evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-next-line)
  (evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-previous-line)
  (evil-define-key 'normal neotree-mode-map (kbd "A") 'neotree-stretch-toggle)
  (evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle))

(use-package tabbar
  :config
  (evil-define-key 'normal tabbar-mode-map (kbd "C-p") 'tabbar-backward-tab)
  (evil-define-key 'normal tabbar-mode-map (kbd "C-n") 'tabbar-forward-tab))

(use-package elfeed
  :config
  (global-set-key (kbd "C-x w") 'elfeed)
  (evil-define-key 'normal elfeed-search-mode-map (kbd "RET") 'elfeed-search-show-entry)
  (evil-define-key 'normal elfeed-search-mode-map (kbd "TAB") 'elfeed-search-show-entry)
  (evil-define-key 'normal elfeed-search-mode-map (kbd "B") 'elfeed-search-browse-url)
  (evil-define-key 'normal elfeed-search-mode-map (kbd "g") 'elfeed-search-update--force)
  (evil-define-key 'normal elfeed-search-mode-map (kbd "G") 'elfeed-search-fetch)
  (evil-define-key 'normal elfeed-search-mode-map (kbd "q") 'elfeed-search-quit-window)
  (evil-define-key 'normal elfeed-search-mode-map (kbd "u") 'elfeed-search-tag-all-unread)
  (evil-define-key 'normal elfeed-search-mode-map (kbd "r") 'elfeed-search-untag-all-unread)
  (evil-define-key 'normal elfeed-show-mode-map (kbd "q") 'elfeed-kill-buffer)
  (evil-define-key 'normal elfeed-show-mode-map (kbd "b") 'elfeed-show-visit)
  (setq-default elfeed-search-filter "@6-months-ago +unread")
  (setq elfeed-feeds
        '(
          ("https://ben-evans.com/benedictevans?format=RSS" fin-tech)
          ("https://blog.codinghorror.com/rss/" general-tech)
          ("https://blog.aaronbieber.com/posts/index.xml" general-tech)
          ("https://blog.ploeh.dk/atom.xml" software)
          ("https://katarinastensson.com/feed/" general-tech politics)
          ("https://www.svtplay.se/babel/rss.xml" tv)
	  ("https://www.emelieforsberg.com/feed/")
	  ("https://bloggar.aftonbladet.se/samtidigtmedlindaskugge/feed/")
          ("https://www.svtplay.se/genre/k-special/rss.xml" tv)
          ("https://www.svtplay.se/pa-sparet/rss.xml" tv)
          ("https://www.xkcd.com/atom.xml" webcomic))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Latex settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(defun set-exec-path-from-shell-PATH ()
  ;"Sets the exec-path to the same value used by the user shell"
;  (let ((path-from-shell
;         (replace-regexp-in-string
;          "[[:space:]\n]*$" ""
;          (shell-command-to-string "$SHELL -l -c 'echo $PATH'"))))
;    (setenv "PATH" path-from-shell)
;    (setq exec-path (split-string path-from-shell path-separator))))
;; call function now
;(set-exec-path-from-shell-PATH)


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


(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook #'outline-minor-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ending
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'init.el)
;;; init.el ends here
