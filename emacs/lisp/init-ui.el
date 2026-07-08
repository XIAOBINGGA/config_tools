;;; init-ui.el --- 界面: 字体 / 主题 / 状态栏 / 括号高亮

;; ─── 字体设置 (根据 settings.el 中的配置) ────────────────────────────
(defun my/set-font ()
  (interactive)
  (when (display-graphic-p)
    (let* ((pixel-width (display-pixel-width))
           (font-size (if (>= pixel-width 1920) my/font-size-hidpi my/font-size-normal))
           (english-font my/english-font)
           (cjk-font my/cjk-font))
      ;; 默认英文字体
      (set-face-attribute 'default nil
                          :family english-font
                          :height (* font-size 10)
                          :weight (if my/enable-bold 'bold 'normal))
      ;; CJK 回退字体 (中文/日文/韩文)
      (set-fontset-font t 'han (font-spec :family cjk-font))
      (set-fontset-font t 'cjk-misc (font-spec :family cjk-font))
      (set-fontset-font t 'kana (font-spec :family cjk-font))
      (set-fontset-font t 'hangul (font-spec :family cjk-font))
      (set-fontset-font t 'symbol (font-spec :family cjk-font))
      ;; 状态栏字体保持一致
      (set-face-attribute 'mode-line nil
                          :family english-font)
      (set-face-attribute 'mode-line-inactive nil
                          :family english-font))))

;; ─── 加粗开关 ─────────────────────────────────────────────────────────
(defun my/toggle-bold ()
  (interactive)
  (let ((w (if (eq (face-attribute 'default :weight) 'bold) 'normal 'bold)))
    (set-face-attribute 'default nil :weight w)
    (message "Font weight: %s" w)))

(my/set-font)

;; ─── Doom 主题 ─────────────────────────────────────────────────────────
(use-package doom-themes
  :ensure t
  :config
  (load-theme my/theme t)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

;; ─── 行间距 / 边距 / 窗口分割线 ──────────────────────────────────────
(setq-default line-spacing my/line-spacing
              left-margin-width 1
              right-margin-width 1)

(setq window-divider-default-places t
      window-divider-default-bottom-width 1
      window-divider-default-right-width 1)

;; ─── Doom 状态栏 ───────────────────────────────────────────────────────
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :custom
  (doom-modeline-buffer-file-name-style 'truncate-except-project)
  (doom-modeline-minor-modes nil)
  (doom-modeline-icon nil)          ;; 不依赖图标字体, 避免方块
  (doom-modeline-major-mode-icon nil)
  (doom-modeline-modal-icon nil)
  (doom-modeline-env-version t))    ;; 显示语言版本 (node/python等)

;; ─── 彩虹括号 (仅在 emacs-lisp 模式启用, 避免通用模式卡顿) ──────
(use-package rainbow-delimiters
  :ensure t
  :hook (emacs-lisp-mode . rainbow-delimiters-mode))


(provide 'init-ui)
