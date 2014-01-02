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

;; cl
(require 'cl)

;; yes => y, no => n
(fset 'yes-or-no-p 'y-or-n-p)

;; cua-mode
(cua-mode t)
(setq cua-enable-cua-keys nil) ; disable cua-keybind


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

;; describe binding
(global-set-key (kbd "C-c b") 'describe-bindings)

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
(setq-default tab-width 4)

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
;; フォント設定
(set-face-attribute 'default nil
                    :family "inconsolata"
                    :height 140)
 
(when (require 'font-family-list nil t)
  (set-fontset-font
   nil 'japanese-jisx0208
   (font-spec :family "TakaoExMincho"))
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
(setq show-paren-match-face nil)
(setq show-paren-match-face "yellow")

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

;; ------------------
;; anything
;; ------------------
;; (auto-install-batch "anything")
(when (require 'anything nil t)
  (setq
   ;; 候補を表示するまでの時間. デフォルトは0.5
   anything-idle-delay 0.3
   ;; タイプして再描写するまでの時間. デフォルトは0.1
   anything-input-idle-delay 0.2
   ;; 候補の最大表示数. デフォルトは0.1
   anything-candidate-number-limit 100
   ;; 候補が多い時に体感速度を早くする
   anything-quick-update t
   ;; 候補洗濯ショートカットをアルファベットに
   anything-enable-shortcuts 'alphabet)

  (when (require 'anything-config nil t)
    ;; root権限でアクションを実行するコマンド
    ;; デフォルトはsu
    (setq anything-su-or-sudo "sudo"))

  (require 'anything-match-plugin nil t)

  (when (and (executable-find "cmigemo")
	     (require 'migemo nil t))
    (require 'anything-migemo nil t))

  (when (require 'anything-complete nil t)
    ;; lispシンボルの補完候補の再検索時間
    (anything-lisp-complete-symbol-set-timer 150))

  (require 'anything-show-completion nil t)

  (when (require 'descbinds-anything nil t)
    ;; describle-bindingsをAnythingを置き換える
    (descbinds-anything-install)))

;; M-yにanything-show-kill-ringを割り当てる
(define-key global-map (kbd "M-y") 'anything-show-kill-ring)

;; anything-for-document
(setq anything-for-document-sources
	  (list anything-c-source-man-pages
			anything-c-source-info-cl
			anything-c-source-info-pages
			anything-c-source-info-elisp
			anything-c-source-apropos-emacs-commands
			anything-c-source-apropos-emacs-functions
			anything-c-source-apropos-emacs-variables))
(defun anything-for-document ()
  "Preconfigured `anything' for anything-for-document."
  (interactive)
  (anything anything-for-document-sources
			(thing-at-point 'symbol) nil nil nil
			"*anything for document*"))

;; Cmd-dにanything-for-document割り当て
(define-key global-map (kbd "C-c d") 'anything-for-document)

; ---------------------------
;; Moccur
;; ---------------------------
(when (require 'anything-c-moccur nil t)
  (setq
   ;; anything-c-moccur用 'anything-idle-delay'
   anything-c-moccur-anything-idle-delay 0.1
   ;; バッファの情報をハイライトする
   anything-c-moccur-highlight-into-line-flag t
   ;; 現在選択中の候補の位置を他のwindowに表示する
   anything-c-moccur-enable-auto-look-flag t
   ;; 起動時にポイントの位置の単語を初期パターンにする
   anything-c-moccur-enable-initial-pattern t)
  ;; C-M-o にanything-c-moccur-occur-by-moccurを割り当てる
  (global-set-key (kbd "C-M-o") 'anything-c-moccur-occur-by-moccur))

;; color-moccurの設定
(when (require 'color-moccur nil t)
  ;; M-oにoccur-by-moccurを割り当て
  (define-key global-map (kbd "M-o") 'occur-by-moccur)
  ;; スペース区切りでAND検索
  (setq moccur-split-word t)
  ;; ディレクトリ検索の時除外するファイル
  (add-to-list 'dmoccur-exclusion-mask "\\.DS_Store")
  (add-to-list 'dmoccur-exclusion-mask "^#.+#$")
  ;; Migemoを利用できる環境があればMigemoを使う
  (when (and (executable-find "cmigemo")
	     (require 'migemo nil t))
    (setq moccur-use-migemo t)))

;; moccur-edit
(require 'moccur-edit nil t)

;; moccur-edit-finish-editと同時にファイルを保存する
(defadvice moccur-edit-change-file
  (after save-after-moccur-edit-buffer activate)
  (save-buffer))

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
;; undo
;; ----------------------------
;; undohist
(when (require 'undohist nil t)
  (undohist-initialize))

;; Undo-tree
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

;; point-undo
(when (require 'point-undo nil t)
  (define-key global-map (kbd "M-[") 'point-undo)
  (define-key global-map (kbd "M-]") 'point-redo)
  )

;; ----------------------------
;; ElScreen
;; ----------------------------

(setq ElScreen-prefix-key (kbd "C-t"))
(when (require 'elscreen nil t)
  (if window-system
      (define-key elscreen-map (kbd "C-z") 'iconify-or-deiconify-frame)
    (define-key elscreen-map (kbd "C-z") 'suspend-emacs)))

;; ----------------------------
;; anzu
;; ----------------------------

(when (require 'anzu nil t)
  (global-anzu-mode +1)
  (setq anzu-deactivate-region t)
  (setq anzu-search-threshold 1000)
  (global-set-key (kbd "C-c r") 'anzu-query-replace)
  (global-set-key (kbd "C-c R") 'anzu-query-replace-regexp)
  )

;; ----------------------------
;; git-gutter
;; ----------------------------
;; https://github.com/syohex/emacs-git-gutter-fringe
(require 'git-gutter-fringe)
(global-git-gutter-mode)

;; ----------------------------
;; multi-term
;; ----------------------------

(when (require 'multi-term nil t)
  (setq multi-term-program "/opt/boxen/homebrew/bin/zsh"))

;; ----------------------------
;; TRAMP
;; ----------------------------
(add-to-list 'backup-directory-alist
			 (cons tramp-file-name-regexp nil))


;; ----------------------------
;; for doc
;; ----------------------------
;; キャッシュを作成
(setq woman-manpath '("/usr/bin/man"
					  "/usr/share/man"
					  "/usr/local/share/man"
					  "/sur/local/share/man/ja"))
