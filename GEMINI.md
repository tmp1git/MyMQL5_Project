# MQL5 Project Guidelines

このプロジェクトは、MetaTrader 5 (MT5) 向けの MQL5 プログラムを開発するためのワークスペースです。

## 開発環境のアーキテクチャ (Windows Host との対応関係)

開発は Linux コンテナ（Dev Container）上で行われ、作成したソースコードは `sync.sh` を介して Windows ホスト側の MT5 データフォルダに同期されます。

### 構成図とパスの対応
```text
[ Dev Container (Linux) ]              [ Windows Host (MT5 Data Folder) ]
/workspaces/MyMQL5_Project/            C:\...\MQL5\ (Windows Path)
                                       /mnt/mt5_mql5/ (Linux Mount Path)
├─ MyExperts/      ───── sync.sh ────>  ├─ Experts/
│                                       │   └─ MyExperts/
├─ MyInclude/      ───── sync.sh ────>  ├─ Include/
│                                       │   └─ MyInclude/
├─ MyIndicators/   ───── sync.sh ────>  ├─ Indicators/
│                                       │   └─ MyIndicators/
└─ MyScripts/      ───── sync.sh ────>  └─ Scripts/
                                            └─ MyScripts/

[ Backtest / Logs ]
/mnt/mt5_tester/    <────────────────>  C:\...\Tester\ (Windows Path)
```

### パスに関する重要な注意
- **ソースの原本:** すべて `/workspaces/MyMQL5_Project/` 配下の `My...` フォルダ内にあります。編集はこの原本に対して行ってください。
- **MT5 データフォルダ:** Windows 側の MT5 データフォルダは、コンテナ内の `/mnt/mt5_mql5/` にマウントされています。
- **テスターフォルダ:** バックテスト結果やログ（`Logs`, `files` フォルダなど）は、`/mnt/mt5_tester/` にマウントされています。バックテストの分析やデバッグログの確認が必要な場合は、このディレクトリ内を参照してください。
- **デプロイ:** コードの変更を MT5 に反映させるには、`./sync.sh` を実行して原本を `/mnt/mt5_mql5/` 以下の適切なサブディレクトリへ同期する必要があります。
- **参照パス:** MQL5 プログラム内で `#include` などを使用する際は、原本のディレクトリ構造（例: `<MyInclude/Common/Utils.mqh>`）に基づいたパス指定を行ってください。

## MQL5 Documentation Reference


MQL5 の言語仕様、関数、標準ライブラリに関するリファレンスは以下のディレクトリに格納されています。
開発やデバッグを行う際は、必要に応じてこれらのファイルを読み込み、公式の仕様に基づいた実装を行ってください。

- **リファレンスディレクトリ:** `docs/mql5_ref/`
- **セクション別リファレンス:** `docs/mql5_ref/sections/`
  - `01_Trade_Functions.txt`: 売買操作に関連する関数
  - `02_Indicator_Functions.txt`: インジケータ関連
  - `03_Timeseries_Access.txt`: 時系列データへのアクセス
  - `04_Standard_Library.txt`: 標準ライブラリ (MQL5 Standard Library)
  - `05_Custom_Indicators.txt`: カスタムインジケータ
  - `06_Chart_Operations.txt`: チャート操作
  - `07_Common_Functions.txt`: 共通関数群

## 開発ルール

- **コードスタイル:** 既存の `MyInclude/` や `MyExperts/` 内のコードスタイルを継承してください。
- **モジュール化:** `MyInclude/Interfaces/` で定義されたインターフェース（`ISignal`, `IMoney`, `ITrailing`）に基づいたモジュール開発を優先してください。
- **検証:** MQL5 特有の挙動（ティックごとの処理や時系列データの同期など）については、リファレンスを確認し、正しいエラーハンドリングを含めてください。
