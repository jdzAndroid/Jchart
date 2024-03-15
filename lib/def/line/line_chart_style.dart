import 'dart:ui';

import '../../base/style/base_chart_content_style.dart';
import '../../enum/line_type_enum.dart';

///Created by jdz on 2024/3/10 0010 21:42
///@brief 折线图样式
class LineChartStyle extends BaseChartContentStyle {
  ///线条类型
  LineTypeEnum? lineType;

  ///虚线实体部分宽度
  double? width;

  ///虚线虚体部分宽度
  double? dashWidth;

  ///线条粗细
  double? lineSize;
  Color? lineColor;
  Color? dashColor;

  bool? showCircle;
  double? circleRadius;
  double? circleStrokeRadius;
  PaintingStyle? circleStyle;
  Color? circleColor;
  Color? circleStrokeColor;
  Color? circleSelColor;
  Color? circleStrokeSelColor;
  bool? supportSel;

  LineChartStyle(
      {this.lineType,
      this.width,
      this.dashWidth,
      this.lineSize,
      this.lineColor,
      this.dashColor,
      this.showCircle,
      this.circleRadius,
      this.circleStrokeRadius,
      this.circleStyle,
      this.circleColor,
      this.circleStrokeColor,
      this.circleSelColor,
      this.circleStrokeSelColor,
      this.supportSel});
}
