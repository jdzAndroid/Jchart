import 'package:flutter/material.dart';

import '../../base/data/base_content_data.dart';

///Created by jdz on 2024/3/6 8:44
///@brief 柱状图数据
class BarChartData extends BaseContentData {
  double xValue;
  double startValue;
  double endValue;
  Color? startColor;
  Color? endColor;

  ///如果柱状图顶部显示圆角，则表示圆角角度
  Radius? topRadius;

  ///如果柱状图底部显示圆角，则表示圆角角度
  Radius? bottomRadius;

  ///表示X轴左边平均分配(pW)后，柱状图宽度相对于平均宽度(pW)的占比
  double? radius;

  BarChartData(
      {required this.xValue,
      required this.startValue,
      required this.endValue,
      this.startColor,
      this.endColor,
      this.topRadius,
      this.bottomRadius,
      this.radius,
      super.supportSel});
}
