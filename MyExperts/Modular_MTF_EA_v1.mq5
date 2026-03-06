#property copyright "Copyright 2024"
#property strict

// --- インクルード ---
#include <Trade/Trade.mqh>
#include <Trade/PositionInfo.mqh>
#include <MyInclude/Modules/Signals/MTFTrendSignal.mqh>
#include <MyInclude/Modules/Money/FixedLot.mqh>
#include <MyInclude/Modules/Trailing/NoTrailing.mqh>

// --- 入力パラメータ ---
input ENUM_TIMEFRAMES InpHigherTF = PERIOD_H4;     // 上位足（トレンド判定用）
input double         InpLotSize  = 0.1;           // 取引ロット
input int            InpStopLoss = 300;           // 損切り幅 (Points)
input int            InpTakeProfit = 600;         // 利確幅 (Points)
input int            InpMagic    = 123456;        // マジックナンバー

// --- グローバル変数 ---
ISignal*          signal;
IMoney*           money;
ITrailing*        trailing;
CTrade            trade;
CPositionInfo     posInfo;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
   // モジュールの生成
   signal   = new CMTFTrendSignal(InpHigherTF);
   money    = new CFixedLot(InpLotSize);
   trailing = new CNoTrailing();

   trade.SetExpertMagicNumber(InpMagic);

   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   // メモリ解放
   if(signal != NULL)   delete signal;
   if(money != NULL)    delete money;
   if(trailing != NULL) delete trailing;
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
   string symbol = _Symbol;
   ENUM_TIMEFRAMES tf = _Period;

   // 1. すでにポジションがあるかチェック（簡易的に1つのみ保持）
   if(PositionSelectByMagic(symbol, InpMagic))
   {
      // 2. トレーリングストップ等の処理
      if(posInfo.SelectByTicket(PositionGetTicket(0)))
      {
         trailing.ProcessTrailing(posInfo);
      }
      return;
   }

   // 3. シグナル確認
   ENUM_SIGNAL_TYPE sig = signal.CheckSignal(symbol, tf);

   if(sig == SIGNAL_NONE) return;

   // 4. ロット計算
   double lots = money.GetLotSize(symbol, InpStopLoss);

   // 5. エントリー実行
   double price = (sig == SIGNAL_BUY) ? SymbolInfoDouble(symbol, SYMBOL_ASK) : SymbolInfoDouble(symbol, SYMBOL_BID);
   double sl = (sig == SIGNAL_BUY) ? price - InpStopLoss * _Point : price + InpStopLoss * _Point;
   double tp = (sig == SIGNAL_BUY) ? price + InpTakeProfit * _Point : price - InpTakeProfit * _Point;

   if(sig == SIGNAL_BUY)
   {
      trade.Buy(lots, symbol, price, sl, tp, "Modular EA Buy");
   }
   else if(sig == SIGNAL_SELL)
   {
      trade.Sell(lots, symbol, price, sl, tp, "Modular EA Sell");
   }
}

// --- ユーティリティ ---
bool PositionSelectByMagic(string symbol, long magic)
{
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket))
      {
         if(PositionGetString(POSITION_SYMBOL) == symbol && PositionGetInteger(POSITION_MAGIC) == magic)
            return true;
      }
   }
   return false;
}
