;;; init-elisp.el --- Emacs Lisp 开发环境

;; ─── Elisp 模式 ───────────────────────────────────────────────────────
(use-package elisp-mode
  :ensure nil
  :mode ("\\.el\\'")
  :hook ((emacs-lisp-mode . (lambda ()
                              (setq-local show-trailing-whitespace nil)))
         (emacs-lisp-mode . checkdoc-minor-mode)   ;; 文档检查
         (emacs-lisp-mode . flymake-mode))         ;; 实时语法/编译检查
  :config
  (define-key emacs-lisp-mode-map (kbd "C-c C-c") 'eval-defun)         ;; 求值当前函数
  (define-key emacs-lisp-mode-map (kbd "C-c C-b") 'eval-buffer)        ;; 求值整个 buffer
  (define-key emacs-lisp-mode-map (kbd "C-c C-k") 'eval-current-defun))

;; ─── Macrostep: 交互式宏展开 ─────────────────────────────────────────
(use-package macrostep
  :ensure t
  :bind (:map emacs-lisp-mode-map ("C-c e" . macrostep-expand)))

;; ─── Elisp Demos: 帮助中显示示例代码 ────────────────────────────────
(use-package elisp-demos
  :ensure t
  :after helpful
  :hook (helpful-mode . elisp-demos-advice-helpful))

;; ─── ERT: Emacs 测试框架 ──────────────────────────────────────────────
(use-package ert
  :ensure nil
  :commands (ert ert-run-tests-interactively)
  :bind (:map emacs-lisp-mode-map ("C-c t" . ert)))

;; ─── Nameless: 省略包名前缀 ─────────────────────────────────────────
(use-package nameless
  :ensure t
  :hook (emacs-lisp-mode . nameless-mode)
  :custom
  (nameless-prefix "λ")
  (nameless-private-prefix "--"))

(provide 'init-elisp)
