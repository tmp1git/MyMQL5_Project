// mql5_defines.h - MQL5固有の定義をVSCodeに教えるための辞書
#ifndef MQL5_DEFINES_H
#define MQL5_DEFINES_H

// mql5_defines.h の冒頭に追加
typedef const char* string;
typedef long datetime;
typedef int color;
typedef unsigned char uchar;
#define input
#define sinput
#define group

// 1. 基本的なキーワードの無効化
//#define #property //
#define strict 1

// 2. 定数 (INIT系)
#define INIT_SUCCEEDED 0
#define INIT_FAILED 1

// 3. 価格・モード関連
#define PRICE_CLOSE 0
#define MODE_MAIN 0
#define MODE_UPPER 1
#define MODE_LOWER 2

// 4. 列挙型 (ENUM_TIMEFRAMES など)
typedef int ENUM_TIMEFRAMES;
#define PERIOD_CURRENT 0
#define PERIOD_M1 1
#define PERIOD_M5 5
#define PERIOD_M15 15
#define PERIOD_M30 30
#define PERIOD_H1 16385
#define PERIOD_D1 16408

typedef int ENUM_APPLIED_PRICE;
typedef int ENUM_MA_METHOD;

// 5. 標準関数の「形」だけを定義（iBands や Print）
void Print(string text, ...);
double iBands(string symbol, int timeframe, int period, double deviation, int bands_shift, int applied_price, int mode, int shift);

#endif