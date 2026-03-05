# MQL5 Gemini Sandbox - MT5 × GitHub × AI 開発環境

## 概要
このプロジェクトは、**VS Code Dev Container** を活用し、MetaTrader 5 (MT5) の MQL5 開発をモダンなエンジニアリング手法（Git管理、AI連携）で行うためのサンドボックス環境です。

Windows 上の MT5 データフォルダをコンテナ内の `/mnt/mt5_mql5` に直接マウントし、リポジトリ内のソースコードを安全かつ迅速にデプロイできるワークフローを提供します。

## 開発環境のアーキテクチャ

### 構成図
```text
[ Windows Host ]                       [ Dev Container (Linux) ]
MT5 Data Folder (Windows Path)         /workspaces/MyMQL5_Project/ (Repository)
  └─ MQL5/                               ├─ MyExperts/
      ├─ Experts/                        ├─ MyInclude/
      │   └─ MyExperts/   <─── Sync ─────┤─ MyIndicators/
      ├─ Include/                        └─ MyScripts/
      │   └─ MyInclude/   <─── Sync ───┐
      ├─ Indicators/                   │
      │   └─ MyIndicators/ <── Sync ───┘
      └─ Scripts/
          └─ MyScripts/    <── Sync ───┘

※ Windows 側の MT5 データフォルダは、devcontainer.json により
   直接 /mnt/mt5_mql5 にマウントされています。
```

### フォルダ同期 (Sync)
リポジトリ内のコードを MT5 環境に反映させるには、以下のコマンドを実行します。
これにより、`/mnt/mt5_mql5` 配下の適切なフォルダへ同期されます。

```bash
# 同期スクリプトの実行 (rsync を使用)
./sync.sh
```

## 特徴
- **安全なソース管理**: MT5 の標準フォルダを直接汚さず、リポジトリ側でクリーンに管理。
- **直接マウント方式**: Junction 設定などの Windows 側の特殊な設定は不要。
- **Gemini (AI) 連携**: AI によるコード生成、リファクタリング、バックテスト分析をシームレスに実施。
- **IntelliSense 強化**: `mql5_defines.h` により、VS Code 上で高度なコード補完を実現。

## セットアップ

### 1. 前提条件
- Windows 11 (WSL2 / WSLg)
- Docker Desktop
- VS Code + Dev Containers 拡張機能

### 2. コンテナの起動
1. VS Code で本フォルダを開く。
2. `F1` -> `Dev Containers: Reopen in Container` を実行。
3. `devcontainer.json` の設定に従い、Windows 側の MT5 パスが `/mnt/mt5_mql5` に自動マウントされます。

> **Note**: `devcontainer.json` 内の `mounts` セクションにある `source` パスが、お使いの host 側の MT5 データフォルダのパスと一致しているか確認してください。

## プロジェクト構造
```text
/workspaces/MyMQL5_Project/
├── MyExperts/         # ソース原本（EA）
├── MyIndicators/      # ソース原本（インジケーター）
├── MyInclude/         # ソース原本（ライブラリ）
├── MyScripts/         # ソース原本（スクリプト）
├── .devcontainer/     # コンテナ環境設定
├── sync.sh            # MT5 への同期用スクリプト
├── mql5_defines.h     # VS Code 用 MQL5 辞書
└── README.md
```

## VS Code 設定
- **Files Association**: `*.mq5`, `*.mqh` を `cpp` に割り当て。
- **IntelliSense**: `mql5_defines.h` をインクルードパスに含めることで、MQL5 特有の関数や定数の補完を有効化。

## ライセンス
[MIT License](LICENSE)
