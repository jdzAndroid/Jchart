import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jchart/helper/chart_helper.dart';

import '../../def/chart_global_config.dart';
import '../data/base_draw_info.dart';
import '../data/base_x_scale_data.dart';
import '../style/base_chart_x_scale_style.dart';
import 'base_chart_scale_render.dart';

///Created by jdz on 2024/2/28 0028 23:03
///@brief 图表X轴刻度线绘制基类
class BaseChartXScaleRender<STYLE extends BaseChartXScaleStyle,
        INFO extends BaseDrawInfo, DATA extends BaseXScaleData>
    extends BaseChartScaleRender<STYLE, INFO, DATA> {
  ///表示是否是顶部X轴刻度线
  bool top = false;

  BaseChartXScaleRender();

  @override
  void draw(PaintingContext context, Rect rect, Rect contentRect) {
    if (dataList.isEmpty) {
      printLog(message: "${top ? "顶部" : "底部"}X轴刻度线数据为空，跳过X轴刻度线绘制");
      return;
    }

    ///第一步，测量每个标签占用大小以及最大高度
    List<Size> labelSizeList = List.empty(growable: true);
    double maxLabelHeight = findMaxLabelHeight(labelSizeList);

    ///遍历数据绘制标签
    double perW = (contentRect.width) / (info.xMax - info.xMin + 1);
    double startX = contentRect.left;
    Alignment labelAlign;
    TextStyle textStyle;
    TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
    double xLocation;
    double labelStartY = 0;
    double lineStartY = 0;
    double lineHeight = style.lineHeight ?? ChartGlobalConfig.lineDefSize;
    EdgeInsets labelPadding;
    if (top) {
      if (style.showOut) {
        labelStartY = rect.top;
        lineStartY = labelStartY + maxLabelHeight;
      } else {
        lineStartY = rect.top;
        labelStartY = lineStartY + lineHeight;
      }
    } else {
      if (style.showOut) {
        lineStartY = rect.bottom - maxLabelHeight;
        labelStartY = lineStartY - lineHeight;
      } else {
        lineStartY = rect.bottom - lineHeight;
        labelStartY = lineStartY - maxLabelHeight;
      }
    }
    String label;
    for (int index = 0; index < labelSizeList.length; index++) {
      Size itemSize = labelSizeList[index];
      if (itemSize.width <= 0 || itemSize.height <= 0) {
        continue;
      }
      if (dataList[index].getLabel != null) {
        label = dataList[index].getLabel!(dataList[index].value);
      } else {
        label = dataList[index].label ?? "";
      }
      DATA itemData = dataList[index];
      labelPadding =
          itemData.labelPadding ?? style.labelPadding ?? EdgeInsets.zero;
      labelAlign = itemData.labelAlign ?? style.labelAlign;
      textStyle = itemData.textStyle ?? style.labelStyle;
      textPainter.text = TextSpan(text: label, style: textStyle);
      textPainter.textAlign = TextAlign.left;
      textPainter.layout();
      xLocation = startX + perW * (itemData.value - info.xMin + 1);

      if (labelAlign == Alignment.topLeft ||
          labelAlign == Alignment.bottomLeft ||
          labelAlign == Alignment.centerLeft) {
        xLocation -= perW;
      } else if (labelAlign == Alignment.bottomCenter ||
          labelAlign == Alignment.topCenter ||
          labelAlign == Alignment.center) {
        xLocation -= (perW / 2 + itemSize.width / 2);
      } else {
        xLocation -= itemSize.width;
      }
      textPainter.paint(
          context.canvas, Offset(xLocation, labelStartY + labelPadding.top));
    }
    paint.style = PaintingStyle.fill;
    paint.isAntiAlias = true;
    paint.strokeWidth = lineHeight;
    context.canvas.drawLine(Offset(startX, lineStartY),
        Offset(startX + contentRect.width, lineStartY), paint);
  }

  ///找到标签占用的最大高度
  ///@param labelSizeList 每个标签占用大小
  ///@return 返回占用的最大高度
  double findMaxLabelHeight(List<Size> labelSizeList) {
    labelSizeList.clear();
    if (dataList.isEmpty) {
      return 0;
    }
    double result = 0;
    TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
    TextStyle textStyle;
    EdgeInsets padding;
    String label;
    bool showLabel = false;
    for (var itemData in dataList) {
      showLabel = itemData.showLabel ?? style.showLabel ?? false;
      if (!showLabel) {
        labelSizeList.add(Size.zero);
        continue;
      }
      if (itemData.value < info.xMin || itemData.value > info.xMax) {
        labelSizeList.add(Size.zero);
        continue;
      }
      label = itemData.label ?? "";
      if (itemData.getLabel != null) {
        label = itemData.getLabel!(itemData.value);
      }
      if (label.isEmpty) {
        labelSizeList.add(Size.zero);
        continue;
      }
      textStyle = itemData.textStyle ?? style.labelStyle;
      padding = itemData.labelPadding ?? style.labelPadding ?? EdgeInsets.zero;
      textPainter.text = TextSpan(text: label, style: textStyle);
      textPainter.layout();
      labelSizeList.add(Size(textPainter.width, textPainter.height));
      result = max(result, textPainter.height + padding.top + padding.bottom);
    }
    return result;
  }

  @override
  Rect? getDrawArea() {
    if (dataList.isEmpty) {
      double lineHeight = style.lineHeight ?? ChartGlobalConfig.lineDefSize;
      if (top) {
        return Rect.fromLTWH(0, 0, info.w, lineHeight);
      } else {
        return Rect.fromLTWH(0, info.h - lineHeight, info.w, lineHeight);
      }
    }
    List<Size> labelSizeList = List.empty(growable: true);
    double labelMaxHeight = findMaxLabelHeight(labelSizeList);
    double lineHeight = style.lineHeight ?? ChartGlobalConfig.lineDefSize;
    if (top) {
      return Rect.fromLTWH(0, 0, info.w, labelMaxHeight + lineHeight);
    } else {
      return Rect.fromLTWH(0, info.h - (labelMaxHeight + lineHeight), info.w,
          labelMaxHeight + lineHeight);
    }
  }
}
