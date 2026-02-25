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
#define PERIOD_M2 2
#define PERIOD_M3 3
#define PERIOD_M4 4
#define PERIOD_M5 5
#define PERIOD_M6 6
#define PERIOD_M10 10
#define PERIOD_M12 12
#define PERIOD_M15 15
#define PERIOD_M20 20
#define PERIOD_M30 30
#define PERIOD_H1 16385
#define PERIOD_H2 16386
#define PERIOD_H3 16387
#define PERIOD_H4 16388
#define PERIOD_H6 16390
#define PERIOD_H8 16392
#define PERIOD_H12 16396
#define PERIOD_D1 16408
#define PERIOD_W1 32769
#define PERIOD_MN1 49153



#define POSITION_TYPE_BUY 0
#define POSITION_TYPE_SELL 1
#define ORDER_TYPE_BUY 0
#define ORDER_TYPE_SELL 1



#define MODE_OPEN 0
#define MODE_LOW 1
#define MODE_HIGH 2
#define MODE_CLOSE 3
#define MODE_VOLUME 4
#define MODE_REAL_VOLUME 7
#define MODE_SPREAD 6



typedef int ENUM_APPLIED_PRICE;
typedef int ENUM_MA_METHOD;

// 5. 標準関数の「形」だけを定義（iBands や Print）
void Print(string text, ...);
void printf(string format, ...);
double iBands(string symbol, int timeframe, int period, double deviation, int bands_shift, int applied_price, int mode, int shift);

#endif