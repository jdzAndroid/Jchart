import 'package:flutter/material.dart';

import '../../helper/chart_helper.dart';
import 'base_chart_decoration_style.dart';

///Created by jdz on 2024/2/28 0028 23:11
///@brief 图表XY坐标轴刻度样式基类
abstract class BaseChartScaleStyle extends BaseChartDecorationStyle {
  ///是否显示刻度值
  bool? showLabel;

  ///标签文本对齐方式
  Alignment labelAlign = Alignment.center;

  ///标签文本样式
  TextStyle labelStyle;

  GetLabel? getLabel;

  ///用于设置标签值的内间距
  EdgeInsets? labelPadding;

  ///标签值是否显示在刻度线外围
  bool showOut = true;

  BaseChartScaleStyle(
      {super.width,
      super.height,
      super.color,
      this.showLabel,
      this.labelAlign = Alignment.center,
      required this.labelStyle,
      this.getLabel,
      this.labelPadding,
      this.showOut = true});
}
