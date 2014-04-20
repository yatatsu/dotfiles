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

;; redo+
(when (require 'redo+ nil t)
  (global-set-key (kbd "C-.") 'redo)
  )
