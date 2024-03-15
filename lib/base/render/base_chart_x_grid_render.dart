import 'dart:math';

import 'package:flutter/material.dart';

import '../../helper/chart_helper.dart';
import '../data/base_chart_x_grid_data.dart';
import '../data/base_draw_info.dart';
import '../style/base_chart_x_grid_style.dart';
import 'base_chart_grid_render.dart';

///Created by jdz on 2024/2/28 0028 22:56
///@brief 图表X轴网格线绘制基类
class BaseChartXGridRender<STYLE extends BaseChartXGridStyle,
        INFO extends BaseDrawInfo, DATA extends BaseChartXGridData>
    extends BaseChartGridRender<STYLE, INFO, DATA> {
  BaseChartXGridRender();

  @override
  void draw(PaintingContext context, Rect rect, Rect contentRect) {
    if (dataList.isEmpty) {
      printLog(message: "X轴网格线数据为空，跳过绘制", methodName: "draw");
      return;
    }
    paint.style = PaintingStyle.fill;
    paint.isAntiAlias = true;

    double lineHeight = 0;
    double lineY = 0;
    double width = style.lineWidth ?? rect.width;

    double perHeight = rect.height / (info.yMax - info.yMin);

    for (var itemData in dataList) {
      paint.color = itemData.color ?? style.color ?? Colors.black;

      lineHeight = itemData.size ?? style.lineHeight ?? 1;

      paint.strokeWidth = lineHeight;
      if (style.getPosition != null) {
        lineY = style.getPosition!(itemData.value);
      } else {
        lineY = rect.bottom - perHeight * (itemData.value - info.yMin);
      }
      lineY = max(lineY, rect.top + lineHeight / 2);
      lineY = min(lineY, rect.bottom - 2 * lineHeight);

      context.canvas.drawLine(
          Offset(rect.left, lineY), Offset(rect.left + width, lineY), paint);
    }
  }

  @override
  Rect? getDrawArea() {
    return Rect.fromLTWH(0, 0, info.w, info.h);
  }
}
