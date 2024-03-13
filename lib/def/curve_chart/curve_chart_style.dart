import 'package:flutter/material.dart';
import 'package:jchart/def/chart_global_config.dart';

import '../../base/style/base_chart_content_style.dart';
import '../../helper/chart_helper.dart';

///Created by jdz on 2024/3/6 8:52
///@brief 曲线图样式
class CurveChartStyle extends BaseChartContentStyle {
  Color? shaderStartColor;
  Color? shaderEndColor;
  bool showLabel;
  TextStyle labelStyle = const TextStyle(color: Colors.black, fontSize: 16);
  double labelPaddingBottom;
  GetLabel2? getLabel;
  double lineHeight;
  Color lineColor;

  CurveChartStyle(
      {this.shaderStartColor,
      this.shaderEndColor,
      this.showLabel = false,
      TextStyle? labelStyle,
      this.getLabel,
      this.lineColor = ChartGlobalConfig.lineDefColor,
      this.lineHeight = ChartGlobalConfig.lineDefSize,
      this.labelPaddingBottom = 0}) {
    this.labelStyle = labelStyle ?? this.labelStyle;
  }
}
