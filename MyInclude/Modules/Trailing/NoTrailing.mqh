#property copyright "Copyright 2024"
#property strict

#include <MyInclude/Interfaces/ITrailing.mqh>

class CNoTrailing : public ITrailing
{
public:
   virtual void ProcessTrailing(CPositionInfo &pos) { /* 何もしない */ }
};
