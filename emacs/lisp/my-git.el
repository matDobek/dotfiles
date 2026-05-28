;;; my-git.el --- Magit + fringe change indicators -*- lexical-binding: t -*-

(use-package magit
  :bind ("C-x g" . magit-status))

;; diff-hl puts +/-/~ markers in the fringe next to lines changed since the
;; last commit. The two hooks keep markers in sync when you stage from magit.
(use-package diff-hl
  :init
  (global-diff-hl-mode 1)
  :hook ((magit-pre-refresh  . diff-hl-magit-pre-refresh)
         (magit-post-refresh . diff-hl-magit-post-refresh)))

(with-eval-after-load 'general
  (my/leader
    "g" '(magit-status :which-key "magit")))

(provide 'my-git)
;;; my-git.el ends here
