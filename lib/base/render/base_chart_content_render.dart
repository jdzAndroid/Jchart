import 'package:flutter/material.dart';

import '../../def/bar/bar_chart_data.dart';
import '../data/base_draw_info.dart';
import '../style/base_chart_content_style.dart';
import 'base_chart_render.dart';

///Created by jdz on 2024/3/6 9:03
///@brief 图表内容绘制
abstract class BaseChartContentRender<
    STYLE extends BaseChartContentStyle,
    INFO extends BaseDrawInfo,
    DATA extends BarChartData> extends BaseChartRender<STYLE, INFO, DATA> {
  List<ChartUIInfo<DATA>> uiInfoList = List.empty(growable: true);

  BaseChartContentRender(
      {required super.dataList, required super.style});

  ///图表点击回调
  bool hitTestSelf(Offset offset);
}

///用于描述图表绘制数据
class ChartUIInfo<DATA extends BarChartData> {
  DATA data;
  Rect rect;
  int position;

  ChartUIInfo({required this.data, required this.rect, required this.position});
}
