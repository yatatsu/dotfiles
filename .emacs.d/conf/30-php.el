;; -----------------
;; php-mode
;; -----------------
;; cf. http://mugijiru.seesaa.net/article/326967860.html
;; use php-mode

(when (require 'php-mode nil t)
  (setq php-search-url "http://jp.php.net/ja")
  (setq php-manual-url "http://jp.php.net/manual/ja"))

(defun php-indent-hook ()
  (setq php-mode-force-pear t)
  (defun my-php-lineup-arglist-intro (langelem)
	(save-excursion
	  (goto-char (cdr langelem))
	  (vector (+ (current-column) c-basic-offset))))
  (defun my-php-lineup-arglist-close (langelem)
	(save-excursion
	  (goto-char (cdr langelem))
	  (vector (current-column))))
;;  (c-set-style "stroustrup") ; default -> gnu
  (c-set-offset 'arglist-intro 'my-php-lineup-arglist-intro) ; 配列のインデント関係
  (c-set-offset 'arglist-close 'my-php-lineup-arglist-close) ; 配列のインデント関係
  (c-set-offset 'arglist-cont-nonempty '4) ; 配列のインデント関係
  (c-set-offset 'block-open '0)
  (c-set-offset 'class-open '0)
  (c-set-offset 'class-close '0)
  (c-set-offset 'substatement-open '0)
  (c-set-offset 'case-label '4) ; case はインデントする
  (setq c-basic-offset 4)
  (setq c-brace-offset 0)
  (setq indent-tabs-mode t))   ; インデントにタブを使う

(add-hook 'php-mode-hook 'php-indent-hook)

;; flymake config
(defun flymake-php-init ()
  (list "php" (list "-l" (flymake-init-create-temp-buffer-copy
						  'flymake-create-temp-inplace))))
(add-to-list 'flymake-allowed-file-name-masks
			 '("\\.php\\'" flymake-php-init))
(add-to-list 'flymake-err-line-patterns
			 '("(Parse|Fatal) error: (.*) in (.*) on line ([0-9]+)" 3 4 nil 2))
(add-hook 'php-mode-hook (flymake-mode t))

;; other
(defun php-completion-hook ()
  (when (require 'php-completion nil t)
	(php-completion-mode t)
	(define-key php-mode-map (kbd "C-o") 'phpcmp-complete)

	(when (require 'auto-complete nil t)
	  (make-variable-buffer-local 'ac-sources)
	  (add-to-list 'ac-sources 'ac-source-php-completion)
	  (add-to-list 'ac-sources 'ac-source-words-in-same-mode-buffers)
	  (add-to-list 'ac-sources 'ac-source-filename)
	  (auto-complete-mode t))))

(add-hook 'php-mode-hook 'php-completion-hook)
