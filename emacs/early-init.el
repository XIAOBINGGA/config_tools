;; ─── 性能: 启动时最大化 GC 阈值, 避免频繁 GC ──────────────────────────
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; ─── 禁用包自动初始化 (由 init-packages.el 手动管理) ─────────────────
(setq package-enable-at-startup nil)

;; ─── 隐藏菜单栏/工具栏/滚动条 ─────────────────────────────────────────
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars . nil) default-frame-alist)

;; ─── 窗口性能优化, 静默 native-comp 警告 ──────────────────────────────
(setq frame-inhibit-implied-resize t
      native-comp-async-report-warnings-errors 'silent)
