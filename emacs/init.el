;;; init.el --- Main entry point -*- lexical-binding: t -*-

;; ----------------------------------------------------------------------------
;; straight.el bootstrap
;;
;; Clone the repo with system `git` instead of straight's own install.el —
;; faster, fewer moving parts, and easy to debug if it ever fails.
;; ----------------------------------------------------------------------------
(setq straight-vc-git-default-clone-depth 1
      straight-check-for-modifications nil)

(let* ((base-dir (or (bound-and-true-p straight-base-dir) user-emacs-directory))
       (straight-dir (expand-file-name "straight/repos/straight.el" base-dir))
       (bootstrap-file (expand-file-name "bootstrap.el" straight-dir)))
  (unless (file-exists-p bootstrap-file)
    (make-directory (file-name-directory straight-dir) t)
    (unless (zerop
             (call-process "git" nil "*straight-bootstrap*" t
                           "clone" "--depth" "1"
                           "https://github.com/radian-software/straight.el.git"
                           straight-dir))
      (error "straight.el bootstrap: git clone failed — see *straight-bootstrap* buffer")))
  (load bootstrap-file nil 'nomessage))

;; Make use-package available and have it use straight by default.
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; ----------------------------------------------------------------------------
;; Load path for our own modules
;; ----------------------------------------------------------------------------
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; ----------------------------------------------------------------------------
;; Theme
;; ----------------------------------------------------------------------------
(add-to-list 'custom-theme-load-path (expand-file-name "themes" user-emacs-directory))
(load-theme 'duck t)

;; ----------------------------------------------------------------------------
;; Sane defaults
;; ----------------------------------------------------------------------------
(setq-default
 indent-tabs-mode nil
 tab-width 2
 fill-column 100)

(setq
 ;; Keep cwd clean — backups and autosaves go under user-emacs-directory.
 backup-directory-alist `(("." . ,(expand-file-name "backups" user-emacs-directory)))
 auto-save-file-name-transforms `((".*" ,(expand-file-name "auto-saves/" user-emacs-directory) t))
 create-lockfiles nil
 ;; Misc.
 ring-bell-function 'ignore
 use-short-answers t              ; y/n instead of yes/no
 require-final-newline t
 sentence-end-double-space nil
 ;; Better scrolling.
 scroll-conservatively 101
 scroll-margin 4)

;; Built-in modes worth turning on everywhere.
(recentf-mode 1)
(savehist-mode 1)
(save-place-mode 1)
(global-auto-revert-mode 1)            ; reload buffers when files change on disk
(setq global-auto-revert-non-file-buffers t)

;; Line numbers everywhere except a few buffer types where they're just noise.
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)
(dolist (mode '(vterm-mode-hook
                eshell-mode-hook
                shell-mode-hook
                term-mode-hook
                dired-mode-hook
                treemacs-mode-hook
                magit-status-mode-hook
                magit-log-mode-hook
                magit-diff-mode-hook
                magit-process-mode-hook
                help-mode-hook
                Info-mode-hook
                org-agenda-mode-hook
                pdf-view-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode -1))))

;; Electric pairs + show-paren stay scoped to code buffers.
(add-hook 'prog-mode-hook #'electric-pair-local-mode)
(show-paren-mode 1)

;; ----------------------------------------------------------------------------
;; Module loading
;; ----------------------------------------------------------------------------
(require 'my-evil)
(require 'my-completion)
(require 'my-tree)
(require 'my-treesit)
(require 'my-formatting)
(require 'my-git)

(provide 'init)
;;; init.el ends here
