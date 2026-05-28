;;; early-init.el --- Pre-init setup -*- lexical-binding: t -*-

;; Raise GC threshold during startup, restore after init.
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 32 1024 1024)
                  gc-cons-percentage 0.1)))

;; Don't let package.el load anything; straight.el will handle packages.
(setq package-enable-at-startup nil)

;; Strip UI chrome before the first frame is drawn (no flicker).
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; Don't resize the frame when font/UI elements change at startup.
(setq frame-inhibit-implied-resize t)

;; Quieter startup.
(setq inhibit-startup-message t
      inhibit-startup-screen t
      initial-scratch-message nil)

(provide 'early-init)
;;; early-init.el ends here
