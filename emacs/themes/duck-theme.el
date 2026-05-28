;;; duck-theme.el --- Port of Helix "duck" theme -*- lexical-binding: t -*-

;; Muted dark theme. Warm browns/khakis on near-black, green selections,
;; everything else desaturated grey. Most syntactic categories collapse to
;; one grey - intentional, to keep the eye on strings and structure.

(deftheme duck "Port of the Helix 'duck' theme.")

(let ((background "#161616")
      (foreground "#d9c9ac")
      (light-grey "#666666")
      (dark-grey  "#191919")

      (yellow     "#f2e0c0")
      (brown      "#ac7151")
      (pink       "#fdc0ce")
      (green      "#51ac71")
      (dark-green "#285638")

      (error-fg   "#ce4141")
      (warning-fg "#cece41")
      (info-fg    "#4141ce")
      (hint-fg    "#666666"))

  (custom-theme-set-faces
   'duck

   ;; ---------------------------------------------------------------
   ;; Base UI
   ;; ---------------------------------------------------------------
   `(default            ((t (:background ,background :foreground ,foreground))))
   `(cursor             ((t (:background ,green))))
   `(region             ((t (:background ,dark-green :foreground ,foreground))))
   `(highlight          ((t (:background ,dark-green :foreground ,foreground))))
   `(secondary-selection ((t (:background ,dark-grey))))
   `(fringe             ((t (:background ,background :foreground ,light-grey))))
   `(vertical-border    ((t (:foreground ,dark-grey))))
   `(window-divider     ((t (:foreground ,dark-grey))))
   `(window-divider-first-pixel ((t (:foreground ,dark-grey))))
   `(window-divider-last-pixel  ((t (:foreground ,dark-grey))))
   `(minibuffer-prompt  ((t (:foreground ,brown))))

   ;; Line numbers (Helix: light_grey dim, current = light_grey dim bold)
   `(line-number              ((t (:foreground ,light-grey :background ,background))))
   `(line-number-current-line ((t (:foreground ,foreground   :background ,background :weight bold))))

   ;; Column ruler (Helix: virtual.ruler bg dark_grey)
   `(fill-column-indicator    ((t (:foreground ,dark-grey))))

   ;; Mode line - keep it quiet.
   `(mode-line                ((t (:background ,dark-grey :foreground ,foreground :box nil))))
   `(mode-line-inactive       ((t (:background ,background :foreground ,light-grey :box nil))))
   `(mode-line-buffer-id      ((t (:foreground ,brown :weight bold))))

   ;; Show-paren match
   `(show-paren-match         ((t (:background ,dark-green :foreground ,foreground :weight bold))))
   `(show-paren-mismatch      ((t (:background ,error-fg :foreground ,background))))

   ;; ---------------------------------------------------------------
   ;; Syntax (font-lock)
   ;;
   ;; Helix collapses keyword/punctuation/operator to one grey - mirror that.
   ;; Only strings and numbers get brown; everything else is foreground or grey.
   ;; ---------------------------------------------------------------
   `(font-lock-comment-face              ((t (:foreground ,light-grey :slant italic))))
   `(font-lock-comment-delimiter-face    ((t (:foreground ,light-grey))))
   ;; Heredoc bodies in bash-ts-mode use font-lock-doc-face — keep them string-colored.
   `(font-lock-doc-face                  ((t (:foreground ,brown))))
   `(font-lock-doc-markup-face           ((t (:foreground ,brown))))
   `(sh-heredoc                          ((t (:foreground ,brown))))
   `(font-lock-string-face               ((t (:foreground ,brown))))
   `(font-lock-constant-face             ((t (:foreground ,brown))))
   `(font-lock-number-face               ((t (:foreground ,brown))))
   `(font-lock-keyword-face              ((t (:foreground ,light-grey))))
   `(font-lock-builtin-face              ((t (:foreground ,light-grey))))
   `(font-lock-function-name-face        ((t (:foreground ,foreground))))
   `(font-lock-function-call-face        ((t (:foreground ,foreground))))
   `(font-lock-variable-name-face        ((t (:foreground ,foreground))))
   `(font-lock-variable-use-face         ((t (:foreground ,foreground))))
   `(font-lock-type-face                 ((t (:foreground ,foreground))))
   `(font-lock-preprocessor-face         ((t (:foreground ,light-grey))))
   `(font-lock-warning-face              ((t (:foreground ,warning-fg))))
   `(font-lock-negation-char-face        ((t (:foreground ,light-grey))))
   `(font-lock-regexp-grouping-backslash ((t (:foreground ,light-grey))))
   `(font-lock-regexp-grouping-construct ((t (:foreground ,light-grey))))
   `(font-lock-punctuation-face          ((t (:foreground ,light-grey))))
   `(font-lock-bracket-face              ((t (:foreground ,light-grey))))
   `(font-lock-delimiter-face            ((t (:foreground ,light-grey))))
   `(font-lock-operator-face             ((t (:foreground ,light-grey))))

   ;; ---------------------------------------------------------------
   ;; Diagnostics (flymake / flycheck / eglot)
   ;; ---------------------------------------------------------------
   `(flymake-error    ((t (:underline (:style wave :color ,error-fg)))))
   `(flymake-warning  ((t (:underline (:style wave :color ,warning-fg)))))
   `(flymake-note     ((t (:underline (:style wave :color ,hint-fg)))))
   `(error            ((t (:foreground ,error-fg))))
   `(warning          ((t (:foreground ,warning-fg))))
   `(success          ((t (:foreground ,green))))

   ;; ---------------------------------------------------------------
   ;; Markdown / org headings (Helix markup.*)
   ;; ---------------------------------------------------------------
   `(markdown-header-face            ((t (:foreground ,brown :weight bold))))
   `(markdown-header-delimiter-face  ((t (:foreground ,light-grey))))
   `(markdown-list-face              ((t (:foreground ,light-grey))))
   `(markdown-link-face              ((t (:foreground ,foreground :weight light))))
   `(markdown-blockquote-face        ((t (:foreground ,light-grey :slant italic))))
   `(markdown-code-face              ((t (:foreground ,light-grey))))
   `(markdown-inline-code-face       ((t (:foreground ,light-grey))))

   `(org-level-1   ((t (:foreground ,brown :weight bold))))
   `(org-level-2   ((t (:foreground ,brown))))
   `(org-level-3   ((t (:foreground ,foreground :weight bold))))
   `(org-level-4   ((t (:foreground ,foreground))))
   `(org-link      ((t (:foreground ,foreground :underline t))))
   `(org-code      ((t (:foreground ,light-grey))))
   `(org-block     ((t (:background ,dark-grey :foreground ,foreground))))
   `(org-quote     ((t (:foreground ,light-grey :slant italic))))

   ;; ---------------------------------------------------------------
   ;; Vertico / completion (the search stack)
   ;; ---------------------------------------------------------------
   `(vertico-current     ((t (:background ,dark-green :foreground ,foreground))))
   `(marginalia-key      ((t (:foreground ,brown))))
   `(marginalia-string   ((t (:foreground ,brown))))
   `(marginalia-documentation ((t (:foreground ,light-grey :slant italic))))
   `(completions-common-part  ((t (:foreground ,brown :weight bold))))
   `(orderless-match-face-0   ((t (:foreground ,brown :weight bold))))
   `(orderless-match-face-1   ((t (:foreground ,green :weight bold))))
   `(orderless-match-face-2   ((t (:foreground ,pink :weight bold))))
   `(orderless-match-face-3   ((t (:foreground ,yellow :weight bold))))

   ;; ---------------------------------------------------------------
   ;; Corfu (in-buffer completion popup)
   ;; ---------------------------------------------------------------
   `(corfu-default      ((t (:background ,dark-grey :foreground ,foreground))))
   `(corfu-current      ((t (:background ,dark-green :foreground ,foreground))))
   `(corfu-bar          ((t (:background ,light-grey))))
   `(corfu-border       ((t (:background ,dark-grey))))

   ;; ---------------------------------------------------------------
   ;; Magit
   ;; ---------------------------------------------------------------
   `(magit-section-heading        ((t (:foreground ,brown :weight bold))))
   `(magit-section-highlight      ((t (:background ,dark-grey))))
   `(magit-diff-added             ((t (:foreground ,green :background ,background))))
   `(magit-diff-added-highlight   ((t (:foreground ,green :background ,dark-grey))))
   `(magit-diff-removed           ((t (:foreground ,error-fg :background ,background))))
   `(magit-diff-removed-highlight ((t (:foreground ,error-fg :background ,dark-grey))))
   `(magit-diff-context           ((t (:foreground ,light-grey))))
   `(magit-diff-context-highlight ((t (:foreground ,foreground :background ,dark-grey))))
   `(magit-hash                   ((t (:foreground ,light-grey))))
   `(magit-branch-local           ((t (:foreground ,green))))
   `(magit-branch-remote          ((t (:foreground ,brown))))

   ;; diff-hl (fringe markers next to changed lines)
   `(diff-hl-insert ((t (:foreground ,green :background ,background))))
   `(diff-hl-delete ((t (:foreground ,error-fg :background ,background))))
   `(diff-hl-change ((t (:foreground ,brown :background ,background))))

   ;; ---------------------------------------------------------------
   ;; Treemacs
   ;; ---------------------------------------------------------------
   `(treemacs-root-face            ((t (:foreground ,brown :weight bold))))
   `(treemacs-directory-face       ((t (:foreground ,foreground))))
   `(treemacs-file-face            ((t (:foreground ,light-grey))))
   `(treemacs-git-modified-face    ((t (:foreground ,brown))))
   `(treemacs-git-added-face       ((t (:foreground ,green))))
   `(treemacs-git-untracked-face   ((t (:foreground ,light-grey :slant italic))))
   `(treemacs-git-ignored-face     ((t (:foreground ,light-grey))))

   ;; ---------------------------------------------------------------
   ;; hl-todo (TODO/FIXME highlight in comments)
   ;; ---------------------------------------------------------------
   `(hl-todo ((t (:foreground ,warning-fg :weight bold))))

   ;; ---------------------------------------------------------------
   ;; isearch / occur
   ;; ---------------------------------------------------------------
   `(isearch         ((t (:background ,green :foreground ,background))))
   `(isearch-fail    ((t (:background ,error-fg :foreground ,background))))
   `(lazy-highlight  ((t (:background ,dark-green :foreground ,foreground))))
   `(match           ((t (:background ,dark-green :foreground ,foreground))))
   ))

(provide-theme 'duck)
;;; duck-theme.el ends here
