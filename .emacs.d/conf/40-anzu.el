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

