;; 
;; 00-keybind.el
;; 

;; yes => y, no => n
(fset 'yes-or-no-p 'y-or-n-p)

;; cua-mode
(cua-mode t)
(setq cua-enable-cua-keys nil) ; disable cua-keybind

;; C-mにnewline-and-indent割り当て
(global-set-key (kbd "C-m") 'newline-and-indent)

;; C-h as backspace
(defun my-backspace-setting (&optional frame)
  "setup keyboard translate"
  (when frame
	(select-frame frame))
  (keyboard-translate ?\C-h ?\C-?)
  (global-set-key "\C-h" nil)
  (global-set-key (kbd "C-x ?") 'help-command)
  )
(my-backspace-setting)
(add-hook 'after-make-frame-functions
		  'my-backspace-setting)

(setq backward-delete-char-untabify-method 'hungry)
  

;; 折り返しトグルコマンド
(global-set-key (kbd "C-c l") 'toggle-truncate-lines)

;; C-t as other-window
;; init as transpose-chars
(global-set-key (kbd "C-t") 'other-window)

;; C-' as redo
;; http://www.emacswiki.org/emacs/download/redo+.el
(when (require 'redo+ nil t)
  (global-set-key (kbd "C-.") 'redo)
  )

;; describe binding
(global-set-key (kbd "C-c b") 'describe-bindings)
