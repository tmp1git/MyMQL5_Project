#property copyright "Copyright 2024"
#property strict

enum ENUM_SIGNAL_TYPE
{
   SIGNAL_NONE,
   SIGNAL_BUY,
   SIGNAL_SELL
};

class ISignal
{
public:
   virtual ~ISignal() {}
   virtual ENUM_SIGNAL_TYPE CheckSignal(string symbol, ENUM_TIMEFRAMES tf) = 0;
};
