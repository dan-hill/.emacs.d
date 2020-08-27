(require 'package)

(setq package-archives '(("gnu" . "http://mirrors.163.com/elpa/gnu/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")))

(package-initialize)

;; Setup for using use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

;; Diminish cleans up the mode-line by allowing you to hide minor mode names.
(use-package diminish
  :ensure t)


;;-------------------------------------------------------------------------------
;; Helm
;; https://github.com/emacs-helm/helm
;; Adds incremental auto-completion.
(use-package helm
  :ensure t
  :bind (
    ("M-x"     . helm-M-x)
    ("C-x C-f" . helm-find-files)
    :map helm-map
    ("C-j" . helm-next-line)
    ("C-k" . helm-previous-line)))


;;-------------------------------------------------------------------------------
;; org-bullets
;; https://github.com/sabof/org-bullets
;; use UTF-8 characters for org-mode bullets.

(use-package org-bullets
  :ensure t
  :commands
    (org-bullets-mode)
  :init
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))


;;-------------------------------------------------------------------------------
;; git-auto-commit-mode
;; https://github.com/ryuslash/git-auto-commit-mode
;; Commit and push automatically after save. 
(use-package git-auto-commit-mode
  :ensure t)


;;-------------------------------------------------------------------------------
;; find-lisp
;; Used to rescursivly add all org files in a directory to agenda.
;; This method is simple but slow.
(load-library "find-lisp")


;;-------------------------------------------------------------------------------
;; org-mode
;; https://orgmode.org/
;; Adds org-mode
(use-package org
  :ensure t
  :mode
    ("\\.org\\'" . org-mode)
  :bind
    ("C-c l" . org-store-link)
    ("C-c a" . org-agenda))
  :config
    (progn
      (setq org-directory "~/org")
      (setq org-default-notes-file (concat org-directory "/capture.org"))
      (setq org-agenda-files (find-lisp-find-files "~/org" "\.org$"))
      (setq org-refile-targets '((org-agenda-files . (:maxlevel . 6))))
      (setq org-log-done t)
      (setq org-startup-indented t)
      (setq org-todo-keywords
        '((sequence "TODO(t)" "WAITING(w)" "|" "CANCELED(c)" "DONE(d)")
	  (sequence "UNPAID(p)" "|" "PAID" )
	  (sequence "NEED(n)" "SOURCING(s)" "ORDERED(o)" "|" "HAVE(h)" )
	  (sequence "ACTIVE(a)" "ONHOLD(h)" "|" "CANCELED(c)" "DONE(d)")))
      (setq org-todo-keyword-faces
        '(("TODO"     . (:foreground "cyan"    :weight bold))
	  ("WAITING"  . (:foreground "yellow"  :weight bold))
	  ("CANCELED" . (:foreground "red"     :weight bold))
	  ("DONE"     . (:foreground "green"   :weight bold))
	  ("UNPAID"   . (:foreground "cyan"    :weight bold))
	  ("PAID"     . (:foreground "green"   :weight bold))
	  ("NEED"     . (:foreground "cyan"    :weight bold))
	  ("SOURCING" . (:foreground "yellow"  :weight bold))
	  ("ORDERED"  . (:foreground "yellow"  :weight bold))
	  ("HAVE"     . (:foreground "green"   :weight bold))
	  ("ACTIVE"   . (:foreground "cyan"    :weight bold))
	  ("ONHOLD"   . (:foreground "yellow"  :weight bold)))))


;;-------------------------------------------------------------------------------
;; ox-hugo
;; https://ox-hugo.scripter.co/
;; Exports org files to hugo
(use-package ox-hugo
  :ensure t
  :after ox)



(set-register ?z '(file . "~/.emacs.d/init.el"))
(set-register ?x '(file . "~/org/core.org"))


(load-theme 'cyberpunk-2019 t)

(setq initial-buffer-choice "~/org/core.org")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d1cc05d755d5a21a31bced25bed40f85d8677e69c73ca365628ce8024827c9e3" default)))
 '(package-selected-packages
   (quote
    (yasnippet elpy org-edna org-depend helm ox-hugo elfeed-org elfeed telephone-line git-auto-commit-mode org-bullets use-package org-trello org-chef diminish cyberpunk-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#000000" :foreground "#d3d3d3" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "SRC" :family "Hack"))))
 '(org-level-1 ((t (:foreground "#ff1493" :height 1.0))))
 '(org-level-2 ((t (:foreground "#ffff00" :height 1.0)))))

;; enable edna for advanced todo dependancies
(use-package org-edna :ensure t)
(org-edna-load)

;; enable yasnippet for expandable snippets on all buffers
(yas-global-mode)
