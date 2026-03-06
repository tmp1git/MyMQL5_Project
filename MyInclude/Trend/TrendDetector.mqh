#ifndef TREND_DETECTOR_MQH
#define TREND_DETECTOR_MQH

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
// ボリンジャーバンド幅を計算 (MQL5版)
// ---------------------------------------------
double GetBBWidth(string symbol, ENUM_TIMEFRAMES tf, int period = 20, double deviation = 2.0)
{
   int handle = iBands(symbol, tf, period, 0, deviation, PRICE_CLOSE);
   if(handle == INVALID_HANDLE) return 0;

   double upper[], lower[], mid[];
   ArraySetAsSeries(upper, true);
   ArraySetAsSeries(lower, true);
   ArraySetAsSeries(mid, true);

   if(CopyBuffer(handle, 1, 0, 1, upper) <= 0) return 0;
   if(CopyBuffer(handle, 2, 0, 1, lower) <= 0) return 0;
   if(CopyBuffer(handle, 0, 0, 1, mid) <= 0) return 0;

   IndicatorRelease(handle); // 使い捨ての場合はリリース

   if(mid[0] == 0) return 0;
   return (upper[0] - lower[0]) / mid[0];
}

// ---------------------------------------------
// MA の角度を計算 (MQL5版)
// ---------------------------------------------
double GetMAAngle(string symbol, ENUM_TIMEFRAMES tf, int period = 50)
{
   int handle = iMA(symbol, tf, period, 0, MODE_EMA, PRICE_CLOSE);
   if(handle == INVALID_HANDLE) return 0;

   double buffer[];
   ArraySetAsSeries(buffer, true);
   if(CopyBuffer(handle, 0, 0, 2, buffer) < 2) return 0;

   IndicatorRelease(handle);

   double diff = buffer[0] - buffer[1];
   return MathArctan(diff / _Point) * 180.0 / M_PI; // Pointsベースで角度計算
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
   ZeroMemory(info);
   
   // ADX
   int adxHandle = iADX(symbol, tf, 14);
   if(adxHandle != INVALID_HANDLE)
   {
      double adxBuffer[];
      if(CopyBuffer(adxHandle, 0, 0, 1, adxBuffer) > 0)
         info.adx = adxBuffer[0];
      IndicatorRelease(adxHandle);
   }

   // BBWidth
   info.bbWidth = GetBBWidth(symbol, tf);

   // MA Angle
   info.maAngle = GetMAAngle(symbol, tf);

   // トレンド判定
   bool adxTrend   = info.adx > adxThreshold;
   bool bbTrend    = info.bbWidth > bbThreshold;
   bool angleTrend = MathAbs(info.maAngle) > angleThreshold;

   info.isTrend = (adxTrend && bbTrend && angleTrend);
   info.isRange = (!info.isTrend);

   return info;
}

#endif
