;; -----------------
;; haskell
;; -----------------

(autoload 'ghc-init "ghc" nil t)
(add-hook 'haskell-mode-hook '(lambda ()
								(ghc-init)
								(flymake-mode)
								))

(defun flymake-Haskell-init ()
          (flymake-simple-make-init-impl
            'flymake-create-temp-with-folder-structure nil nil
            (file-name-nondirectory buffer-file-name)
            'flymake-get-Haskell-cmdline))

(add-to-list 'flymake-allowed-file-name-masks
			 '("\\.hs\\'" flymake-Haskell-init))
(add-to-list 'flymake-err-line-patterns
			 '("^\\(\.+\.hs\\|\.lhs\\):\\([0-9]+\\):\\([0-9]+\\):\\(.+\\)"
			   1 2 3 4))
