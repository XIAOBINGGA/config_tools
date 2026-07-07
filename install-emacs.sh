#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
EMACS_SRC="$REPO_DIR/emacs"
EMACS_DST="$HOME/.emacs.d"

echo ">>> 部署 Emacs 配置到 WSL"

if [ ! -d "$EMACS_SRC" ]; then
  echo "错误: 找不到 $EMACS_SRC" >&2
  exit 1
fi

if [ -L "$EMACS_DST" ]; then
  TARGET="$(readlink "$EMACS_DST")"
  if [ "$TARGET" = "$EMACS_SRC" ]; then
    echo "✓ $EMACS_DST 已指向 $EMACS_SRC，无需操作"
    exit 0
  else
    echo "! $EMACS_DST 是符号链接，但指向 $TARGET"
    echo "  删除旧链接..."
    rm "$EMACS_DST"
  fi
elif [ -e "$EMACS_DST" ]; then
  echo "! $EMACS_DST 已存在，备份为 ${EMACS_DST}.bak"
  mv "$EMACS_DST" "${EMACS_DST}.bak"
fi

ln -s "$EMACS_SRC" "$EMACS_DST"
echo "✓ 已创建符号链接: $EMACS_DST -> $EMACS_SRC"
