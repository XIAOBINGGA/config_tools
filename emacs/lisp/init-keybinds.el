;;; init-keybinds.el --- 全局快捷键绑定

(setq-default cursor-type 'box)

;; ─── Which-Key 中文描述 ─────────────────────────────────────────────
(when (require 'which-key nil 'noerror)
  (which-key-add-key-based-replacements
    ;; 前缀分组
    "C-c f"     "文件搜索 (find / ripgrep / fd)"
    "C-c p"     "项目管理 (projectile)"
    "C-c g"     "Git (magit)"
    "C-c l"     "LSP (eglot)"
    "C-c j"     "跳转 (avy)"
    ;; 单个快捷键
    "C-c C-c"   "Flutter: 启动 run"
    "C-c C-r"   "Flutter: 热重载"
    "C-c C-R"   "Flutter: 热重启"
    "C-c C-n"   "下一个错误"
    "C-c C-p"   "上一个错误"
    "C-c \\"    "格式化 (eglot / prettier)"
    "C-c i"     "缩进同步 (dtrt-indent)"
    "C-c r"     "正则替换"
    "C-c R"     "普通替换"
    "C-c q"     "重启 Emacs"
    "C-c w"     "只保留当前窗口"
    "C-c o"     "切换窗口"
    "C-c +"     "放大字体"
    "C-c -"     "缩小字体"
    "C-c 0"     "重置字体大小"
    "C-c C-b"   "切换粗体"
    "C-c g t"   "Git 行信息开关"
    "C-c s"     "内容搜索 (deadgrep)"
    "M-s"       "保存文件"
    "M-&"       "项目搜索 (projectile-grep)"
    "M-^"       "内容搜索 (deadgrep)"
    ;; 方向键
    "M-i"       "左移字符"
    "M-o"       "右移字符"
    "M-j"       "上一行"
    "M-k"       "下一行"
    "M-h"       "左移单词"
    "M-l"       "右移单词"
    "M-u"       "上一段落"
    "M-d"       "下一段落"))

;; ─── Buffer / 窗口操作 ──────────────────────────────────────────────
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x C-k") 'kill-this-buffer)
(global-set-key (kbd "C-c w") 'delete-other-windows)
(global-set-key (kbd "C-c o") 'other-window)
(global-set-key (kbd "M-s") 'save-buffer)

;; ─── 方向键: 用 M-i/o/j/k 替代方向键 ────────────────────────────────
(global-set-key (kbd "M-i") 'backward-char)
(global-set-key (kbd "M-o") 'forward-char)
(global-set-key (kbd "M-j") 'previous-line)
(global-set-key (kbd "M-k") 'next-line)
(global-set-key (kbd "M-h") 'backward-word)
(global-set-key (kbd "M-l") 'forward-word)
(global-set-key (kbd "M-u") 'backward-paragraph)
(global-set-key (kbd "M-d") 'forward-paragraph)

;; ─── 编译/错误导航 ──────────────────────────────────────────────────
(global-set-key (kbd "C-c C-n") 'next-error)
(global-set-key (kbd "C-c C-p") 'previous-error)

;; ─── 格式化 ──────────────────────────────────────────────────────────
(global-set-key (kbd "C-c \\") 'my/format-buffer)

;; ─── 缩进同步 ────────────────────────────────────────────────────────
(global-set-key (kbd "C-c i") (lambda ()
                                (interactive)
                                (dtrt-indent-set-language-mode)
                                (message "dtrt-indent: sync indent from file")))

;; ─── 用 Backspace 作为帮助键 ────────────────────────────────────────
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))

;; ─── 搜索 ────────────────────────────────────────────────────────────
(global-set-key (kbd "M-&") 'projectile-grep)
(global-set-key (kbd "M-^") 'deadgrep)

;; ─── 替换 ────────────────────────────────────────────────────────────
(global-set-key (kbd "C-c r") 'query-replace-regexp)
(global-set-key (kbd "C-c R") 'query-replace)

;; ─── 杂项 ────────────────────────────────────────────────────────────
(global-set-key (kbd "C-c q") 'restart-emacs)
(global-set-key (kbd "C-c g t") 'my/toggle-diff-hl)
(global-set-key (kbd "C-c C-b") 'my/toggle-bold)

;; ─── 字体缩放 ────────────────────────────────────────────────────────
(global-set-key (kbd "C-c +") 'text-scale-increase)
(global-set-key (kbd "C-c -") 'text-scale-decrease)
(global-set-key (kbd "C-c 0") 'text-scale-adjust)

(provide 'init-keybinds)
