;;; my-modeline.el --- Minimal custom modeline -*- lexical-binding: t -*-

;; Target shape:
;;   ● bootstrap2.sh   42  35%
;;
;; Status dot encodes BOTH buffer state and diagnostics:
;;   ○ (hollow) = unsaved changes
;;   ● (filled) = saved
;; Color:
;;   grey   = clean / no diagnostics
;;   yellow = at least one warning
;;   red    = at least one error

(defface my/modeline-dot-clean
  '((t (:foreground "#666666")))
  "Modeline status dot when buffer has no diagnostics.")

(defface my/modeline-dot-warning
  '((t (:foreground "#cece41")))
  "Modeline status dot when buffer has warnings but no errors.")

(defface my/modeline-dot-error
  '((t (:foreground "#ce4141")))
  "Modeline status dot when buffer has at least one error.")

(defun my/modeline-dot ()
  "Return the propertized status dot string."
  (let* ((glyph (if (and (buffer-file-name) (buffer-modified-p)) "○" "●"))
         ;; Flymake counts diagnostics per buffer. When flymake isn't running
         ;; (no LSP, no flycheck) the counts are 0 — dot stays clean grey.
         (errors   (when (bound-and-true-p flymake-mode)
                     (length (flymake-diagnostics nil nil :error))))
         (warnings (when (bound-and-true-p flymake-mode)
                     (length (flymake-diagnostics nil nil :warning))))
         (face (cond
                ((and errors (> errors 0))     'my/modeline-dot-error)
                ((and warnings (> warnings 0)) 'my/modeline-dot-warning)
                (t                              'my/modeline-dot-clean))))
    (propertize glyph 'face face)))

(defun my/modeline-percent ()
  "Return `current-line / total-lines` as a percentage."
  (let* ((total (max 1 (line-number-at-pos (point-max))))
         (here  (line-number-at-pos))
         (pct   (floor (* 100.0 (/ (float here) total)))))
    (format "%d%%%%" pct)))

(setq-default
 mode-line-format
 '(" "
   (:eval (my/modeline-dot))
   " "
   (:eval (propertize (buffer-name) 'face 'mode-line-buffer-id))
   "   "
   (:eval (format "%d" (line-number-at-pos)))
   "  "
   (:eval (my/modeline-percent))))

(provide 'my-modeline)
;;; my-modeline.el ends here
