import 'package:flutter/material.dart';

import 'base_chart_scale_style.dart';

///Created by jdz on 2024/2/29 13:23
///@brief 图表Y轴刻度样式基类
class BaseChartYScaleStyle extends BaseChartScaleStyle {
  ///刻度线起始Y坐标
  double? startY;

  BaseChartYScaleStyle(
      {this.startY = 0,
      super.width,
      super.height,
      super.color,
      super.labelPadding,
      super.showLabel,
      super.showOut,
      super.labelAlign = Alignment.center,
      required super.labelStyle});
}
