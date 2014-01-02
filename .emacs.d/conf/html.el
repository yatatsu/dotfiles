;; ---------------------------
;; html-mode
;; ---------------------------

;; nxml-mode
(add-to-list 'auto-mode-alist '("\\.[sx]?html?\\(\\.[a-zA-Z_]+\\)?\\'"  .nxml-mode))

;; html5
(eval-after-load "rng-loc"
  '(add-to-list 'rng-schema-locating-files
				"~/.emacs.d/public_repos/html5-el/schemas.xml"))
(require 'whattf-dt)

;; completion
(setq nxml-slash-auto-complete-flag t)
(setq nxml-bind-meta-tab-to-complete-flag t)
(add-to-list 'ac-modes 'nxml-mode)

;; flymake
(defun flymake-html-init ()
  (list "tidy" (list (flymake-init-create-temp-buffer-copy
					  'flymake-create-temp-inplace))))
(add-to-list 'flymake-allowed-file-name-masks
			 '("\\.html\\'" flymake-html-init))

;; tidy err pattern
(add-to-list 'flymake-err-line-patterns
			 '("line \\([0-9]+\\ column \\([0-9]+\\) - \\(Warning\\|Error\\): \\(.*\\)"
			   nil 1 2 4))

;; ---------------------------
;; css
;; ---------------------------

(defun css-mode-hook ()
  "css-mode hooks"
  (setq cssm-indent-function #'cssm-c-style-indenter)
  (setq cssm-indent-level 2)
  (setq-default indent-tabs-mode nil)
  (setq cssm-newline-before-closing-bracket t))
(add-hook 'css-mode-hook 'css-mode-hooks)

;; ---------------------------
;; xml
;; ---------------------------

(defun flymake-xml-init ()
  (list "xmllint" (list "--valid"
						(flymake-init-create-temp-buffer-copy
						 'flymake-create-temp-inplace))))

