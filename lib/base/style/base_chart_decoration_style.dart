import 'dart:ui';

import 'package:jchart/def/chart_global_config.dart';

import '../../enum/line_type_enum.dart';
import 'base_chart_style.dart';

///Created by jdz on 2024/3/3 0003 11:24
///@brief 图表周边UI样式基类
abstract class BaseChartDecorationStyle extends BaseChartStyle {
  ///线条宽度，当是虚线的时候，表示线条实体部分宽度，如果为空且是实线的时候，则线条的宽度为填充剩余可用宽度
  double? lineWidth;

  ///线条高度
  double lineHeight;

  ///线条类型
  LineTypeEnum lineType;

  ///虚线虚体部分宽度
  double? dashWidth;

  ///用于绘制虚线，表述虚线部分线条颜色
  Color? dashColor;

  BaseChartDecorationStyle(
      {super.color,
      this.lineWidth,
      this.lineHeight = ChartGlobalConfig.lineDefSize,
      this.lineType = LineTypeEnum.line,
      this.dashWidth,
      this.dashColor});
}
