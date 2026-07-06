;;; init-completion.el --- 补全体系: vertico + consult + corfu + orderless

;; ─── Vertico: minibuffer 补全 UI ──────────────────────────────────────
(use-package vertico
  :ensure t
  :init (vertico-mode)
  :custom
  (vertico-cycle t)      ;; 滚动到底部后回到顶部
  (vertico-count 15))    ;; 显示条目数

;; ─── Marginalia: minibuffer 注解 ──────────────────────────────────────
(use-package marginalia
  :ensure t
  :init (marginalia-mode))

;; ─── Consult: 搜索/跳转/文件查找 ──────────────────────────────────────
(use-package consult
  :ensure t
  :bind (("C-s"        . consult-line)       ;; 行搜索
         ("C-x b"      . consult-buffer)     ;; 切换 buffer
         ("C-x C-f"    . consult-fd)         ;; 快速文件查找 (fd)
         ("C-c f f"    . consult-find)       ;; find 搜索 (可配忽略)
         ("C-c f g"    . consult-ripgrep)    ;; ripgrep 内容搜索
         ("C-c f d"    . consult-fd)         ;; fd 搜索
         ("C-c f l"    . consult-git-grep)   ;; git grep
         ("M-y"        . consult-yank-pop)   ;; 剪贴板历史
         ("C-c k"      . consult-kmacro))    ;; 键盘宏管理
  :custom
  (consult-preview-key 'any)
  (consult-narrow-key "<")
  ;; consult-find 忽略 node_modules 等目录
  (consult-find-args "find . -not ( -path */node_modules -prune ) -not ( -path */.git -prune ) -not ( -path */vendor -prune ) -not ( -path */.next -prune ) -not ( -path */dist -prune ) -not ( -path */build -prune ) -not ( -path */__pycache__ -prune ) -not ( -path */.cache -prune )")
  :config
  ;; ripgrep 也忽略相同目录
  (consult-customize
   consult-ripgrep consult-git-grep consult-grep
   :rg-args '("--hidden" "--no-ignore-parent"
              "--glob" "!.git" "--glob" "!node_modules"
              "--glob" "!vendor" "--glob" "!dist"
              "--glob" "!build" "--glob" "!.next"
              "--glob" "!__pycache__" "--glob" "!.cache")))

;; ─── Embark: 上下文操作 (C-. = 操作菜单) ──────────────────────────────
(use-package embark
  :ensure t
  :bind (("C-." . embark-act)
         ("C-;" . embark-dwim))
  :config
  (setq embark-prompter 'embark-keymap-prompter))

(use-package embark-consult
  :ensure t
  :hook (embark-collect-mode . consult-preview-at-point-mode))

;; ─── Orderless: 模糊匹配 (空格分隔多关键字) ─────────────────────────
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; ─── Corfu: 行内补全弹窗 ──────────────────────────────────────────────
(use-package corfu
  :ensure t
  :init (global-corfu-mode)
  :custom
  (corfu-auto t)                ;; 自动弹出
  (corfu-auto-delay 0.2)        ;; 延迟 0.2s
  (corfu-auto-prefix 2)          ;; 最少 2 字符触发
  (corfu-separator ?\s)          ;; 空格分隔多词补全
  (corfu-preview-current nil)
  (corfu-min-width 30)
  (corfu-max-width 100)
  (corfu-commit-predicate nil)
  :bind (:map corfu-map
              ("SPC" . corfu-insert-separator)
              ("RET" . nil)))   ;; 回车不提交 (避免误触发)

;; ─── Cape: 额外补全后端 ───────────────────────────────────────────────
(use-package cape
  :ensure t
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)     ;; 关键词补全
  (add-to-list 'completion-at-point-functions #'cape-file)        ;; 文件路径
  (add-to-list 'completion-at-point-functions #'cape-elisp-symbol) ;; Elisp 符号
  (add-to-list 'completion-at-point-functions #'cape-keyword))    ;; 关键字

(provide 'init-completion)
