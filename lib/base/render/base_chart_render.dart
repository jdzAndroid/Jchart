import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jchart/helper/chart_helper.dart';

import '../data/base_data.dart';
import '../data/base_draw_info.dart';
import '../style/base_chart_style.dart';

///Created by jdz on 2024/2/28 0028 22:51
///@brief 图表渲染基类
abstract class BaseChartRender<STYLE extends BaseChartStyle,
    INFO extends BaseDrawInfo, DATA extends BaseData> {
  final List<DATA> _dataList = List.empty(growable: true);
  late INFO _info;
  late STYLE _style;
  final Paint _paint = Paint();

  Paint get paint {
    return _paint;
  }

  List<DATA> get dataList {
    return _dataList;
  }

  INFO get info {
    return _info;
  }

  STYLE get style {
    return _style;
  }

  BaseChartRender();

  ///绘制
  ///@param rect 绘制区域
  ///@param contentRect 图表绘制区域
  void draw(PaintingContext context, Rect rect, Rect contentRect);

  ///绘制虚线
  ///@param path 线条路径
  ///@param width 虚线实体部分宽度
  ///@param dashWidth 虚线虚体部分宽度
  ///@param color 虚线实体部分颜色
  ///@param dashColor 虚线虚体部分颜色
  ///@param lineHeight 线条高度
  void drawVisualLine(
      {required Path path,
      required double width,
      required double dashWidth,
      required Color color,
      required Color dashColor,
      required double lineHeight,
      required Paint paint,
      required Canvas canvas}) {
    PathMetrics pathMetrics = path.computeMetrics();
    double startDistance = 0;
    double endDistance = 0;
    bool solid = true;
    paint.style = PaintingStyle.stroke;
    paint.isAntiAlias = true;
    paint.strokeWidth = 1;
    for (var itemPathMetrics in pathMetrics) {
      solid = true;
      startDistance = endDistance = 0;
      while (endDistance < itemPathMetrics.length) {
        if (solid) {
          endDistance = startDistance + width;
          paint.color = color;
        } else {
          endDistance = startDistance + dashWidth;
          paint.color = dashColor;
        }
        solid = !solid;
        canvas.drawPath(
            itemPathMetrics.extractPath(startDistance, endDistance), paint);
        startDistance = endDistance;
      }
    }
  }

  void setDataList(List<DATA>? list) {
    printLog(
        message: "update data size=${list?.length ?? 0}",
        methodName: "setDataList");
    _dataList.clear();
    if (list == null || list.isEmpty) return;
    _dataList.addAll(list);
  }

  void setInfo(INFO info) {
    printLog(message: "update info $info}", methodName: "setInfo");
    _info = info;
  }

  void setStyle(STYLE style) {
    printLog(message: "update style $style", methodName: "setStyle");
    _style = style;
  }
}
