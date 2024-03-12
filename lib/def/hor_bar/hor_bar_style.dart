import 'package:flutter/material.dart';

import '../../base/style/base_chart_content_style.dart';
import '../../helper/chart_helper.dart';

///Created by jdz on 2024/3/12 8:59
///@brief 横向柱状图样式
class HorBarStyle extends BaseChartContentStyle {
  Color startColor;
  Color endColor;
  GetLabel2? getLabel;
  bool showLabel;
  TextStyle labelTextStyle;
  EdgeInsets labelPadding;
  bool labelLeft;
  PaintingStyle barStyle;
  Radius barLeftRadius;
  Radius barRightRadius;

  ///当柱子为空心的时候，表示边框粗细
  double strokeWidth = 0;

  HorBarStyle({this.getLabel,
      this.showLabel = false,
      required this.labelTextStyle,
      required this.startColor,
      required this.endColor,
      this.labelPadding = EdgeInsets.zero,
      this.barLeftRadius = Radius.zero,
      this.barRightRadius = Radius.zero,
      this.labelLeft = true,
      this.strokeWidth = 0,
      this.barStyle = PaintingStyle.fill});
}
