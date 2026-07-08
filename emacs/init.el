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
(require 'init-keybinds)     ;; 快捷键绑定

;; 延迟加载 (非关键模块, 减少 startup 时间)
;; (add-hook 'emacs-startup-hook
;;           (lambda ()
;;             (require 'init-lsp)
;;             (require 'init-web)
;;             (require 'init-flutter)
;;             (require 'init-elisp)
;;             (require 'init-project)
;;             (require 'init-git)))

;; ─── 启动完成后恢复 GC ─────────────────────────────────────────────────
(setq gc-cons-threshold 16777216
      gc-cons-percentage 0.1)

;; ─── 交互操作时临时提高 GC 阈值, 避免卡顿 ──────────────────────────────
(defun my/set-gc-high ()
  (setq gc-cons-threshold most-positive-fixnum
        gc-cons-percentage 0.6))

(defun my/reset-gc ()
  (setq gc-cons-threshold 16777216
        gc-cons-percentage 0.1))

(add-hook 'minibuffer-setup-hook #'my/set-gc-high)
(add-hook 'minibuffer-exit-hook #'my/reset-gc)

;; ─── 放开 narrow-to-region ─────────────────────────────────────────────
(put 'narrow-to-region 'disabled nil)
