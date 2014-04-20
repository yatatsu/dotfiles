;;
;; coding.el
;;

;; -----------------
;; coding
;; -----------------
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;; for Mac
(when (eq system-type 'darwin)
  (require 'ucs-normalize)
  (set-file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs))

(when (eq system-type 'w32)
  (set-file-name-coding-system 'cp932)
  (setq locale-coding-system 'cp932))

;; ------------------
;; indent
;; ------------------
;; Tab
(setq-default tab-width 4)
