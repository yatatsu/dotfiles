;;
;; 90-other.el
;;

;; ---------------------------
;; wgrep
;; ---------------------------
;; M-x package-install RET wgrep RET
(require 'wgrep nil t)

;; ---------------------------
;; auto-complete
;; ----------------------------
;; auto-completeの設定
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories
	       "~/.emacs.d/elisp/ac-dict")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default))

;; ----------------------------
;; multi-term
;; ----------------------------

;;(when (require 'multi-term nil t)
;;(setq multi-term-program "/opt/boxen/homebrew/bin/zsh"))

;; ----------------------------
;; TRAMP
;; ----------------------------
(add-to-list 'backup-directory-alist
			 (cons tramp-file-name-regexp nil))


;; ----------------------------
;; flycheck
;; ----------------------------

(when (require 'flycheck nil t)
  (add-hook 'after-init-hook #'global-flycheck-mode))
