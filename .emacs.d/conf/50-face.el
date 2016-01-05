;;
;; 50-face.el
;;

;; ------------------
;; window
;; ------------------

;; show clumn-number
(column-number-mode t)

;; file size
(size-indication-mode t)
;; clock
;; (setq display-time-day-and-date t)
;; (setq display-time-24hr-format t)
(display-time-mode t)

;; リージョン内の行数と文字数をモードラインに表示
;; http://d.hatena.ne.jp/sonota88/20110224/1298557375
(defun count-lines-and-chars ()
  (if mark-active
      (format "%d lines,%d chars "
	      (count-lines (region-beginning) (region-end))
	      (- (region-end) (region-beginning)))
    ""))

(add-to-list 'default-mode-line-format
	     '(:eval (count-lines-and-chars)))

;; タイトルバーにファイルのフルパスを表示
(setq frame-title-format "%f")

;; except Terminal, hide toolbar and scrollbar
(defun my-frame-setting (&optional window-system)
  "frame setting"
  (when window-system
  (tool-bar-mode 0)
  (scroll-bar-mode 0))
  )
(my-frame-setting)
(add-hook 'after-make-frame-functions
		  'my-frame-setting)

(unless (eq window-system 'ns)
  (menu-bar-mode 0))

;; ------------------
;; face
;; ------------------
;; テーマ

(load-theme 'wombat t)

;; ------------------
;; font
;; ------------------
;; Ricty
(set-face-attribute 'default nil :family "Ricty Discord" :height 150)
(set-fontset-font (frame-parameter nil 'font)
                  'japanese-jisx0208
                  (cons "Ricty Discord" "iso10646-1"))
(set-fontset-font (frame-parameter nil 'font)
                  'japanese-jisx0212
                  (cons "Ricty Discord" "iso10646-1"))
(set-fontset-font (frame-parameter nil 'font)
                  'katakana-jisx0201
                  (cons "Ricty Discord" "iso10646-1"))

;; highlignt
(defface my-hl-line-face
  ;; 背景がdarkならば背景色を紺に
  '((((class color) (background dark))
     (:background "NavyBlue" t))
    ;; 背景色がlightならば緑に
    (((class color) (background light))
     (:background "LightGoldenrodYellow" t))
    (t (:bold t)))
  "hl-line's my face")
;;(setq hl-line-face 'my-hl-line-face)
;;(global-hl-line-mode t)

;; paren-mode
(setq show-paren-delay 0) ; 表示までの時間
(show-paren-mode t)
;; paren style
(setq show-paren-style 'expression)
;; change face
(set-face-background 'show-paren-match-face nil)
(set-face-underline-p 'show-paren-match-face "yellow")

;; ----------------------------
;; package
;; ----------------------------

;; hlinum
(when (require 'hlinum nil t)
  (global-linum-mode t)
  (setq linum-format "%4d "))

;; powerline
(when (require 'powerline nil t)
  (powerline-default-theme))
