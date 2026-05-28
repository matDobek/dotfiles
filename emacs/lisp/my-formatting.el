;;; my-formatting.el --- Async format-on-save via apheleia -*- lexical-binding: t -*-

;; apheleia runs formatters (prettier, black, rustfmt, etc.) in a background
;; process and patches the buffer with the result, so saving never blocks.
;; It auto-detects the right formatter per major mode.

(use-package apheleia
  :init
  (apheleia-global-mode 1))

;; Manual trigger if you want to format without saving.
(with-eval-after-load 'general
  (my/leader
    "cf" '(apheleia-format-buffer :which-key "format buffer")))

(provide 'my-formatting)
;;; my-formatting.el ends here
