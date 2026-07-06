# config_tools
常用工具的配置文件仓库，通过符号链接部署到 `$HOME`。

## 已管理的配置

| 工具 | 路径 | 链接目标 |
|------|------|----------|
| Emacs | `emacs/` | `~/.emacs.d` |

## 使用方式

首次部署执行：
```bash
ln -sf $PWD/emacs ~/.emacs.d
```

新增工具配置时，在本仓库创建对应目录，然后将家目录的原始配置替换为符号链接：
```bash
mv ~/.xxx ~/.xxx.bak
ln -s $PWD/xxx ~/.xxx
```
