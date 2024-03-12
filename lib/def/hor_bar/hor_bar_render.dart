import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jchart/helper/chart_helper.dart';
import 'dart:ui' as ui;
import '../../base/data/base_draw_info.dart';
import '../../base/render/base_chart_content_render.dart';
import 'hor_bar_data.dart';
import 'hor_bar_style.dart';

///Created by jdz on 2024/3/12 9:00
///@brief 横向柱状图渲染器
class HorBarRender
    extends BaseChartContentRender<HorBarStyle, BaseDrawInfo, HorBarData> {
  HorBarRender({required super.dataList, required super.style});

  @override
  void draw(PaintingContext context, Rect rect, Rect contentRect) {
    uiInfoList.clear();
    if (dataList.isEmpty) {
      return;
    }
    Color itemStartColor;
    Color itemEndColor;
    double itemXStartValue, itemXEndValue;
    double itemYStartValue, itemYEndValue = 0;
    double itemHeightRadius;
    String itemLabel = "";
    bool itemShowLabel;
    TextStyle itemLabelStyle;
    EdgeInsets itemLabelPadding;
    Radius itemBarLeftRadius;
    Radius itemBarRightRadius;
    bool itemLabelLeft;
    PaintingStyle itemBarStyle;
    double itemStrokeWidth;
    TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);

    double perH = rect.height / (info.yMax - info.yMin + 1);
    double perW = rect.width / (info.xMax - info.xMin + 1);
    paint.isAntiAlias = true;
    for (int index = 0; index < dataList.length; index++) {
      HorBarData itemData = dataList[index];
      if (itemData.xStartValue < info.xMin ||
          itemData.xEndValue > info.xMax ||
          itemData.xStartValue > itemData.xEndValue) {
        continue;
      }
      if (itemData.yValue < info.yMin || itemData.yValue > info.yMax) {
        continue;
      }
      paint.shader = null;
      itemStartColor = itemData.startColor ?? style.startColor;
      itemEndColor = itemData.endColor ?? style.endColor;
      itemHeightRadius = itemData.heightRadius ?? style.heightRadius;
      itemShowLabel = itemData.showLabel ?? style.showLabel;
      itemBarLeftRadius = itemData.barLeftRadius ?? style.barLeftRadius;
      itemBarRightRadius = itemData.barRightRadius ?? style.barRightRadius;
      itemBarStyle = itemData.barStyle ?? style.barStyle;
      itemStrokeWidth = itemData.strokeWidth ?? style.strokeWidth;
      itemLabelStyle = itemData.labelTextStyle ?? style.labelTextStyle;
      itemLabelPadding = itemData.labelPadding ?? style.labelPadding;
      itemLabelLeft = itemData.labelLeft ?? style.labelLeft;
      if (itemShowLabel) {
        if (style.getLabel != null) {
          itemLabel = style.getLabel!(itemData.yValue);
        } else {
          itemLabel = itemData.label ?? "";
        }
      }

      itemXStartValue = rect.left + perW * (itemData.xStartValue - info.xMin);
      itemXEndValue = rect.left + perW * (itemData.xEndValue - info.xMin + 1);

      itemYStartValue = rect.top + (itemData.yValue - info.yMin + 0.5) * perH;
      itemYStartValue -= perH * itemHeightRadius / 2;
      itemYEndValue += perH * itemHeightRadius;
      printLog(
          message:
              "perW=$perW,perH=$perH,itemHeightRadius=$itemHeightRadius,itemXStartValue=$itemXStartValue,itemXEndValue=$itemXEndValue,itemYStartValue=$itemYStartValue,itemYEndValue=$itemYEndValue");
      if (itemStartColor != itemEndColor) {
        paint.shader = ui.Gradient.linear(
            Offset(itemXStartValue, itemYStartValue),
            Offset(itemXEndValue, itemYStartValue),
            [itemStartColor, itemEndColor],
            [0.0, 1.0],
            TileMode.clamp);
      } else {
        paint.color = itemStartColor;
      }
      Rect itemRect;
      if (itemBarStyle == PaintingStyle.fill) {
        itemRect = Rect.fromLTRB(
            itemXStartValue, itemYStartValue, itemXEndValue, itemYEndValue);
      } else {
        itemRect = Rect.fromLTRB(
            itemXStartValue + itemStrokeWidth / 2,
            itemYStartValue + itemStrokeWidth / 2,
            itemXEndValue - itemStrokeWidth / 2,
            itemYEndValue - itemStrokeWidth / 2);
      }
      context.canvas.drawRRect(
          RRect.fromRectAndCorners(itemRect,
              topLeft: itemBarLeftRadius,
              topRight: itemBarRightRadius,
              bottomLeft: itemBarLeftRadius,
              bottomRight: itemBarRightRadius),
          paint);
      uiInfoList
          .add(ChartUIInfo(data: itemData, rect: itemRect, position: index));
      if (!itemShowLabel || itemLabel.isBlank == true) {
        continue;
      }
      textPainter.text = TextSpan(text: itemLabel, style: itemLabelStyle);
      textPainter.layout();
      if (itemLabelLeft) {
        textPainter.paint(
            context.canvas,
            Offset(
                max(
                    itemXStartValue -
                        textPainter.width -
                        itemLabelPadding.right,
                    rect.left + itemLabelPadding.left),
                min(
                    itemYStartValue +
                        perH * itemHeightRadius / 2 -
                        textPainter.height / 2,
                    rect.bottom -
                        textPainter.height -
                        itemLabelPadding.bottom)));
      } else {
        textPainter.paint(
            context.canvas,
            Offset(
                min(itemXEndValue + itemLabelPadding.left,
                    rect.right - itemLabelPadding.right - textPainter.width),
                min(
                    itemYStartValue +
                        perH * itemHeightRadius / 2 -
                        textPainter.height / 2,
                    rect.bottom -
                        textPainter.height -
                        itemLabelPadding.bottom)));
      }
    }
  }
}
