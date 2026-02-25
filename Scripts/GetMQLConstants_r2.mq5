void OnStart()
{
   Print("--- 辞書用一括出力開始 ---");
   // --- ENUM_CHART_EVENT ---
   // Add your ENUM_CHART_EVENT values here if needed.


   // --- ENUM_TIMEFRAMES (主要どころ) ---
   ENUM_TIMEFRAMES tf[] = {PERIOD_CURRENT, PERIOD_M1, PERIOD_M5, PERIOD_M15, PERIOD_H1, PERIOD_D1};
   Print("// --- ENUM_TIMEFRAMES ---");
   for(int i=0; i<ArraySize(tf); i++) 
      printf("#define %s %d", EnumToString(tf[i]), (int)tf[i]);

   // --- ENUM_POSITION_TYPE ---
   ENUM_POSITION_TYPE pos[] = {POSITION_TYPE_BUY, POSITION_TYPE_SELL};
   Print("// --- ENUM_POSITION_TYPE ---");
   for(int i=0; i<ArraySize(pos); i++) 
      printf("#define %s %d", EnumToString(pos[i]), (int)pos[i]);

   // --- ENUM_APPLIED_PRICE ---
   ENUM_APPLIED_PRICE pr[] = {PRICE_CLOSE, PRICE_OPEN, PRICE_HIGH, PRICE_LOW, PRICE_MEDIAN, PRICE_TYPICAL, PRICE_WEIGHTED};
   Print("// --- ENUM_APPLIED_PRICE ---");
   for(int i=0; i<ArraySize(pr); i++) 
      printf("#define %s %d", EnumToString(pr[i]), (int)pr[i]);

   Print("--- 辞書用一括出力終了 ---");
}