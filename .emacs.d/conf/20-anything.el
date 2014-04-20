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
(define-key global-map (kbd "s-d") 'anything-for-document)

; ---------------------------
;; moccur
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
