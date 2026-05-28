;;; my-completion.el --- Minibuffer + search stack -*- lexical-binding: t -*-

;; Vertical minibuffer (the telescope-like list).
(use-package vertico
  :init (vertico-mode 1)
  :config (setq vertico-cycle t))

;; Fuzzy / out-of-order matching for everything, including files.
;; Per-token: try literal substring first (fast), fall back to flex (chars
;; with gaps, so "boo2" matches "bootstrap2.sh"). `basic` is the built-in
;; fallback style — required so completion still works on minibuffers that
;; don't fit orderless (e.g. password prompts, single-char yes/no).
(use-package orderless
  :config
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides nil
        orderless-matching-styles '(orderless-literal orderless-flex)))

;; Annotations in the minibuffer (file sizes, docstrings, etc.).
(use-package marginalia
  :init (marginalia-mode 1))

;; Powerful search / navigation commands: project grep, line search, etc.
;; Keep consult's default `#`-prefix split: text after `#` flows to orderless.
(use-package consult
  :bind
  (("C-x b"   . consult-buffer)
   ("C-x p b" . consult-project-buffer)
   ("M-y"     . consult-yank-pop)
   ("M-g g"   . consult-goto-line)
   ("M-g i"   . consult-imenu)
   ("M-s r"   . consult-ripgrep)
   ("M-s l"   . consult-line)))

;; Embark: act on the current candidate (C-.) or export the whole result list
;; to a real buffer (C-c C-l). For ripgrep, the export becomes a grep-mode
;; buffer you can navigate, edit (wgrep), or kill — same workflow as a normal
;; project-wide grep.
(use-package embark
  :bind
  (("C-."   . embark-act)
   ("C-;"   . embark-dwim)
   ("C-h B" . embark-bindings)))

;; Glue between consult and embark — makes `embark-export` aware of consult's
;; candidate types so e.g. ripgrep -> grep-mode, find-file -> dired.
(use-package embark-consult
  :after (embark consult)
  :hook (embark-collect-mode . consult-preview-at-point-mode))

;; In-buffer completion popup (the cmp / coc equivalent).
(use-package corfu
  :init (global-corfu-mode 1)
  :config
  (setq corfu-auto t
        corfu-auto-prefix 2
        corfu-auto-delay 0.1
        corfu-cycle t
        corfu-quit-no-match 'separator))

;; Extra completion-at-point sources (file paths, dabbrev, keywords).
(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev))

;; Leader bindings for the search stack — wire into general.el if loaded.
(with-eval-after-load 'general
  (my/leader
    "sf" '(project-find-file :which-key "find file in project")
    "sF" '(find-file :which-key "find file by path")
    "sb" '(consult-buffer :which-key "buffers")
    "sg" '(consult-ripgrep :which-key "ripgrep")
    "sl" '(consult-line :which-key "search lines")
    "si" '(consult-imenu :which-key "symbols")
    "sr" '(consult-recent-file :which-key "recent files")
    ;; Embark: act on the current candidate / export results to a buffer.
    "sa" '(embark-act    :which-key "act on candidate")
    "se" '(embark-export :which-key "export to buffer")))

(provide 'my-completion)
;;; my-completion.el ends here
