;;; init-lsp.el --- LSP 集成: eglot + eldoc

;; ─── Eglot: Emacs 内置 LSP 客户端 ─────────────────────────────────────
(use-package eglot
  :ensure t
  :hook ((js-ts-mode . eglot-ensure)             ;; JavaScript
         (tsx-ts-mode . eglot-ensure)            ;; TypeScript
         (typescript-ts-mode . eglot-ensure)
         (css-ts-mode . eglot-ensure)            ;; CSS
         (html-mode . eglot-ensure)              ;; HTML
         (elixir-ts-mode . eglot-ensure)         ;; Elixir
          (go-ts-mode . eglot-ensure)            ;; Go
          (dart-mode . eglot-ensure))            ;; Dart/Flutter
  :custom
  (eglot-autoshutdown t)                         ;; 无 buffer 时关闭 LSP
  (eglot-confirm-server-initiated-edits nil)
  (eglot-extend-to-xref t)
  (eglot-ignored-server-capabilities '(:inlayHintProvider))
  :bind (:map eglot-mode-map
              ("C-c l a" . eglot-code-actions)    ;; code actions
              ("C-c l r" . eglot-rename)          ;; 重命名
              ("C-c l f" . eglot-format)          ;; 格式化
              ("C-c l h" . eldoc-doc-buffer)      ;; 文档
              ("C-c l d" . xref-find-definitions)  ;; 跳转定义
              ("C-c l R" . xref-find-references))) ;; 引用查找

;; ─── Eldoc: 回显区文档提示 ──────────────────────────────────────────
(use-package eldoc
  :ensure nil
  :hook (prog-mode . eldoc-mode)
  :custom
  (eldoc-echo-area-use-multiline-p nil)
  (eldoc-documentation-strategy 'eldoc-documentation-compose-eagerly))

(provide 'init-lsp)
