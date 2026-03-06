# MQL5 マルチタイムフレーム・トレンドEA 設計書 (Modular-MTF EA)

## 1. 目的
マルチタイムフレーム（MTF）でのトレンド判定をベースとし、シグナル、資金管理、エグジット戦略を容易に差し替え・組み合わせ可能な、拡張性の高いEAアーキテクチャを構築する。

## 2. アーキテクチャ概要
オブジェクト指向（OOP）を採用し、各機能をインターフェース（抽象クラス）として定義する。これにより、ロジックの変更時に本体（EAコア）を修正することなく、モジュールの差し替えのみで試行錯誤が可能になる。

### 全体構成図
```text
[ EA Main (.mq5) ]
       |
       v
[ CEABase (Core Engine) ]
       |
       +--- [ ISignal ] (シグナル判定)
       |        |-- CMTFTrendSignal (MTFトレンド)
       |        |-- CRsiSignal (RSI反転など)
       |
       +--- [ IMoneyManagement ] (ロット計算)
       |        |-- CFixedLot (固定ロット)
       |        |-- CRiskPercent (リスク%計算)
       |
       +--- [ ITrailing ] (エグジット管理)
       |        |-- CNoTrailing (なし)
       |        |-- CTrailingATR (ATR追従)
       |
       +--- [ CTrade ] (標準ライブラリ: 取引実行)
```

## 3. 各モジュールの詳細

### 3.1. EA Core (`CEABase`)
- **役割**: MetaTrader 5 のイベント（OnTick, OnInit等）を受け取り、各モジュールを調整してトレードを実行する。
- **主要メソッド**:
    - `Run()`: 毎チック呼び出され、シグナル確認 -> ロット計算 -> エントリー実行 -> トレイル実行のフローを制御。

### 3.2. Signal Module (`ISignal`)
- **役割**: エントリー（買い・売り）およびエグジットの判断を行う。
- **MTFトレンド実装 (`CMTFTrendSignal`)**:
    - 上位足（例: H4/D1）でトレンド方向を確認。
    - 下位足（例: M15/H1）で押し目・戻り目を判定。
    - `TrendDetector.mqh` のロジックを活用。

### 3.3. Money Management Module (`IMoneyManagement`)
- **役割**: 取引数量（ロット数）を決定する。
- **実装例**:
    - `CFixedLot`: 常に 0.1 ロットなど。
    - `CRiskPercent`: 口座残高の 2% を損切り幅に合わせて計算。

### 3.4. Trailing Module (`ITrailing`)
- **役割**: 保有中のポジションのストップロス（SL）やテイクプロフィット（TP）を動的に更新する。
- **実装例**:
    - `CTrailingStop`: 一定ピップスでの追従。
    - `CTrailingATR`: ボラティリティに合わせた追従。

## 4. ディレクトリ構造案
```text
MyInclude/
├── Core/
│   └── EA_Base.mqh          // EAの基底クラス
├── Interfaces/
│   ├── ISignal.mqh          // シグナルのインターフェース
│   ├── IMoney.mqh           // 資金管理のインターフェース
│   └── ITrailing.mqh        // トレールのインターフェース
├── Modules/
│   ├── Signals/
│   │   └── MTFTrendSignal.mqh
│   ├── Money/
│   │   └── RiskPercent.mqh
│   └── Trailing/
│       └── ATRTrailing.mqh
└── Common/
    └── TrendDetector.mqh    // 既存のトレンド判定ロジック
```

## 5. 開発ロードマップ
1. **フェーズ1**: インターフェース（ISignal, IMoney, ITrailing）の定義。
2. **フェーズ2**: `CEABase` の実装（基本エントリーフロー）。
3. **フェーズ3**: `CMTFTrendSignal` の実装（既存ロジックのクラス化）。
4. **フェーズ4**: テスト用EA作成とバックテスト。
