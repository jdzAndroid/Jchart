import 'package:flutter/cupertino.dart';

import '../../base/data/base_content_data.dart';

///Created by jdz on 2024/3/6 8:44
///@brief 曲线图数据
class CurveChartData extends BaseContentData {
  double x;
  double y;
  Color? shaderStartColor;
  Color? shaderEndColor;
  String? label;
  bool? showLabel;
  TextStyle? labelStyle;
  double? labelPaddingBottom;

  CurveChartData(
      {required this.x,
      required this.y,
      this.shaderStartColor,
      this.shaderEndColor,
      this.label,
      this.showLabel,
      this.labelStyle,
      this.labelPaddingBottom});
}
