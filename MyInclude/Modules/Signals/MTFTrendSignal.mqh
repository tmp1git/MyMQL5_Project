#property copyright "Copyright 2024"
#property strict

#include <MyInclude/Interfaces/ISignal.mqh>
#include <MyInclude/Trend/TrendDetector.mqh>

class CMTFTrendSignal : public ISignal
{
private:
   ENUM_TIMEFRAMES m_higherTF;
   double          m_adxThreshold;

public:
   CMTFTrendSignal(ENUM_TIMEFRAMES higherTF, double adxThreshold = 25.0)
      : m_higherTF(higherTF), m_adxThreshold(adxThreshold) {}

   virtual ENUM_SIGNAL_TYPE CheckSignal(string symbol, ENUM_TIMEFRAMES tf)
   {
      // 1. 上位足のトレンド確認
      TrendInfo higherTrend = DetectTrend(symbol, m_higherTF, m_adxThreshold);
      if(!higherTrend.isTrend) return SIGNAL_NONE;

      // 2. 現在の足のトレンド確認
      TrendInfo currentTrend = DetectTrend(symbol, tf, m_adxThreshold);
      
      if(currentTrend.isTrend)
      {
         // MAの角度で方向を判定
         if(currentTrend.maAngle > 0 && higherTrend.maAngle > 0) return SIGNAL_BUY;
         if(currentTrend.maAngle < 0 && higherTrend.maAngle < 0) return SIGNAL_SELL;
      }

      return SIGNAL_NONE;
   }
};
