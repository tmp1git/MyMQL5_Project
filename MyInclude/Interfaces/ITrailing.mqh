#property copyright "Copyright 2024"
#property strict
#include <Trade/PositionInfo.mqh>

class ITrailing
{
public:
   virtual ~ITrailing() {}
   virtual void ProcessTrailing(CPositionInfo &pos) = 0;
};
