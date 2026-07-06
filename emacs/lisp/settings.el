;;; settings.el --- 用户可配置项, 修改后重启 Emacs 生效

;; ─── 字体 ──────────────────────────────────────────────────────────────
(defvar my/enable-bold t "是否默认加粗")
(defvar my/font-size-hidpi 16 "HiDPI 屏幕字体大小 (>= 1920px 宽)")
(defvar my/font-size-normal 14 "普通屏幕字体大小")
(defvar my/english-font "Ubuntu Mono" "英文字体")
(defvar my/cjk-font "Noto Sans CJK SC" "中文字体")

;; ─── 主题 ──────────────────────────────────────────────────────────────
(defvar my/theme 'doom-gruvbox-light "Emacs 主题 (符号)")

;; ─── 界面 ──────────────────────────────────────────────────────────────
(defvar my/line-spacing 0.2 "行间距")
(defvar my/display-line-numbers t "是否显示行号")

;; ─── Git ───────────────────────────────────────────────────────────────
(defvar my/diff-hl-enabled nil "是否默认启用 git 行信息 (diff-hl)")

(provide 'settings)
