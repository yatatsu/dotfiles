;;; -*- coding: utf-8; mode: emacs-lisp; -*-
;;; init.el
;;; yatatsukitagawa <yatatsukitagwa@gmail.com>

;; ~/.emacs.d/elisp ディレクトリ
(add-to-list 'load-path "~/.emacs.d/elisp")

;; for under-23 version
(when (> emacs-major-version 23)
  (defvar user-emacs-directory "~/.emacs.d"))

;; add-load-path
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	    (add-to-list 'load-path default-directory)
	    (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
		(normal-top-level-add-subdirs-to-load-path))))))

;; add directory with add-load-path
(add-to-load-path "elisp" "conf" "public_repos")

;; http://coderepos.org/share/browser/lang/elisp/init-loader/init-loader.el
(require 'init-loader)
(init-loader-load "~/.emacs.d/conf") ;point to directory which has conf file.

;; package.el
(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
	     '("ELPA" . "http://tromey.com/elpa"))
(package-initialize)

;; for Mac
(when (eq system-type 'darwin)
  (require 'ucs-normalize)
  (setq file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs))

;; except Terminal, hide toolbar and scrollbar
(when window-system
  (tool-bar-mode 0)
  (scroll-bar-mode 0))

(unless (eq window-system 'ns)
  (menu-bar-mode 0))

;; cl
(require 'cl)

;; yes => y, no => n
(fset 'yes-or-no-p 'y-or-n-p)

;; ------------------
;; keyboard bind
;; ------------------

;; C-mにnewline-and-indent割り当て
(global-set-key (kbd "C-m") 'newline-and-indent)

;; C-h as backspace
(keyboard-translate ?\C-h ?\C-?)
(global-set-key "\C-h" nil)
(global-set-key (kbd "C-x ?") 'help-command)

;; 折り返しトグルコマンド
(global-set-key (kbd "C-c l") 'toggle-truncate-lines)

;; C-t as other-window
;; init as transpose-chars
(global-set-key (kbd "C-t") 'other-window)

;; C-. as redo
;; http://www.emacswiki.org/emacs/download/redo+.el
(when (require 'redo+ nil t)
  (global-set-key (kbd "C-.") 'redo)
  )

;; -----------------
;; coding
;; -----------------
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

(when (eq system-type 'darwin)
  (require 'ucs-normalize)
  (set-file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs))

(when (eq system-type 'w32)
  (set-file-name-coding-system 'cp932)
  (setq locale-coding-system 'cp932))

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
;; battery
(display-battery-mode t)

;; リージョン内の行数と文字数をモードラインに表示
;; http://d.hatena.ne.jp/sonota88/20110224/1298557375
(defun count-lines-and-chars ()
  (if mark-active
      (format "%d lines,%d chars "
	      (count-lines (region-beginning) (region-end))
	      (- (region-end) (region-beginning)))
    ;; これだとエコーエリアがチラつく
    ;;(count-lines-region (region-beginning) (region-end))
    ""))

(add-to-list 'default-mode-line-format
	     '(:eval (count-lines-and-chars)))

;; タイトルバーにファイルのフルパスを表示
(setq frame-title-format "%f")

;; ------------------
;; indent
;; ------------------
;; Tab
;; (setq-default tab-width 4)

;; ------------------
;; face
;; ------------------
;; テーマ

(when (require 'color-theme nil t)
  ;; テーマを読み込むための設定
  (color-theme-initialize)
  (color-theme-hober))

;; ------------------
;; font
;; ------------------
;; for GUI
(set-face-attribute 'default nil
		    :family "Menlo"
		    :height 120)
(when (require 'font-family-list nil t)
  (set-fontset-font
   nil 'japanese-jisx0208
   ;; English name
   ;; (font-spec :family "Hiragino Mincho Pro"))
   (font-spec :family "ヒラギノ明朝 Pro"))
  ;; ひらがなとカタカナはモトヤシーダ
  (set-fontset-font
   nil '(#x3040 #x30ff)
   (font-spec :family "NfMotoyaCeder"))
  ;; フォントの横幅を調節
  (setq face-font-rescale-alist
      '((".*Menlo.*" . 1.0)
	(".*Hiragino_Mincho_Pro.*" . 1.2)
	(".*nfmotoyaceder-bold.*" . 1.2)
	(".*nfmotoyaceder-medium.*" . 1.2)
	("-cdac$" . 1.3)))
  )

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
(setq hl-line-face 'my-hl-line-face)
(global-hl-line-mode t)

;; paren-mode
(setq show-paren-delay 0) ; 表示までの時間
(show-paren-mode t)
;; paren style
(setq show-paren-style 'expression)
;; change face
(set-face-background 'show-paren-match-face nil)
(set-face-underline-p 'show-paren-match-face "yellow")

;; ------------------
;; auto-save
;; ------------------
;; バックアップファイルの作成場所をauto-save-listに
(add-to-list 'backup-directory-alist
	     (cons "." "~/.emacs.d/auto-save-list/"))
(setq auto-save-file-name-transforms
      `((".*" , (expand-file-name "~/.emacs.d/auto-save-list/") t)))

;; ------------------
;; hook
;; ------------------
;; ファイルが#!から始まる場合, +xをつけて保存
(add-hook 'after-save-hook
	    'executable-make-buffer-file-executable-if-script-p)

;; emacs-lisp-mode-hook用の関数を定義
(defun elisp-mode-hooks ()
    "lisp-mode-hooks"
      (when (require 'eldoc nil t)
	    (setq eldoc-idle-delay 0.2)
	        (setq eldoc-echo-area-use-multiline-p t)
		    (turn-on-eldoc-mode)))
;; emacs-lisp-modeのフックをセット
(add-hook 'emacs-lisp-mode-hook 'elisp-mode-hooks)

;; ------------------
;; elisp
;; ------------------
;; auto install
(when (require 'auto-install nil t)
    (setq auto-install-directory "~/.emacs.d/elisp/")
      ;; EmacsWikiに登録されているelisp名を取得
      (auto-install-update-emacswiki-package-name t)
        ;; プロキシ設定
;;      (setq url-proxy-services '(("http" . "localhost:8339")))
	  ;; install-elisp の関数を利用可能に
	  (auto-install-compatibility-setup))

