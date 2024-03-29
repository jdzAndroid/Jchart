import 'package:flutter/material.dart';

import '../../base/style/base_chart_content_style.dart';

///Created by jdz on 2024/3/6 8:52
///@brief 柱状图样式
class BarChartStyle extends BaseChartContentStyle {
  Color startColor;
  Color endColor;
  Radius? topRadius;
  Radius? bottomRadius;

  ///表示X轴左边平均分配(pW)后，柱状图宽度相对于平均宽度(pW)的占比
  double? radius;

  BarChartStyle({required this.startColor,
    required this.endColor,
      super.chartClick,
      this.topRadius,
      this.bottomRadius,
      this.radius});
}
