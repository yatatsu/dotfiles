;; ---------------------------
;; javascript-mode
;; ---------------------------

;; js-mode-indent
(defun js-indent-hook ()
  (setq js-indent-level 2
		js-expr-indent-offset 2
		indent-tabs-mode nil)
  (defun js-switch-indent ()
	(let* ((parse-status (save-excursion (syntax-pass (point-at-bol))))
		   (offset (- (current-column) (current-indentation)))
		   (indentation (js--proper-indentation parse-status)))
	  (back-to-indentation)
	  (if (looking-at "case\\s")
		  (indent-line-to (+ indentation 2))
		(js-indent-line))
	  (when (> offset 0) (forward-char offset))))
  (set (make-local-variable 'indent-line-function) 'js-switch-indent))

(add-hook 'js2-mode-hook 'js-indent-hook)

;; jsl for flymake init
(defun flymake-jsl-init ()
  (list "jsl" (list "-process" (flymake-init-create-temp-buffer-copy
								'flymake-create-temp-inplace))))
;; flymake for js
(add-to-list 'flymake-allowed-file-name-masks
			 '("\\.js\\'" flymake-jsl-init))
(add-to-list 'flymake-err-line-patterns
			 '("^\\(.+\\)(\\([0-9]+\\)): \\(.*warning\\|SyntaxError\\): \\(.*\\)"
			   1 2 nil 4))
