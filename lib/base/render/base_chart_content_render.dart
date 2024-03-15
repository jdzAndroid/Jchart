import 'package:flutter/material.dart';

import '../../helper/chart_helper.dart';
import '../data/base_content_data.dart';
import '../data/base_data.dart';
import '../data/base_draw_info.dart';
import '../style/base_chart_content_style.dart';
import 'base_chart_render.dart';

///Created by jdz on 2024/3/6 9:03
///@brief 图表内容绘制
abstract class BaseChartContentRender<
    STYLE extends BaseChartContentStyle,
    INFO extends BaseDrawInfo,
    DATA extends BaseContentData> extends BaseChartRender<STYLE, INFO, DATA> {
  List<ChartUIInfo<DATA>> uiInfoList = List.empty(growable: true);

  ///记录当前选中的图表位置，如果支持选中
  int selIndex = -1;

  BaseChartContentRender();

  ///图表点击回调
  ///@param offset 触摸点坐标
  ///@return true表示需要刷新图表
  bool hitTestSelf(Offset offset) {
    if (style.chartClick == null) {
      printLog(message: "点击事件为空", methodName: "hitTestSelf");
      return false;
    }
    double minDistance = info.w;
    selIndex = -1;
    int position = -1;
    for (int i = 0; i < uiInfoList.length; i++) {
      ChartUIInfo itemInfo = uiInfoList[i];
      if (abs(offset.dx - itemInfo.rect.left) +
              abs(offset.dx - itemInfo.rect.right) <
          minDistance) {
        minDistance = abs(offset.dx - itemInfo.rect.left) +
            abs(offset.dx - itemInfo.rect.right);
        position = i;
      }
    }
    selIndex = position;
    printLog(message: "选中了:$position", methodName: "hitTestSelf");
    ChartUIInfo itemInfo = uiInfoList[position];
    return style.chartClick!(itemInfo.data, itemInfo.position, itemInfo.rect);
  }

  double abs(double value) {
    if (value < 0) {
      return -value;
    }
    return value;
  }
}

///用于描述图表绘制数据
class ChartUIInfo<DATA extends BaseData> {
  DATA data;
  Rect rect;
  int position;

  ChartUIInfo({required this.data, required this.rect, required this.position});
}
