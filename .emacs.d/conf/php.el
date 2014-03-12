;; -----------------
;; php-mode
;; -----------------
;; cf. http://mugijiru.seesaa.net/article/326967860.html
;; use php-mode

(defun php-style-hook ()
  (setq php-mode-force-pear t)
  (c-set-style "stroustrup")    ; インデントは4文字分基本スタイル
  (c-set-offset 'arglist-intro 'ywb-php-lineup-arglist-intro) ; 配列のインデント関係
  (c-set-offset 'arglist-close 'ywb-php-lineup-arglist-close) ; 配列のインデント関係
  (c-set-offset 'arglist-cont-nonempty' 4) ; 配列のインデント関係
  (c-set-offset 'case-label' 4) ; case はインデントする
  (make-local-variable 'tab-width)
  (make-local-variable 'indent-tabs-mode)
  (setq tab-width 4)
  (setq indent-tabs-mode t))   ; インデントにタブを使う
			
(add-hook 'php-mode-hook 'php-style-hook)

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
(add-hook 'php-mode-hook
          (lambda ()
            (require 'php-completion)
            (php-completion-mode t)
            (define-key php-mode-map (kbd "C-o") 'phpcmp-complete)))

(add-hook 'php-mode-hook
          (lambda ()
            (make-local-variable 'ac-sources)
            (setq ac-sources '(
                               ac-source-words-in-same-mode-buffers
                               ac-source-php-completion
                               ac-source-filename
                               ac-source-etags
                               ))))
