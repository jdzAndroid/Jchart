import 'package:flutter/material.dart';

import '../data/base_data.dart';
import '../data/base_draw_info.dart';
import '../style/base_chart_style.dart';

///Created by jdz on 2024/2/28 0028 22:51
///@brief 图表渲染基类
abstract class BaseChartRender<STYLE extends BaseChartStyle,
    INFO extends BaseDrawInfo, DATA extends BaseData> {
  List<DATA> dataList;
  late INFO info;
  STYLE style;
  Paint paint = Paint();

  BaseChartRender({required this.dataList, required this.style});

  ///绘制
  ///@param rect 绘制区域
  ///@param contentRect 图表绘制区域
  void draw(PaintingContext context, Rect rect, Rect contentRect);
}
