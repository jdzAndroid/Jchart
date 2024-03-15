import 'package:flutter/material.dart';
import 'package:jchart/def/chart_global_config.dart';

import '../../helper/chart_helper.dart';
import '../../enum/line_type_enum.dart';
import 'base_chart_decoration_style.dart';

///Created by jdz on 2024/2/28 0028 23:11
///@brief 图表XY坐标轴刻度样式基类
abstract class BaseChartScaleStyle extends BaseChartDecorationStyle {
  ///是否显示刻度值
  bool showLabel;

  ///标签文本对齐方式
  Alignment labelAlign = Alignment.center;

  ///标签文本样式
  late TextStyle labelStyle;

  GetLabel? getLabel;

  ///用于设置标签值的内间距
  EdgeInsets labelPadding;

  ///标签值是否显示在刻度线外围
  bool showOut = true;

  BaseChartScaleStyle({super.color,
    this.showLabel = true,
      this.labelAlign = Alignment.center,
      TextStyle? labelStyle,
      this.getLabel,
      this.labelPadding = EdgeInsets.zero,
      this.showOut = true,
      super.lineWidth,
      super.lineHeight = ChartGlobalConfig.lineDefSize,
      super.lineType = LineTypeEnum.line,
      super.dashWidth,
      super.dashColor}) {
    this.labelStyle = labelStyle ??
        const TextStyle(
            fontSize: ChartGlobalConfig.fontSize,
            color: ChartGlobalConfig.fontColor);
  }
}
