;;; init-web.el --- Web 开发: HTML / CSS / JS / TS / 格式化

;; ─── Web Mode: 全能 HTML/模板文件 ────────────────────────────────────
(use-package web-mode
  :ensure t
  :mode ("\\.html?\\'" "\\.phtml\\'" "\\.tpl\\.php\\'"
         "\\.erb\\'" "\\.hbs\\'" "\\.mustache\\'"
         "\\.ejs\\'" "\\.jsp\\'" "\\.vue\\'"
         "\\.svelte\\'")
  :custom
  (web-mode-markup-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-code-indent-offset 2)
  (web-mode-style-padding 1)
  (web-mode-script-padding 1)
  (web-mode-block-padding 0)
  (web-mode-enable-auto-pairing nil)
  (web-mode-enable-current-element-highlight t)
  (web-mode-enable-css-colorization t)
  (web-mode-enable-comment-annotation t))

;; ─── Tree-Sitter 语法自动安装 ───────────────────────────────────────
(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (global-treesit-auto-mode))

;; ─── Tree-Sitter 原生模式 ─────────────────────────────────────────────
(use-package css-ts-mode
  :ensure nil
  :mode ("\\.css\\'" "\\.scss\\'" "\\.less\\'"))

(use-package js-ts-mode
  :ensure nil
  :mode ("\\.js\\'" "\\.mjs\\'" "\\.cjs\\'"))

(use-package tsx-ts-mode
  :ensure nil
  :mode ("\\.tsx\\'" "\\.ts\\'" "\\.mts\\'" "\\.cts\\'")
  :hook (tsx-ts-mode . eglot-ensure))

(use-package json-ts-mode
  :ensure nil
  :mode ("\\.json\\'" "\\.jsonc\\'"))

;; ─── Emmet: HTML/CSS 快速展开 ─────────────────────────────────────────
(use-package emmet-mode
  :ensure t
  :hook ((web-mode html-mode css-ts-mode) . emmet-mode)
  :custom
  (emmet-move-cursor-between-quotes nil))

;; ─── Prettier: 代码格式化 (仅手动, C-c f) ────────────────────────────
(use-package prettier
  :ensure t
  :commands prettier-format
  :custom
  (prettier-mode-sync-file-path t))

;; ─── 统一格式化入口 ──────────────────────────────────────────────────
(defun my/format-buffer ()
  "格式化当前 buffer: eglot > prettier > indent-region"
  (interactive)
  (cond
   ;; 优先用 LSP 格式化
   ((and (bound-and-true-p eglot--managed-mode)
         (eglot-managed-p))
    (eglot-format))
   ;; JS/TS/CSS 用 prettier
   ((derived-mode-p 'js-ts-mode 'tsx-ts-mode 'css-ts-mode 'json-ts-mode)
    (prettier-format))
   (t
    (indent-region (point-min) (point-max))
    (message "Indented region (no formatter found)"))))

;; ─── dtrt-indent: 自动检测文件缩进风格 ──────────────────────────────
(use-package dtrt-indent
  :ensure t
  :hook ((prog-mode . dtrt-indent-mode)
         (web-mode . dtrt-indent-mode)))

;; ─── Rainbow Mode: CSS 颜色值高亮 ────────────────────────────────────
(use-package rainbow-mode
  :ensure t
  :hook ((css-ts-mode html-mode web-mode) . rainbow-mode))

(provide 'init-web)
