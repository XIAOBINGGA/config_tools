;; ─── 基础路径 ──────────────────────────────────────────────────────────
(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))

;; ─── 添加 lisp/ 到加载路径 ────────────────────────────────────────────
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; ─── 依次加载各个模块 ──────────────────────────────────────────────────
(require 'settings)          ;; 用户可配置项 (字体/主题/开关等)
(require 'init-packages)     ;; 包管理器 & use-package 配置
(require 'init-basic)        ;; 基础编辑设置 (备份/行号/自动恢复等)
(require 'init-ui)           ;; 界面: 字体/主题/状态栏/括号高亮
(require 'init-completion)   ;; 补全: vertico + consult + corfu + orderless
(require 'init-edit)         ;; 编辑增强: 括号/多光标/which-key/helpful
(require 'init-lsp)          ;; LSP: eglot + eldoc
(require 'init-web)          ;; Web 开发: web-mode / ts-ts / prettier / dtrt-indent
(require 'init-flutter)      ;; Flutter 开发: dart-mode / 热重载
(require 'init-elisp)        ;; Emacs Lisp 开发: macrostep / nameless / ert
(require 'init-project)      ;; 项目管理: projectile / deadgrep / dired
(require 'init-git)          ;; Git: magit / diff-hl / forge / blamer
(require 'init-keybinds)     ;; 快捷键绑定

;; ─── 启动完成后恢复 GC ─────────────────────────────────────────────────
(setq gc-cons-threshold 16777216
      gc-cons-percentage 0.1)

;; ─── 放开 narrow-to-region ─────────────────────────────────────────────
(put 'narrow-to-region 'disabled nil)
