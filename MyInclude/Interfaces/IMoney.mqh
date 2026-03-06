#property copyright "Copyright 2024"
#property strict

class IMoney
{
public:
   virtual ~IMoney() {}
   virtual double GetLotSize(string symbol, double riskPoints) = 0;
};
