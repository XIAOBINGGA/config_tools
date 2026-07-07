;;; init-packages.el --- 包管理器配置

;; ─── GNU / NONGNU / MELPA 源 ──────────────────────────────────────────
(require 'package)
(setq package-archives
      '(("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/packages/")
        ("melpa"  . "https://melpa.org/packages/"))
      ;; MELPA 优先级最高
      package-archive-priorities
      '(("melpa"  . 10)
        ("nongnu" . 5)
        ("gnu"    . 0)))
(setq package-quickstart t)
(package-initialize)

;; ─── 确保 use-package 已安装 ──────────────────────────────────────────
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; ─── use-package 默认行为: 自动安装 + 最小展开 ──────────────────────
(setq use-package-always-ensure t
      use-package-expand-minimally t)

(provide 'init-packages)
