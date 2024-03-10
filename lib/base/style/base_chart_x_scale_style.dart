import 'package:flutter/material.dart';

import 'base_chart_scale_style.dart';

///Created by jdz on 2024/2/29 13:13
///@brief 图表X轴刻度样式基类
class BaseChartXScaleStyle extends BaseChartScaleStyle {
  BaseChartXScaleStyle(
      {super.width,
      super.height,
      super.color,
      super.showLabel,
      super.labelPadding,
      super.showOut,
      super.labelAlign = Alignment.center,
      required super.labelStyle});
}
