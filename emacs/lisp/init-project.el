;;; init-project.el --- 项目管理: projectile / deadgrep / dired

;; ─── Projectile: 项目文件管理 ──────────────────────────────────────
(use-package projectile
  :ensure t
  :init (projectile-mode)
  :custom
  (projectile-completion-system 'default)
  (projectile-indexing-method 'hybrid)          ;; git + 文件系统混合
  (projectile-mode-line '(:eval (format " [%s]" (projectile-project-name))))
  (projectile-project-search-path '("~/projects" "~/src" "~/.emacs.d"))
  ;; 忽略目录
  (projectile-globally-ignored-directories
   '(".git" ".svn" ".hg" ".bzr" "node_modules" "vendor"
     ".next" "dist" "build" ".cache" "__pycache__"
     ".yardoc" "log" "tmp" ".idea" ".vscode"))
  :bind (:map projectile-mode-map
              ("C-c p f" . projectile-find-file)       ;; 项目内查找文件
              ("C-c p s" . projectile-grep)            ;; 项目内搜索内容
              ("C-c p d" . projectile-find-dir)        ;; 查找目录
              ("C-c p p" . projectile-switch-project)  ;; 切换项目
              ("C-c p r" . projectile-recentf)         ;; 项目最近文件
              ("C-c p b" . projectile-switch-to-buffer)
              ("C-c p a" . projectile-add-known-project)
              ("C-c p R" . projectile-remove-known-project)
              ("C-c p i" . projectile-invalidate-cache)))

;; ─── Consult-Projectile: 用 consult 界面浏览项目文件 ────────────────
(use-package consult-projectile
  :ensure t
  :after (consult projectile)
  :bind ("C-c p o" . consult-projectile))

;; ─── Deadgrep: ripgrep GUI ──────────────────────────────────────────
(use-package deadgrep
  :ensure t
  :bind ("C-c s" . deadgrep))

;; ─── Dired: 文件管理器 ─────────────────────────────────────────────
(use-package dired
  :ensure nil
  :custom
  (dired-listing-switches "-alh --group-directories-first")
  (dired-dwim-target t)
  (dired-auto-revert-buffer t)
  (dired-kill-when-opening-new-dired-buffer t)
  (dired-make-directory-clickable t))

(provide 'init-project)
