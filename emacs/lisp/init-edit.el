;;; init-edit.el --- 编辑增强: 括号 / 多光标 / which-key / helpful

;; ─── Expand Region: 逐级扩大选中区域 ────────────────────────────────
(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))

;; ─── Multiple Cursors: 多光标编辑 ────────────────────────────────────
(use-package multiple-cursors
  :ensure t
  :bind (("C-c C-c" . mc/edit-lines)           ;; 多行编辑
         ("C-c >"   . mc/mark-next-like-this)   ;; 选中下一个相同词
         ("C-c <"   . mc/mark-previous-like-this)
         ("C-c *"   . mc/mark-all-like-this)))  ;; 全选相同词

;; ─── Which Key: 快捷键提示 ────────────────────────────────────────────
(use-package which-key
  :ensure t
  :init (which-key-mode)
  :custom
  (which-key-idle-delay 0.5)
  (which-key-idle-secondary-delay 0.05))

;; ─── Avy: 快速跳转到可视字符 ────────────────────────────────────────
(use-package avy
  :ensure t
  :bind (("C-c j j" . avy-goto-char)         ;; 跳转到指定字符
         ("C-c j w" . avy-goto-word-1)        ;; 跳转到单词开头
         ("C-c j l" . avy-goto-line)          ;; 跳转到行首
         ("C-c j S" . avy-goto-char-2)        ;; 二字符序列跳转
         ("C-c j d" . avy-pop-mark))          ;; 返回上一个跳转位置
  :custom
  (avy-background t)                           ;; 跳转时高亮背景
  (avy-all-windows 'all-frames))               ;; 所有窗口/框架可跳

;; ─── Helpful: 更好的帮助面板 ─────────────────────────────────────────
(use-package helpful
  :ensure t
  :bind (("C-h f" . helpful-callable)
         ("C-h v" . helpful-variable)
         ("C-h k" . helpful-key)
         ("C-h x" . helpful-command)))

(provide 'init-edit)
