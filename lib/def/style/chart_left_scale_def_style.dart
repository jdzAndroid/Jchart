import 'package:flutter/material.dart';

import '../../base/style/base_chart_y_scale_style.dart';
import '../../enum/line_type_enum.dart';
import '../chart_global_config.dart';

///Created by jdz on 2024/3/2 0002 22:38
///@brief 图表左边刻度线默认样式
class ChartLeftScaleDefStyle extends BaseChartYScaleStyle {
  ChartLeftScaleDefStyle({super.color,
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
