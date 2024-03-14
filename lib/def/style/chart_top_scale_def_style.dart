import 'package:flutter/material.dart';

import '../../base/style/base_chart_x_scale_style.dart';
import '../../line_type_enum.dart';
import '../chart_global_config.dart';

///Created by jdz on 2024/3/2 0002 22:38
///@brief 图表顶部刻度线默认样式
class ChartTopScaleDefStyle extends BaseChartXScaleStyle {
  ChartTopScaleDefStyle({super.color,
      super.showLabel = true,
      super.labelAlign = Alignment.center,
      TextStyle? labelStyle,
      super.getLabel,
      super.labelPadding = EdgeInsets.zero,
      super.showOut = true,
      super.lineWidth,
      super.lineHeight = ChartGlobalConfig.lineDefSize,
      super.lineType = LineTypeEnum.line,
      super.dashWidth,
      super.dashColor});
}
