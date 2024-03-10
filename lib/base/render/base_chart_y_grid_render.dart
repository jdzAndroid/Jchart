import 'dart:math';

import 'package:flutter/material.dart';

import '../../def/chart_global_config.dart';
import '../../helper/chart_helper.dart';
import '../data/base_chart_y_grid_data.dart';
import '../data/base_draw_info.dart';
import '../style/base_chart_y_grid_style.dart';
import 'base_chart_grid_render.dart';

///Created by jdz on 2024/2/28 0028 22:58
///@brief 图表Y轴网格线绘制基类
class BaseChartYGridRender<STYLE extends BaseChartYGridStyle,
        INFO extends BaseDrawInfo, DATA extends BaseChartYGridData>
    extends BaseChartGridRender<STYLE, INFO, DATA> {
  BaseChartYGridRender({required super.dataList, required super.style});

  @override
  Rect? getDrawArea() {
    return Rect.fromLTWH(0, 0, info.w, info.h);
  }

  @override
  void draw(PaintingContext context, Rect rect, Rect contentRect) {
    if (dataList.isEmpty) {
      printLog(message: "X轴网格线数据为空，跳过绘制", methodName: "draw");
      return;
    }
    paint.style = PaintingStyle.fill;
    paint.isAntiAlias = true;

    double lineWidth = 0;
    double lineX = 0;
    double height = style.height ?? rect.height;
    double perWidth = rect.width / (info.xMax - info.xMin+1);

    for (var itemData in dataList) {
      if(itemData.value<info.xMin||itemData.value>info.xMax){
        continue;
      }
      paint.color =
          itemData.color ?? style.color ?? ChartGlobalConfig.lineDefColor;

      lineWidth = itemData.size ?? style.width ?? ChartGlobalConfig.lineDefSize;

      paint.strokeWidth = lineWidth;
      if (style.getPosition != null) {
        lineX = style.getPosition!(itemData.value);
      } else {
        lineX =
            rect.left + perWidth * (itemData.value - info.xMin+1);
      }
      lineX = min(lineX, rect.right - lineWidth);

      context.canvas.drawLine(
          Offset(lineX, rect.top), Offset(lineX, rect.top + height), paint);
    }
  }
}
