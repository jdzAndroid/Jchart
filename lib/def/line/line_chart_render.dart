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
    double perW = rect.width / (info.xMax - info.xMin + 1);
    double perH = rect.height / (info.yMax - info.yMin + 1);
    LineTypeEnum itemLineType;
    double itemLineWidth;
    double itemDashWidth;
    double itemLineHeight;
    Color itemLineColor;
    Color itemDashColor;
    Radius itemLineRadius;
    bool itemShowDot;
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
    Path clipPath = Path();
    Path linePath = Path();
    dataList.sort((pre, next) => (pre.xValue - next.xValue).toInt());
    for (int index = 0; index < dataList.length; index++) {
      LineChartData itemData = dataList[index];
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
      itemLineRadius = itemData.radius ?? style.radius ?? Radius.zero;
      itemShowDot = itemData.showDot ?? style.showDot ?? true;
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
        context.canvas.save();
        clipPath.reset();
        LineChartData nextItemData = dataList[index + 1];
        endCenterX = rect.left + perW * (nextItemData.xValue - info.xMin + 0.5);
        endCenterY =
            rect.bottom - perH * (nextItemData.yValue - info.yMin + 0.5);

        switch (itemCircleStyle) {
          case PaintingStyle.fill:
            clipPath.addOval(Rect.fromCircle(
                center: Offset(startCenterX, startCenterY),
                radius: itemCircleRadius));

            clipPath.addOval(Rect.fromCircle(
                center: Offset(endCenterX, endCenterY),
                radius: itemCircleRadius));
            break;
          default:
            clipPath.addOval(Rect.fromCircle(
                center: Offset(startCenterX, startCenterY),
                radius: itemCircleStrokeRadius));

            clipPath.addOval(Rect.fromCircle(
                center: Offset(endCenterX, endCenterY),
                radius: itemCircleStrokeRadius));
            break;
        }

        context.canvas.clipPath(clipPath);

        startOffset.translate(-startOffset.dx, -startOffset.dy);
        endOffset.translate(-endOffset.dx, -endOffset.dy);
        startOffset.translate(startCenterX, startCenterY);
        endOffset.translate(endCenterX, endCenterY);

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
        context.canvas.restore();
      }

      ///绘制圆点
      paint.style = PaintingStyle.fill;
      paint.strokeWidth = 1;
      switch (itemCircleStyle) {
        case PaintingStyle.fill:
          paint.color =
              selIndex == index ? itemCircleSelColor : itemCircleColor;
          context.canvas.drawCircle(
              Offset(rect.left + perW * (itemData.xValue - info.xMin + 0.5),
                  rect.bottom - perH * (itemData.yValue - info.yMin + 0.5)),
              itemCircleRadius,
              paint);
          break;
        default:
          context.canvas.save();
          clipPath.addOval(Rect.fromCircle(
              center: Offset(startCenterX, startCenterY),
              radius: itemCircleRadius));
          context.canvas.clipPath(clipPath);

          paint.color = selIndex == index
              ? itemCircleSelStrokeColor
              : itemCircleStrokeColor;
          context.canvas.drawCircle(Offset(startCenterX, startCenterY),
              itemCircleStrokeRadius, paint);

          paint.color =
              selIndex == index ? itemCircleSelColor : itemCircleColor;
          context.canvas.drawCircle(
              Offset(startCenterX, startCenterY), itemCircleRadius, paint);
          context.canvas.restore();
          break;
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
    PathMetrics pathMetrics=path.computeMetrics();
    while(pathMetrics.iterator.moveNext()){
      // pathMetrics.iterator.current.extractPath(start, end);
    }
  }
}
