import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jchart/helper/chart_helper.dart';

import '../../def/chart_global_config.dart';
import '../data/base_draw_info.dart';
import '../data/base_y_scale_data.dart';
import '../style/base_chart_y_scale_style.dart';
import 'base_chart_scale_render.dart';

///Created by jdz on 2024/2/28 0028 23:04
///@brief 图表Y轴刻度线绘制基类
class BaseChartYScaleRender<STYLE extends BaseChartYScaleStyle,
        INFO extends BaseDrawInfo, DATA extends BaseYScaleData>
    extends BaseChartScaleRender<STYLE, INFO, DATA> {
  ///表示是否是左边Y轴刻度线
  bool left = false;

  BaseChartYScaleRender();

  @override
  void draw(PaintingContext context, Rect rect, Rect contentRect) {
    if (dataList.isEmpty) {
      printLog(message: "${left ? "左边" : "右边"}Y轴刻度数据为空，跳过该刻度线绘制");
      return;
    }

    ///第一步，测量每个标签占用大小以及最大高度
    List<Size> labelSizeList = List.empty(growable: true);
    double maxLabelWidth = findMaxLabelWidth(labelSizeList);

    ///遍历数据绘制标签
    double perH = contentRect.height / (info.yMax - info.yMin + 1);
    Alignment labelAlign;
    TextStyle textStyle;
    TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
    double yLocation;
    double labelStartX = 0;
    double lineStartX = 0;
    double lineWidth = style.lineWidth ?? ChartGlobalConfig.lineDefSize;
    EdgeInsets labelPadding;
    if (left) {
      if (style.showOut) {
        labelStartX = rect.left;
        lineStartX = labelStartX + maxLabelWidth;
      } else {
        labelStartX = lineWidth;
        lineStartX = rect.left;
      }
    } else {
      if (style.showOut) {
        lineStartX = rect.left;
        labelStartX = lineStartX + lineWidth;
      } else {
        lineStartX = rect.right - lineWidth;
        labelStartX = rect.left;
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
      labelPadding = itemData.labelPadding ?? style.labelPadding;
      labelAlign = itemData.labelAlign ?? style.labelAlign;
      textStyle = itemData.textStyle ?? style.labelStyle;
      textPainter.text = TextSpan(text: label, style: textStyle);
      textPainter.textAlign = TextAlign.left;
      textPainter.layout();
      yLocation = contentRect.bottom - perH * (itemData.value - info.yMin + 1);

      if (labelAlign == Alignment.bottomLeft ||
          labelAlign == Alignment.bottomRight ||
          labelAlign == Alignment.bottomCenter) {
        yLocation += (perH - itemSize.height);
      } else if (labelAlign == Alignment.center ||
          labelAlign == Alignment.centerLeft ||
          labelAlign == Alignment.centerRight) {
        yLocation += (perH / 2 - itemSize.height / 2);
      }
      if (left) {
        if (style.showOut) {
          textPainter.paint(context.canvas,
              Offset(labelStartX + labelPadding.left, yLocation));
        } else {
          textPainter.paint(context.canvas,
              Offset(labelStartX + labelPadding.left, yLocation));
        }
      } else {
        if (style.showOut) {
          textPainter.paint(context.canvas,
              Offset(labelStartX + labelPadding.left, yLocation));
        } else {
          textPainter.paint(context.canvas, Offset(labelStartX, yLocation));
        }
      }
    }
    paint.style = PaintingStyle.fill;
    paint.isAntiAlias = true;
    paint.strokeWidth = lineWidth;
    context.canvas.drawLine(Offset(lineStartX, contentRect.top),
        Offset(lineStartX, contentRect.bottom), paint);
  }

  @override
  Rect? getDrawArea() {
    if (dataList.isEmpty) {
      double lineWidth = style.lineWidth ?? ChartGlobalConfig.lineDefSize;
      if (left) {
        return Rect.fromLTWH(0, 0, lineWidth, info.h);
      } else {
        return Rect.fromLTWH(info.w - lineWidth, 0, lineWidth, info.h);
      }
    }
    List<Size> labelSizeList = List.empty(growable: true);
    double maxLabelWidth = findMaxLabelWidth(labelSizeList);
    double lineWidth = style.lineWidth ?? ChartGlobalConfig.lineDefSize;
    if (left) {
      return Rect.fromLTWH(0, 0, maxLabelWidth + lineWidth, info.h);
    } else {
      return Rect.fromLTWH(info.w - maxLabelWidth - lineWidth, 0,
          maxLabelWidth + lineWidth, info.h);
    }
  }

  ///找到标签占用的最大高度
  ///@param labelSizeList 每个标签占用大小
  ///@return 返回占用的最大高度
  double findMaxLabelWidth(List<Size> labelSizeList) {
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
      showLabel = itemData.showLabel ?? style.showLabel;
      if (!showLabel) {
        labelSizeList.add(Size.zero);
        continue;
      }
      if (itemData.value < info.yMin || itemData.value > info.yMax) {
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
      padding = itemData.labelPadding ?? style.labelPadding;
      textPainter.text = TextSpan(text: label, style: textStyle);
      textPainter.layout();
      labelSizeList.add(Size(textPainter.width, textPainter.height));
      result = max(result, textPainter.width + padding.left + padding.right);
    }
    return result;
  }
}
