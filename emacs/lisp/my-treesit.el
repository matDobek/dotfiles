;;; my-treesit.el --- Tree-sitter grammars + auto major-mode -*- lexical-binding: t -*-

;; treesit-auto installs grammars on demand the first time you open a file
;; in a language, and remaps the classic major modes to their *-ts-mode
;; counterparts where a grammar is available.

(use-package treesit-auto
  :config
  (setq treesit-auto-install 'prompt)
  (global-treesit-auto-mode))

(provide 'my-treesit)
;;; my-treesit.el ends here
