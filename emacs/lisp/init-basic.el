;;; init-basic.el --- 基础编辑器设置

;; ─── 关闭启动画面/提示音/确认弹窗等 ──────────────────────────────────
(setq inhibit-startup-message t
      initial-scratch-message nil
      ring-bell-function 'ignore
      sentence-end-double-space nil
      confirm-nonexistent-file-or-buffer t
      use-short-answers t)

;; ─── 默认折行宽度 ─────────────────────────────────────────────────────
(setq-default fill-column 80)

;; ─── 静默 native-comp 警告 ────────────────────────────────────────────
(setq native-comp-async-report-warnings-errors 'silent
      ad-redefinition-action 'accept
      load-prefer-newer t)

;; ─── 内置功能开关 ─────────────────────────────────────────────────────
(save-place-mode 1)              ;; 记住光标位置
(savehist-mode 1)                ;; 记住 minibuffer 历史
(global-auto-revert-mode 1)      ;; 文件变更自动刷新
(recentf-mode 1)                 ;; 最近文件列表
(electric-pair-mode 1)           ;; 自动配对括号
(when my/display-line-numbers
  (global-display-line-numbers-mode 1))  ;; 行号
(column-number-mode 1)           ;; 显示列号
(global-hl-line-mode 1)          ;; 高亮当前行

;; ─── 备份与自动保存 ────────────────────────────────────────────────────
(setq display-line-numbers-width-start t
      recentf-max-saved-items 200
      auto-revert-verbose nil
      create-lockfiles nil
      backup-directory-alist
      `((".*" . ,(expand-file-name "backups" user-emacs-directory)))
      auto-save-file-name-transforms
      `((".*" ,(expand-file-name "auto-save" user-emacs-directory) t))
      custom-file (expand-file-name "custom.el" user-emacs-directory))

;; 创建备份/自动保存目录
(unless (file-exists-p (expand-file-name "backups" user-emacs-directory))
  (make-directory (expand-file-name "backups" user-emacs-directory) t))
(unless (file-exists-p (expand-file-name "auto-save" user-emacs-directory))
  (make-directory (expand-file-name "auto-save" user-emacs-directory) t))

;; ─── 加载自定义存储文件 ───────────────────────────────────────────────
(load custom-file 'noerror)

(provide 'init-basic)
