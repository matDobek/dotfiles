;;; my-tree.el --- File tree sidebar (treemacs) -*- lexical-binding: t -*-

(use-package treemacs
  :defer t
  :config
  (setq treemacs-width 32
        treemacs-follow-after-init t
        treemacs-is-never-other-window nil ; let C-h/C-l move into the sidebar
        treemacs-show-hidden-files t
        treemacs-no-png-images t)         ; terminal-friendly
  (treemacs-follow-mode 1)
  (treemacs-filewatch-mode 1))

(use-package treemacs-evil
  :after (treemacs evil))

;; C-p toggles the tree (NERDTree-style).
;; Bind in evil states too — evil's normal-state map shadows the global one
;; (C-p is bound to evil-paste-pop by default).
(global-set-key (kbd "C-p") #'treemacs)
(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "C-p") #'treemacs)
  (define-key evil-visual-state-map (kbd "C-p") #'treemacs)
  (define-key evil-motion-state-map (kbd "C-p") #'treemacs))

;; Also expose via leader for discoverability.
(with-eval-after-load 'general
  (my/leader
    "tt" '(treemacs :which-key "toggle tree")
    "tf" '(treemacs-find-file :which-key "reveal file in tree")))

(provide 'my-tree)
;;; my-tree.el ends here
