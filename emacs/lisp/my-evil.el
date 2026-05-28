;;; my-evil.el --- Vim emulation + leader keys -*- lexical-binding: t -*-

;; ----------------------------------------------------------------------------
;; Buffer cycling helpers (used by J / K)
;; ----------------------------------------------------------------------------
(defun my/file-buffer-p (buffer)
  "Non-nil when BUFFER is visiting a file (i.e. not *Messages*, *scratch*, etc.)."
  (buffer-file-name buffer))

(defun my/next-file-buffer ()
  "Switch to the next file-visiting buffer, wrapping around."
  (interactive)
  (let ((bufs (seq-filter #'my/file-buffer-p (buffer-list))))
    (when (> (length bufs) 1)
      (switch-to-buffer (nth 1 bufs)))))

(defun my/previous-file-buffer ()
  "Switch to the previous file-visiting buffer, wrapping around."
  (interactive)
  (let ((bufs (seq-filter #'my/file-buffer-p (buffer-list))))
    (when (> (length bufs) 1)
      (switch-to-buffer (car (last bufs))))))

;; evil-want-keybinding must be nil BEFORE evil loads, so evil-collection
;; can install its own integrations.
(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-want-C-u-scroll t
        evil-want-C-d-scroll t
        evil-undo-system 'undo-redo
        evil-search-module 'evil-search
        evil-split-window-below t
        evil-vsplit-window-right t)
  :config
  (evil-mode 1)

  ;; ESC cancels minibuffer prompts (rename, find-file, etc.) instead of acting
  ;; as the meta prefix. Matches vim/nvim's "ESC always cancels" muscle memory.
  (define-key minibuffer-mode-map (kbd "<escape>") #'abort-recursive-edit)

  ;; HJKL window movement (matches your nvim <C-h/j/k/l>).
  ;; Bind in motion state too — read-only buffers (treemacs, help, etc.) live
  ;; in motion state, not normal state, so the normal-state map alone wouldn't
  ;; apply there.
  (dolist (map (list evil-normal-state-map evil-motion-state-map))
    (define-key map (kbd "C-h") #'evil-window-left)
    (define-key map (kbd "C-j") #'evil-window-down)
    (define-key map (kbd "C-k") #'evil-window-up)
    (define-key map (kbd "C-l") #'evil-window-right)
    ;; J / K cycle through *file-visiting* buffers (skip *Messages*, *scratch*,
    ;; magit views, help, etc.).
    (define-key map (kbd "J") #'my/previous-file-buffer)
    (define-key map (kbd "K") #'my/next-file-buffer))

  ;; Center after half-page scroll and search (matches your zz mappings).
  (advice-add 'evil-scroll-down :after (lambda (&rest _) (recenter)))
  (advice-add 'evil-scroll-up   :after (lambda (&rest _) (recenter)))
  (advice-add 'evil-search-next :after (lambda (&rest _) (recenter)))
  (advice-add 'evil-search-previous :after (lambda (&rest _) (recenter))))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Commenting: gc / gcc, like vim-commentary.
(use-package evil-commentary
  :after evil
  :config
  (evil-commentary-mode 1))

;; Selection-by-syntax: press `v` again in visual mode to grow the selection
;; to the next syntactic unit (word -> string -> parens -> block -> function).
;; Shift+V shrinks one step back.
(use-package expand-region
  :after evil
  :config
  (define-key evil-visual-state-map (kbd "v") #'er/expand-region)
  (define-key evil-visual-state-map (kbd "V") #'er/contract-region))

;; ----------------------------------------------------------------------------
;; Leader key (SPC) — general.el makes leader bindings ergonomic.
;; ----------------------------------------------------------------------------
(use-package general
  :after evil
  :config
  (general-create-definer my/leader
    :states '(normal visual)
    :keymaps 'override
    :prefix "SPC")

  (my/leader
    ;; Files / buffers
    "."  '(find-file :which-key "find file")
    ","  '(switch-to-buffer :which-key "switch buffer")
    "qq" '(kill-current-buffer :which-key "kill buffer")

    ;; Splits (matches your <leader>v / <leader>x in nvim)
    "v"  '(split-window-right :which-key "vsplit")
    "x"  '(split-window-below :which-key "hsplit")

    ;; Comments (works on line in normal state, on selection in visual state)
    "/"  '(evil-commentary-line :which-key "comment line")

    ;; Reload
    "r"  '((lambda () (interactive) (load-file user-init-file))
           :which-key "reload init")

    ;; System clipboard yank (matches your <leader>y)
    "y"  '((lambda () (interactive)
             (let ((select-enable-clipboard t))
               (call-interactively #'evil-yank)))
           :which-key "yank to clipboard")))

;; Discoverability popup for leader and other prefixes.
(use-package which-key
  :config
  (setq which-key-idle-delay 0.4)
  (which-key-mode 1))

(provide 'my-evil)
;;; my-evil.el ends here
