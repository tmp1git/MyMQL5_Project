# MQL5 Gemini Sandbox - MT5 × GitHub × AI 開発環境

## 概要
このプロジェクトは、**VS Code Dev Container** を活用し、MetaTrader 5 (MT5) の MQL5 開発をモダンなエンジニアリング手法（Git管理、AI連携）で行うためのサンドボックス環境です。

Windows 上の MT5 データフォルダをコンテナに直接マウントし、リポジトリ内のソースコードを安全に同期・デプロイするワークフローを提供します。

## 開発環境のアーキテクチャ
本環境は以下の 3 層構造で構成されています。

1.  **Repository Workspace (`/workspaces/...`)**: GitHub で管理されるソースコードの原本。
2.  **Dev Container (WSL2/Docker)**: Gemini CLI やブラウザ、ビルド環境が整った隔離環境。
3.  **MT5 Data Folder (`/mnt/mt5_mql5`)**: Windows 側の MT5 実行環境。コンテナに直接マウントされています。

### ファイル同期の流れ
1.  **開発**: リポジトリ内の `Experts/` や `Include/` でコーディング。
2.  **同期 (Sync)**: 開発したファイルを `/mnt/mt5_mql5` 内の適切なフォルダへコピー。
3.  **実行**: MT5 側で認識・コンパイル・テスト。

## 特徴
- **安全なソース管理**: MT5 の標準フォルダを直接汚さず、リポジトリ側でクリーンに管理。
- **Gemini (AI) 連携**: AI によるコード生成、リファクタリング、バックテスト分析をシームレスに実施。
- **WSLg サポート**: コンテナ内から Google Chrome 等を起動し、AI 認証やドキュメント参照が可能。
- **IntelliSense 強化**: `mql5_defines.h` により、VS Code 上で高度なコード補完を実現。

## セットアップ

### 1. 前提条件
- Windows 11 (WSL2 / WSLg)
- Docker Desktop
- VS Code + Dev Containers 拡張機能

### 2. コンテナの起動
1. VS Code で本フォルダを開く。
2. 右下の通知、または `F1` -> `Dev Containers: Reopen in Container` を実行。
3. `devcontainer.json` の設定に従い、Windows 側の MT5 パスが `/mnt/mt5_mql5` に自動マウントされます。

> **Note**: `devcontainer.json` 内の `mounts` セクションにある `source` パスが、お使いの MT5 データフォルダのパスと一致しているか確認してください。

## 同期 (Deploy) 方法
現在は手動、または簡単なコマンドで同期を行います。

```bash
# 例: EA を MT5 フォルダへ同期
cp Experts/EA_template.mq5 /mnt/mt5_mql5/Experts/My_Projects/
```

*(将来的に `npm run sync` や `make deploy` などの自動同期コマンドを実装予定)*

## プロジェクト構造
```text
/workspaces/MyMQL5_Project/
├── Experts/           # ソース原本（EA）
├── Indicators/        # ソース原本（インジケーター）
├── Include/           # ソース原本（ライブラリ）
├── .devcontainer/     # コンテナ環境設定
├── mql5_defines.h     # VS Code 用 MQL5 辞書
└── README.md
```

## VS Code 設定
- **Files Association**: `*.mq5`, `*.mqh` を `cpp` に割り当て。
- **IntelliSense**: `mql5_defines.h` をインクルードパスに含めることで、MQL5 特有の関数や定数の補完を有効化。

## ライセンス
[MIT License](LICENSE)
