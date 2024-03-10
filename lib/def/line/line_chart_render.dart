import 'dart:ui';

import 'package:flutter/src/rendering/object.dart';
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
    if(dataList.isEmpty){
      printLog(message: "折线图数据为空",methodName: "draw");
      return;
    }
    double perW=rect.width/(info.xMax-info.xMin+1);
    double perH=rect.height/(info.yMax-info.yMin+1);
    LineTypeEnum itemLineType;
    double lineWidth;
    double dashWidth;
    double lineHeight;
    Color lineColor;
    Color dashColor;
    Radius lineRadius;
    bool showDot;
    double circleRadius;
    double circleStrokeRadius;
    PaintingStyle circleStyle;
    Color circleColor;
    Color circleStrokeColor;
    Color circleSelColor;
    Color circleSelStrokeColor;
    for(int index=0;index<dataList.length;index++){
      LineChartData itemData=dataList[index];

    }
  }
}
