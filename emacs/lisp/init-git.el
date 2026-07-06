;;; init-git.el --- Git 集成: magit / diff-hl / forge / blamer

;; ─── Magit: Git 客户端 ──────────────────────────────────────────────
(use-package magit
  :ensure t
  :bind (("C-c g g" . magit-status)
         ("C-c g l" . magit-log)
         ("C-c g f" . magit-file-popup)
         ("C-c g b" . magit-blame))
  :custom
  (magit-auto-revert-mode nil)
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  :config
  (global-git-commit-mode t))

;; ─── Diff-HL: 行级 Git 变更标记 (默认关闭, C-c g t 切换) ──────────
(use-package diff-hl
  :ensure t
  :hook ((magit-post-refresh . diff-hl-magit-post-refresh)
         (dired-mode . diff-hl-dired-mode))
  :config
  (when my/diff-hl-enabled
    (global-diff-hl-mode 1)))

(defun my/toggle-diff-hl ()
  "全局切换 diff-hl (git 行信息) 显示"
  (interactive)
  (if (bound-and-true-p global-diff-hl-mode)
      (progn
        (global-diff-hl-mode -1)
        (message "diff-hl disabled"))
    (progn
      (global-diff-hl-mode 1)
      (message "diff-hl enabled"))))

(defun my/enable-diff-hl ()
  (interactive)
  (global-diff-hl-mode 1)
  (message "diff-hl enabled"))

(defun my/disable-diff-hl ()
  (interactive)
  (global-diff-hl-mode -1)
  (message "diff-hl disabled"))

;; ─── Forge: 浏览 GitHub/GitLab Issue/PR ─────────────────────────────
(use-package forge
  :ensure t
  :after magit)

;; ─── Blamer: 行级 git blame ──────────────────────────────────────────
(use-package blamer
  :ensure t
  :custom
  (blamer-idle-time 0.5)
  (blamer-min-commit-count 1)
  (blamer-delay 0.3)
  (blamer-max-summary-length 60)
  :hook (prog-mode . blamer-mode))

(provide 'init-git)
