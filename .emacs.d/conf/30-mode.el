;;
;; mode.el
;;

;; emacs-lisp-mode
(defun elisp-mode-hooks ()
    "lisp-mode-hooks"
      (when (require 'eldoc nil t)
	    (setq eldoc-idle-delay 0.2)
	        (setq eldoc-echo-area-use-multiline-p t)
		    (turn-on-eldoc-mode)))
;; emacs-lisp-modeのフックをセット
(add-hook 'emacs-lisp-mode-hook 'elisp-mode-hooks)

;; yaml-mode
(when (require 'yaml-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode)))

;; markdown-mode
(when (require 'markdown-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode)))
