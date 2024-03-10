import 'package:flutter/material.dart';

import '../../base/style/base_chart_x_scale_style.dart';

///Created by jdz on 2024/3/2 0002 22:38
///@brief 图表底部刻度线默认样式
class ChartBottomScaleDefStyle extends BaseChartXScaleStyle {
  ChartBottomScaleDefStyle(
      {super.width,
      super.height,
      super.color,
      super.showLabel,
      super.labelPadding,
      super.showOut,
      super.labelAlign = Alignment.center,
      required super.labelStyle});
}
