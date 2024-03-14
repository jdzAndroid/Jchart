import 'package:flutter/material.dart';

import '../../def/chart_global_config.dart';
import '../../line_type_enum.dart';
import 'base_chart_scale_style.dart';

///Created by jdz on 2024/2/29 13:23
///@brief 图表Y轴刻度样式基类
class BaseChartYScaleStyle extends BaseChartScaleStyle {
  BaseChartYScaleStyle({super.color,
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
