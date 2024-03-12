import 'package:flutter/material.dart';

import '../../base/data/base_content_data.dart';

///Created by jdz on 2024/3/12 8:58
///@brief 横向柱状图数据
class HorBarData extends BaseContentData {
  Color? startColor;
  Color? endColor;
  double yValue;
  double xStartValue;
  double xEndValue;
  double? heightRadius;
  String? label;
  bool? showLabel;
  TextStyle? labelTextStyle;
  EdgeInsets? labelPadding;
  Radius? barLeftRadius;
  Radius? barRightRadius;
  bool? labelLeft;
  PaintingStyle? barStyle;

  ///当柱子为空心的时候，表示边框粗细
  double? strokeWidth;

  HorBarData(
      {this.startColor,
      this.endColor,
      required this.yValue,
      required this.xStartValue,
      required this.xEndValue,
      this.heightRadius,
      this.label,
      this.showLabel,
      this.labelTextStyle,
      this.labelPadding,
      this.barLeftRadius,
      this.barRightRadius,
      this.strokeWidth,
      this.labelLeft,
      this.barStyle});
}
