;;
;; 40-git.el
;;


;; ----------------------------
;; git-gutter-fringe+
;; https://github.com/nonsequitur/git-gutter-fringe-plus
;; ----------------------------

(when (require 'git-gutter-fringe+ nil t)
  (global-git-gutter+-mode))

;; ----------------------------
;; magit
;; https://github.com/magit/magit
;; commit c
;; stage s
;; M-x magit-status
;; usage: http://qiita.com/takc923/items/c7a11ff30caedc4c5ba7
;; ----------------------------

(require 'magit)

