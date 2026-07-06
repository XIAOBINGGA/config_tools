;;; init-flutter.el --- Flutter 开发: dart-mode / 热重载 / 调试

;; ─── Flutter SDK 路径 ────────────────────────────────────────────────
(setq flutter-sdk-path (expand-file-name "~/soft/apps/flutter"))
(when (file-exists-p flutter-sdk-path)
  (setenv "PATH" (concat (file-name-as-directory flutter-sdk-path) "bin:"
                         (getenv "PATH")))
  (add-to-list 'exec-path (expand-file-name "bin" flutter-sdk-path)))

;; ─── Dart Mode ────────────────────────────────────────────────────────
(use-package dart-mode
  :ensure t
  :mode ("\\.dart\\'")
  :hook (dart-mode . eglot-ensure)
  :config
  (define-key dart-mode-map (kbd "C-c C-c") 'my/flutter-run)
  (define-key dart-mode-map (kbd "C-c C-r") 'my/flutter-hot-reload)
  (define-key dart-mode-map (kbd "C-c C-R") 'my/flutter-hot-restart))

;; ─── Flutter 自定义命令 ──────────────────────────────────────────────
(defvar my/flutter-process nil "当前 Flutter 运行进程")

(defun my/flutter-run ()
  "启动 flutter run"
  (interactive)
  (when (and my/flutter-process
             (process-live-p my/flutter-process))
    (delete-process my/flutter-process))
  (let ((default-directory (project-root (project-current t))))
    (setq my/flutter-process
          (start-process "flutter-run" "*flutter-run*"
                         (expand-file-name "bin/flutter" flutter-sdk-path)
                         "run"))
    (message "Flutter run started")))

(defun my/flutter-hot-reload ()
  "发送热重载信号 (R) 到 flutter 进程"
  (interactive)
  (if (and my/flutter-process (process-live-p my/flutter-process))
      (progn
        (process-send-string my/flutter-process "r")
        (message "Hot reload triggered"))
    (message "No flutter process running")))

(defun my/flutter-hot-restart ()
  "发送热重启信号 (R) 到 flutter 进程"
  (interactive)
  (if (and my/flutter-process (process-live-p my/flutter-process))
      (progn
        (process-send-string my/flutter-process "R")
        (message "Hot restart triggered"))
    (message "No flutter process running")))

(defun my/flutter-test ()
  "运行 flutter test"
  (interactive)
  (let ((default-directory (project-root (project-current t))))
    (compile (format "%s test" (expand-file-name "bin/flutter" flutter-sdk-path)))))

(defun my/flutter-build ()
  "运行 flutter build"
  (interactive)
  (let ((default-directory (project-root (project-current t))))
    (compile (format "%s build" (expand-file-name "bin/flutter" flutter-sdk-path)))))

(provide 'init-flutter)
