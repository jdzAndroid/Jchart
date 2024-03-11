import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jchart/def/chart_global_config.dart';
import 'package:jchart/helper/chart_helper.dart';
import 'package:jchart/line_type_enum.dart';

import '../../base/data/base_draw_info.dart';
import '../../base/render/base_chart_content_render.dart';
import 'line_chart_data.dart';
import 'line_chart_style.dart';

///Created by jdz on 2024/3/10 0010 21:41
///@brief 折线图绘制
class LineChartRender extends BaseChartContentRender<LineChartStyle,
    BaseDrawInfo, LineChartData> {
  LineChartRender({required super.dataList, required super.style});

  @override
  void draw(PaintingContext context, Rect rect, Rect contentRect) {
    if (dataList.isEmpty) {
      printLog(message: "折线图数据为空", methodName: "draw");
      return;
    }
    double perW = (rect.width) / (info.xMax - info.xMin + 1);
    double perH = (rect.height) / (info.yMax - info.yMin + 1);
    LineTypeEnum itemLineType;
    double itemLineWidth;
    double itemDashWidth;
    double itemLineHeight;
    Color itemLineColor;
    Color itemDashColor;
    bool itemShowCircle;
    double itemCircleRadius;
    double itemCircleStrokeRadius;
    PaintingStyle itemCircleStyle;
    Color itemCircleColor;
    Color itemCircleStrokeColor;
    Color itemCircleSelColor;
    Color itemCircleSelStrokeColor;
    Offset startOffset = Offset.zero;
    Offset endOffset = Offset.zero;
    double startCenterX;
    double startCenterY;
    double endCenterX;
    double endCenterY;
    Path linePath = Path();
    dataList.sort((pre, next) => (pre.xValue - next.xValue).toInt());
    for (int index = 0; index < dataList.length; index++) {
      LineChartData itemData = dataList[index];
      itemShowCircle = itemData.showCircle ?? style.showCircle ?? false;
      itemLineType = itemData.lineType ?? style.lineType ?? LineTypeEnum.line;
      itemLineWidth =
          itemData.width ?? style.width ?? ChartGlobalConfig.lineSolidWidth;
      itemDashWidth = itemData.dashWidth ??
          style.dashWidth ??
          ChartGlobalConfig.lineVisualWidth;
      itemLineHeight =
          itemData.lineSize ?? style.lineSize ?? ChartGlobalConfig.lineDefSize;
      itemLineColor = itemData.lineColor ??
          style.lineColor ??
          ChartGlobalConfig.lineSolidColor;
      itemDashColor = itemData.dashColor ??
          style.dashColor ??
          ChartGlobalConfig.lineVisualColor;
      itemCircleRadius = itemData.circleRadius ?? style.circleRadius ?? 0;
      itemCircleStrokeRadius =
          itemData.circleStrokeRadius ?? style.circleStrokeRadius ?? 0;
      itemCircleStyle =
          itemData.circleStyle ?? style.circleStyle ?? PaintingStyle.fill;
      itemCircleColor =
          itemData.circleColor ?? style.circleColor ?? Colors.black;
      itemCircleStrokeColor = itemData.circleStrokeColor ??
          style.circleStrokeColor ??
          Colors.transparent;
      itemCircleSelColor =
          itemData.circleSelColor ?? style.circleSelColor ?? Colors.white;
      itemCircleSelStrokeColor = itemData.circleStrokeSelColor ??
          style.circleStrokeSelColor ??
          Colors.transparent;

      startCenterX = rect.left + perW * (itemData.xValue - info.xMin + 0.5);
      startCenterY = rect.bottom - perH * (itemData.yValue - info.yMin + 0.5);

      ///非最后一个点需要绘制线条
      if (index != dataList.length - 1) {
        LineChartData nextItemData = dataList[index + 1];
        endCenterX = rect.left + perW * (nextItemData.xValue - info.xMin + 0.5);
        endCenterY =
            rect.bottom - perH * (nextItemData.yValue - info.yMin + 0.5);

        switch (itemCircleStyle) {
          case PaintingStyle.fill:
            startCenterX = max(min(startCenterX, rect.right - itemCircleRadius),
                rect.left + itemCircleRadius);
            startCenterY = max(
                min(startCenterY, rect.bottom - itemCircleRadius),
                rect.top + itemCircleRadius);

            endCenterX = max(min(endCenterX, rect.right - itemCircleRadius),
                rect.left + itemCircleRadius);
            endCenterY = max(min(endCenterY, rect.bottom - itemCircleRadius),
                rect.top + itemCircleRadius);
            break;
          default:
            startCenterX = max(
                min(startCenterX, rect.right - itemCircleStrokeRadius),
                rect.left + itemCircleStrokeRadius);
            startCenterY = max(
                min(startCenterY, rect.bottom - itemCircleStrokeRadius),
                rect.top + itemCircleStrokeRadius);

            endCenterX = max(
                min(endCenterX, rect.right - itemCircleStrokeRadius),
                rect.left + itemCircleStrokeRadius);
            endCenterY = max(
                min(endCenterY, rect.bottom - itemCircleStrokeRadius),
                rect.top + itemCircleStrokeRadius);
            break;
        }

        startOffset = Offset(startCenterX, startCenterY);
        endOffset = Offset(endCenterX, endCenterY);

        paint.color = itemLineColor;
        paint.style = PaintingStyle.fill;
        paint.strokeWidth = itemLineHeight;
        paint.isAntiAlias = true;
        switch (itemLineType) {
          case LineTypeEnum.line:
            context.canvas.drawLine(startOffset, endOffset, paint);
            break;
          default:
            linePath.reset();
            linePath.moveTo(startCenterX, startCenterY);
            linePath.lineTo(endCenterX, endCenterY);
            drawVisualLine(
                path: linePath,
                width: itemLineWidth,
                dashWidth: itemDashWidth,
                color: itemLineColor,
                dashColor: itemDashColor,
                lineHeight: itemLineHeight,
                paint: paint,
                canvas: context.canvas);
            break;
        }
      } else {
        startCenterX = max(min(startCenterX, rect.right - itemCircleRadius),
            rect.left + itemCircleRadius);
        startCenterY = max(min(startCenterY, rect.bottom - itemCircleRadius),
            rect.top + itemCircleRadius);
      }

      if (itemShowCircle) {
        ///绘制圆点
        paint.style = PaintingStyle.fill;
        paint.strokeWidth = 1;
        switch (itemCircleStyle) {
          case PaintingStyle.fill:
            paint.color =
                selIndex == index ? itemCircleSelColor : itemCircleColor;
            context.canvas.drawCircle(
                Offset(startCenterX, startCenterY), itemCircleRadius, paint);
            break;
          default:
            paint.color = selIndex == index
                ? itemCircleSelStrokeColor
                : itemCircleStrokeColor;
            context.canvas.drawCircle(Offset(startCenterX, startCenterY),
                itemCircleStrokeRadius, paint);

            paint.color =
                selIndex == index ? itemCircleSelColor : itemCircleColor;
            context.canvas.drawCircle(
                Offset(startCenterX, startCenterY), itemCircleRadius, paint);
            break;
        }
      }
    }
  }

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
        canvas.drawPath(itemPathMetrics.extractPath(startDistance, endDistance), paint);
        startDistance=endDistance;
      }
    }
  }
}
