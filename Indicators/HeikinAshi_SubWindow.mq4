//+------------------------------------------------------------------+
//|                                         HeikinAshi_SubWindow.mq4 |
//|                        Copyright 2013, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2013, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_separate_window
#property indicator_buffers 2
#property indicator_color1 Red
#property indicator_color2 Blue
#property indicator_minimum 0
#property indicator_maximum 1

// 指標バッファ
double BufOpen[];
double BufClose[];
double BufUp[];
double BufDown[];

// 初期化関数
int init()
{
  IndicatorBuffers(4);

  // 指標バッファの割り当て
  SetIndexBuffer(0, BufUp);
  SetIndexBuffer(1, BufDown);
  SetIndexBuffer(2, BufOpen);
  SetIndexBuffer(3, BufClose);

  // 指標ラベルの設定
  SetIndexLabel(0, "Up");
  SetIndexLabel(1, "Down");

  // 指標スタイルの設定
  SetIndexStyle(0, DRAW_HISTOGRAM);
  SetIndexStyle(1, DRAW_HISTOGRAM);

  return(0);
}

int deinit()
{
  return(0);
}
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
{
  int limit = Bars - IndicatorCounted();

  for(int i = limit - 1; i >= 0; i--)
  {
    // 平均足の計算
    if(i == Bars - 1)
    {
      BufOpen[i] = (Open[i] + High[i] + Low[i] + Close[i]) / 4;
    }
    else
    {
      BufOpen[i] = (BufOpen[i + 1] + BufClose[i + 1]) / 2;
    }
    BufClose[i] = (Open[i] + High[i] + Low[i] + Close[i]) / 4;

    BufUp[i] = 0;
    BufDown[i] = 0;

    // セパレートウィンドウへの表示
    if(BufClose[i] > BufOpen[i])
    {
      BufUp[i] = 1;
    }
    else if(BufClose[i] < BufOpen[i])
    {
      BufDown[i] = 1;
    }
  }

  return(0);
}
//+------------------------------------------------------------------+
