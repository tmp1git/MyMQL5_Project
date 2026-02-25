#pragma once

// ---------------------------------------------
// トレンド判定用の構造体
// ---------------------------------------------
struct TrendInfo
{
   bool   isTrend;        // トレンドか？
   bool   isRange;        // レンジか？
   double adx;            // ADX 値
   double bbWidth;        // ボリンジャーバンド幅
   double maAngle;        // MA の角度
};

// ---------------------------------------------
// ボリンジャーバンド幅を計算
// ---------------------------------------------
double GetBBWidth(string symbol, ENUM_TIMEFRAMES tf, int period = 20, double deviation = 2.0)
{
   double upper = iBands(symbol, tf, period, deviation, 0, PRICE_CLOSE, MODE_UPPER, 0);
   double lower = iBands(symbol, tf, period, deviation, 0, PRICE_CLOSE, MODE_LOWER, 0);
   double mid   = iBands(symbol, tf, period, deviation, 0, PRICE_CLOSE, MODE_MAIN, 0);

   if(mid == 0) return 0;
   return (upper - lower) / mid;
}

// ---------------------------------------------
// MA の角度を計算（度数法）
// ---------------------------------------------
double GetMAAngle(string symbol, ENUM_TIMEFRAMES tf, int period = 50)
{
   double ma_now  = iMA(symbol, tf, period, 0, MODE_EMA, PRICE_CLOSE, 0);
   double ma_prev = iMA(symbol, tf, period, 0, MODE_EMA, PRICE_CLOSE, 1);

   double diff = ma_now - ma_prev;
   return MathArctan(diff) * 180.0 / M_PI;
}

// ---------------------------------------------
// MTF トレンド判定（メイン関数）
// ---------------------------------------------
TrendInfo DetectTrend(string symbol,
                      ENUM_TIMEFRAMES tf,
                      double adxThreshold = 25.0,
                      double bbThreshold  = 0.02,
                      double angleThreshold = 3.0)
{
   TrendInfo info;
   
   // ADX
   info.adx = iADX(symbol, tf, 14, PRICE_CLOSE, MODE_MAIN, 0);

   // BBWidth
   info.bbWidth = GetBBWidth(symbol, tf);

   // MA Angle
   info.maAngle = GetMAAngle(symbol, tf);

   // トレンド判定
   bool adxTrend   = info.adx > adxThreshold;
   bool bbTrend    = info.bbWidth > bbThreshold;
   bool angleTrend = MathAbs(info.maAngle) > angleThreshold;

   info.isTrend = (adxTrend && bbTrend && angleTrend);

   // レンジ判定
   info.isRange = (!info.isTrend);

   return info;
}