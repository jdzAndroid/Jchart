import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:jchart/helper/chart_helper.dart';

import '../../base/data/base_draw_info.dart';
import '../../base/render/base_chart_content_render.dart';
import 'curve_chart_data.dart';
import 'curve_chart_style.dart';

///Created by jdz on 2024/3/6 8:39
///@brief 曲线图
class CurveChartRender extends BaseChartContentRender<CurveChartStyle,
    BaseDrawInfo, CurveChartData> {
  CurveChartRender({required super.dataList, required super.style});

  @override
  void draw(PaintingContext context, Rect rect, Rect contentRect) {
    uiInfoList.clear();
    if (dataList.isEmpty) {
      printLog(message: "贝塞尔曲线图数据为空，跳过绘制");
      return;
    }
    paint.style = PaintingStyle.fill;
    paint.isAntiAlias = true;
    List<Color?> shaderStartColor = List.generate(2, (index) => null);
    List<Color?> shaderEndColor = List.generate(2, (index) => null);
    List<String?> label = List.generate(2, (index) => null);
    List<bool> showLabel = List.generate(2, (index) => false);
    List<TextStyle?> labelStyle = List.generate(2, (index) => null);
    List<double?> labelPaddingBottom = List.generate(2, (index) => null);
    List<double> locationX = List.generate(2, (index) => -1);
    List<double> locationY = List.generate(2, (index) => -1);
    double perW = rect.width / (info.xMax - info.xMin);
    double perH = rect.height / (info.yMax - info.yMin);
    Path itemPath = Path();
    for (int index = 0; index < dataList.length; index++) {
      paint.shader = null;
      CurveChartData itemData = dataList[index];
      locationX[1] = rect.left + perW * (itemData.x - info.xMin);
      locationY[1] = rect.top + perH * (info.yMax - itemData.y);
      shaderStartColor[1] = itemData.shaderStartColor ?? style.shaderStartColor;
      shaderEndColor[1] = itemData.shaderEndColor ?? style.shaderEndColor;
      showLabel[1] = itemData.showLabel ?? style.showLabel;
      uiInfoList.add(ChartUIInfo(
          data: itemData,
          rect: Rect.fromLTRB(
              locationX[1], locationY[1], locationX[1], locationY[1]),
          position: index));
      if (showLabel[1]) {
        if (style.getLabel != null) {
          label[1] = style.getLabel!(itemData.x, itemData.y);
        } else {
          label[1] = itemData.label;
        }
        labelStyle[1] = itemData.labelStyle ?? style.labelStyle;
        labelPaddingBottom[1] =
            itemData.labelPaddingBottom ?? style.labelPaddingBottom;
      }
      if (locationX[0] == -1 && locationY[0] == -1) {
        locationX[0] = locationX[1];
        locationY[0] = locationY[1];
        shaderStartColor[0] = shaderStartColor[1];
        shaderEndColor[0] = shaderEndColor[1];
        showLabel[0] = showLabel[1];
        label[0] = label[1];
        labelStyle[0] = labelStyle[1];
        labelPaddingBottom[0] = labelPaddingBottom[1];
        if (index != dataList.length - 1) {
          continue;
        }
      }
      paint.strokeWidth = style.lineHeight;
      paint.color = style.lineColor;
      if (locationX[0] == locationX[1] && locationY[0] == locationY[1]) {
        paint.style = PaintingStyle.fill;
        context.canvas.drawCircle(
            Offset(locationX[0], locationY[0]), style.lineHeight, paint);
        if (shaderStartColor[0] != null && shaderEndColor[0] != null) {
          paint.shader = ui.Gradient.linear(
              Offset(locationX[0], min(locationY[0], locationY[1])),
              Offset(locationX[0], rect.bottom),
              [shaderStartColor[0]!, shaderEndColor[0]!],
              [0, 1],
              TileMode.clamp);
        }
        context.canvas.drawRect(
            Rect.fromLTRB(locationX[0], locationY[0], locationX[0], 0), paint);
      } else {
        paint.shader = null;
        paint.style = PaintingStyle.stroke;
        double centerX = locationX[0] + (locationX[1] - locationX[0]) * 0.35;
        double centerY = locationY[0] + (locationY[1] - locationY[0]) * 0.65;
        itemPath.reset();

        itemPath.moveTo(locationX[0] - 1, locationY[0] - 1);
        itemPath.cubicTo(locationX[0], locationY[0], centerX, centerY,
            locationX[1], locationY[1]);
        debugPrint(
            "0:${locationX[0]},${locationY[0]},1:$centerX,$centerY,2:${locationX[1]},${locationY[1]}");
        context.canvas.drawPath(itemPath, paint);

        itemPath.lineTo(locationX[1], rect.bottom);
        itemPath.lineTo(locationX[0], rect.bottom);
        itemPath.close();
        paint.style = PaintingStyle.fill;
        paint.shader = ui.Gradient.linear(
            Offset(locationX[0], min(locationY[0], locationY[1])),
            Offset(locationX[0], rect.bottom),
            [shaderStartColor[0]!, shaderEndColor[0]!],
            [0.5, 1]);

        context.canvas.drawPath(itemPath, paint);
      }

      locationX[0] = locationX[1];
      locationY[0] = locationY[1];
      shaderStartColor[0] = shaderStartColor[1];
      shaderEndColor[0] = shaderEndColor[1];
      showLabel[0] = showLabel[1];
      label[0] = label[1];
      labelStyle[0] = labelStyle[1];
      labelPaddingBottom[0] = labelPaddingBottom[1];
    }
  }
}
