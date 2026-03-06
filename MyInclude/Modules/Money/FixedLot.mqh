#property copyright "Copyright 2024"
#property strict

#include <MyInclude/Interfaces/IMoney.mqh>

class CFixedLot : public IMoney
{
private:
   double m_lots;

public:
   CFixedLot(double lots) : m_lots(lots) {}
   virtual double GetLotSize(string symbol, double riskPoints) { return m_lots; }
};
