import 'package:flutter/material.dart';

import '../../base/style/base_chart_y_scale_style.dart';

///Created by jdz on 2024/3/2 0002 22:38
///@brief 图表左边刻度线默认样式
class ChartLeftScaleDefStyle extends BaseChartYScaleStyle {
  ChartLeftScaleDefStyle(
      {super.startY = 0,
      super.width,
      super.height,
      super.color,
      super.labelPadding,
      super.showLabel,
      super.showOut,
      super.labelAlign = Alignment.center,
      required super.labelStyle});
}
