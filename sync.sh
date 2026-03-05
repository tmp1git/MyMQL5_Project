#!/bin/bash

# 同期先（マウントポイント）
DEST_BASE="/mnt/mt5_mql5"

# 同期元（リポジトリ内）と同期先サブフォルダの定義
# format: "src_dir:dest_subdir"
# リポジトリ内のフォルダ名は MyExperts, MyInclude, MyIndicators, MyScripts
PATHS=(
    "MyExperts:Experts/MyExperts"
    "MyInclude:Include/MyInclude"
    "MyIndicators:Indicators/MyIndicators"
    "MyScripts:Scripts/MyScripts"
)

echo "Starting MQL5 synchronization..."

for entry in "${PATHS[@]}"; do
    SRC="${entry%%:*}"
    DEST_SUB="${entry#*:}"
    DEST_FULL="$DEST_BASE/$DEST_SUB"

    # 同期元ディレクトリの存在確認
    if [ ! -d "$SRC" ]; then
        echo "Warning: Source directory '$SRC' not found. Skipping."
        continue
    fi

    # 同期先ディレクトリの作成
    mkdir -p "$DEST_FULL"

    # 同期実行 (rsync を使用)
    # -a: アーカイブモード (属性保持)
    # -v: 冗長表示
    # --delete: 同期元にないファイルを同期先から削除
    # --exclude: 不要なファイルを同期対象外にする
    rsync -av --delete \
        --exclude=".git/" \
        --exclude=".vscode/" \
        "$SRC/" "$DEST_FULL/"
done

echo "Synchronization complete."
