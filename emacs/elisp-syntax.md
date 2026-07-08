# Elisp 语法速查

## 1. 注释

```elisp
;; 行注释，从分号到行尾
;; 约定：;; 段落注释，;;; 章节标题，; 行尾短注
```

## 2. 原子类型

```elisp
42                  ;; 整数
3.14                ;; 浮点数
"hello"             ;; 字符串
t nil               ;; 布尔：真 / 假
'foo                ;; 符号（symbol）
#'my-function       ;; 函数引用（通知编译器，用于词法作用域优化）
nil                 ;; 空列表 = 空值 = 假
```

## 3. 列表 / S-表达式

```elisp
;; 一切代码都是列表：(函数名 参数1 参数2 ...)
(+ 1 2)             ;; → 3
(message "hi")

;; 引用——阻止求值
(quote (1 2 3))     ;; → (1 2 3)
'(1 2 3)            ;; 同上，' 是 quote 的语法糖
```

## 4. 变量

```elisp
(setq x 42)                          ;; 赋值，可多个：(setq a 1 b 2)
(defvar my/var 10 "文档字符串")        ;; 定义变量（仅首次赋值）
(defconst PI 3.14 "常量")             ;; 定义常量
(let ((a 1) (b 2)) (+ a b))          ;; 局部绑定，返回最后表达式值 → 3
(let* ((a 1) (b (* a 2))) b)         ;; let* 后面的可引用前面的 → 2
```

## 5. 函数

```elisp
(defun add (x y)
  "返回 x + y"
  (+ x y))

(add 3 4)                               ;; → 7

;; 匿名函数
(mapcar (lambda (n) (* n 2)) '(1 2 3))   ;; → (2 4 6)
(funcall (lambda (x) (* x x)) 5)          ;; → 25
```

## 6. 交互函数

```elisp
(defun my/say-hello ()
  (interactive)                         ;; 可被 M-x 调用
  (message "Hello"))

(defun my/greet (name)
  (interactive "sName: ")               ;; 从 minibuffer 读参数，"s" = 字符串
  (message "Hello, %s" name))
```

## 7. 条件

```elisp
(when t (message "总是执行"))
(unless nil (message "也执行"))

(if (> x 0)
    (message "正数")
  (message "零或负数"))

(cond
  ((> x 0) "正")
  ((< x 0) "负")
  (t       "零"))                        ;; t = 默认分支

(and t nil)       ;; → nil，全真才真
(or nil 42)       ;; → 42，返回第一个真值
```

## 8. 循环

```elisp
(dotimes (i 3) (message "%d" i))          ;; 输出 0 1 2
(dolist (item '(a b c)) (message "%s" item)) ;; 遍历列表
(while (> n 0) (setq n (- n 1)))          ;; 条件为真时重复
```

## 9. 列表操作

```elisp
(cons 1 '(2 3))         ;; → (1 2 3)  头部插入
(list 1 2 3)            ;; → (1 2 3)  构造新列表
(car '(1 2 3))          ;; → 1       取头部
(cdr '(1 2 3))          ;; → (2 3)   取尾部
(mapcar #'upcase '("a" "b"))    ;; → ("A" "B")
(push 'x my-list)       ;; 添加到列表头部
(add-to-list 'my-list 'x)       ;; 头部添加，若已存在则跳过
(length '(a b c))        ;; → 3
```

## 10. 字符串操作

```elisp
(concat "hello" " " "world")   ;; → "hello world"
(format "x=%d y=%s" 42 "hi")   ;; → "x=42 y=hi"
(string-match "foo" "barfoo")   ;; → 3（匹配位置），无匹配返回 nil
```

## 11. 相等判断

```elisp
(eq 'a 'a)             ;; → t   同对象（符号/数字用）
(equal "a" "a")        ;; → t   内容相等（字符串/列表用）
(string= "a" "a")      ;; → t   专门用于字符串
(null nil)              ;; → t   判断是否为 nil
```

## 12. 关联列表 (alist)

```elisp
(setq alist '((:name . "Tom") (:age . 18)))    ;; 点对
(assoc :name alist)                              ;; → (:name . "Tom")
(cdr (assoc :name alist))                        ;; → "Tom"
```

## 13. 属性列表 (plist)

```elisp
(setq plist '(:name "Tom" :age 18))    ;; 键值交替
(plist-get plist :name)                 ;; → "Tom"
```

## 14. 错误处理

```elisp
(ignore-errors
  (/ 1 0))              ;; 忽略错误，返回 nil

(condition-case err
    (/ 1 0)
  (error (message "出错了: %s" (error-message-string err))))
```

## 15. Hook（钩子）

```elisp
;; Hook 是存放回调函数的列表变量，命名约定: xxx-hook / xxx-functions
(add-hook 'minibuffer-setup-hook #'my/on-minibuffer)     ;; 注册
(remove-hook 'minibuffer-setup-hook #'my/on-minibuffer)  ;; 移除
```

## 16. Keymap（快捷键绑定）

```elisp
(global-set-key (kbd "C-c x") #'my/function)          ;; 全局绑定
(define-key some-mode-map (kbd "C-c x") #'my/fn)      ;; 模式内绑定
(kbd "C-c x")       ;; 人读按键 → Emacs 内部表示
;;   C-c → Ctrl+c    M-x → Alt+x    S-TAB → Shift+Tab
```

## 17. Use-Package（包管理宏）

```elisp
(use-package magit
  :ensure t                     ;; 自动安装
  :defer t                      ;; 延迟加载，首次使用时才触发
  :hook (prog-mode . magit-mode)    ;; 绑定 hook
  :bind ("C-c g" . magit-status)   ;; 绑定快捷键
  :commands (magit-status)     ;; 声明可延迟加载的命令
  :custom
  (magit-auto-revert-mode nil) ;; (setq 变量 值) 等价写法
  :config                       ;; 包加载后才执行
  (message "magit loaded"))
```

## 18. 文件与目录

```elisp
(expand-file-name "lisp" "~/.emacs.d")    ;; → "~/.emacs.d/lisp"
(file-name-directory "/a/b/c.el")         ;; → "/a/b/"
(file-exists-p "/path/to/file")            ;; → t/nil
(make-directory "/path" t)                 ;; t = 自动创建父目录
(load-file "/path/to/config.el")           ;; 加载执行文件
(require 'feature)                         ;; 加载 feature（自动找 load-path，不重复）
```

## 19. Buffer 与文本编辑

```elisp
(with-current-buffer "*scratch*"          ;; 临时切换 buffer
  (insert "hello"))

(point)                                   ;; 当前光标位置（整数）
(point-min)  (point-max)                  ;; buffer 起点 / 终点
(goto-char 1)                             ;; 移动光标
(buffer-substring 1 10)                   ;; 取文本片段
(region-active-p)                         ;; 是否有选区
(region-beginning) (region-end)           ;; 选区起止点
```

## 20. 常用判定

```elisp
(boundp 'my-var)                         ;; 变量是否已定义
(fboundp 'my-fn)                          ;; 函数是否已定义
(bound-and-true-p my-var)                 ;; 已定义且非 nil → 值，否则 → nil
(derived-mode-p 'prog-mode)               ;; 当前 mode 是否继承自 prog-mode
(display-graphic-p)                       ;; 是否为图形界面
(eq major-mode 'emacs-lisp-mode)          ;; 当前 major mode
```

## 21. 输出 / 调试

```elisp
(message "x = %d" 42)      ;; 输出到 *Messages* buffer
(princ "hello")             ;; 输出（不自动换行）
(error "fatal error")       ;; 抛出错误
(y-or-n-p "continue?")      ;; y/n 确认
```

## 核心逻辑

| 概念 | 说明 |
|------|------|
| 一切皆列表 | `(函数 参数...)` 就是代码，`'(1 2)` 就是数据 |
| 最后表达式为返回值 | 不需要 `return` 关键字 |
| 变量作用域 | 默认动态绑定，用 `let` 做局部绑定 |
| Hook 是核心扩展机制 | 几乎所有自定义都通过 `add-hook` 注入行为 |
| `provide` / `require` | 模块化机制，`require` 不会重复加载 |
