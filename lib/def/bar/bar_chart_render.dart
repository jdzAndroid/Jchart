import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import '../../base/data/base_draw_info.dart';
import '../../base/render/base_chart_content_render.dart';
import '../../helper/chart_helper.dart';
import '../chart_global_config.dart';
import 'bar_chart_data.dart';
import 'bar_chart_style.dart';

///Created by jdz on 2024/3/6 8:39
///@brief 柱状图
class BarChartRender
    extends BaseChartContentRender<BarChartStyle, BaseDrawInfo, BarChartData> {
  BarChartRender({required super.dataList, required super.style});

  @override
  void draw(PaintingContext context, Rect rect, Rect contentRect) {
    printLog(
        message:
            "left=${rect.left},top=${rect.top},right=${rect.right},bottom=${rect.bottom}",
        methodName: "draw");
    if (dataList.isEmpty) {
      printLog(message: "没有数据", methodName: "draw");
      return;
    }
    int position = dataList.length;
    double perW = (rect.width) / (info.xMax - info.xMin + 1);
    double perH = rect.height / (info.yMax - info.yMin + 1);
    Radius topRadius;
    Radius bottomRadius;
    Color startColor = ChartGlobalConfig.barColor;
    Color endColor = ChartGlobalConfig.barColor;
    paint.style = PaintingStyle.fill;
    paint.isAntiAlias = true;
    double wRadius = ChartGlobalConfig.barRadius;
    uiInfoList.clear();
    for (int i = 0; i < position; i++) {
      BarChartData itemData = dataList[i];
      if (itemData.xValue < info.xMin || itemData.xValue > info.xMax) {
        continue;
      }
      if (itemData.startValue > itemData.endValue ||
          itemData.startValue < info.yMin ||
          itemData.endValue > info.yMax) {
        continue;
      }
      wRadius = itemData.radius ?? style.radius ?? ChartGlobalConfig.barRadius;
      wRadius = min(wRadius, 1);
      double left = rect.left + (itemData.xValue - info.xMin) * perW;
      double top = rect.top + (info.yMax - itemData.endValue);
      double bottom = rect.bottom - (itemData.startValue - info.yMin) * perH;
      left += (1 - wRadius) * perW / 2;
      double right = left + perW * wRadius;
      bottom -= (1 - wRadius) * perW / 2;
      Rect itemRect = Rect.fromLTRB(left, top, right, bottom);
      uiInfoList.add(ChartUIInfo(data: itemData, rect: itemRect, position: i));
      startColor =
          itemData.startColor ?? style.startColor ?? ChartGlobalConfig.barColor;
      endColor =
          itemData.endColor ?? style.endColor ?? ChartGlobalConfig.barColor;
      if (startColor == endColor) {
        paint.shader = null;
        paint.color = startColor;
      } else {
        paint.shader = ui.Gradient.linear(
            Offset(rect.left + rect.width / 2, rect.bottom),
            Offset(rect.left + rect.width / 2, rect.top),
            [startColor, endColor],
            [0, 1],
            TileMode.clamp);
        paint.color = startColor;
      }
      topRadius = itemData.topRadius ?? style.topRadius ?? Radius.zero;
      bottomRadius = itemData.bottomRadius ?? style.bottomRadius ?? Radius.zero;
      context.canvas.drawRRect(
          RRect.fromLTRBAndCorners(left, top, right, bottom,
              topLeft: topRadius,
              topRight: topRadius,
              bottomLeft: bottomRadius,
              bottomRight: bottomRadius),
          paint);
    }
  }
}
