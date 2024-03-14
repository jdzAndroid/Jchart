import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../helper/chart_helper.dart';
import 'data/base_draw_info.dart';
import 'render/base_chart_content_render.dart';
import 'render/base_chart_x_grid_render.dart';
import 'render/base_chart_x_scale_render.dart';
import 'render/base_chart_y_grid_render.dart';
import 'render/base_chart_y_scale_render.dart';

///Created by jdz on 2024/2/29 13:43
///@brief 图标控件基类
class BaseChartWidget extends LeafRenderObjectWidget {
  ///数据加载中
  static const int loading = 1;

  ///数据加载失败
  static const int loadFailed = -1;

  ///数据加载成功
  static const int loadSuccess = 0;

  ///数据加载状态
  ///默认是数据加载成功
  int dataLoadState = loadSuccess;

  ///图表宽度，如果为null，则和父控件宽度保持一致
  double? width;

  ///图表高度，如果为null，则和父控件高度保持一致
  double? height;

  ///图表X轴最大值
  double xMax;

  ///图表X轴最小值
  double xMin;

  ///图表Y轴最大值
  double yMax;

  ///图表Y轴最小值
  double yMin;

  ///X轴网格线绘制
  BaseChartXGridRender? _xGridRender;

  ///Y轴网格线绘制
  BaseChartYGridRender? _yGridRender;

  ///左边Y轴刻度线绘制
  BaseChartYScaleRender? _leftScaleRender;

  ///右边Y轴刻度线绘制
  BaseChartYScaleRender? _rightScaleRender;

  ///顶部X轴刻度线绘制
  BaseChartXScaleRender? _topScaleRender;

  ///底部X轴刻度线绘制
  BaseChartXScaleRender? _bottomScaleRender;

  ///图表内容绘制
  List<BaseChartContentRender>? _chartRenderList;

  ///数据加载中显示的UI
  Widget? _loadingWidget;

  ///数据加载失败显示的UI
  Widget? _failedWidget;

  BaseChartWidget(
      {required this.xMax,
      required this.xMin,
      required this.yMax,
      required this.yMin,
      required this.width,
      required this.height,
      BaseChartXGridRender? xGridRender,
      BaseChartYGridRender? yGridRender,
      BaseChartYScaleRender? leftScaleRender,
      BaseChartYScaleRender? rightScaleRender,
      BaseChartXScaleRender? topScaleRender,
      BaseChartXScaleRender? bottomScaleRender,
      List<BaseChartContentRender>? chartRenderList,
      Widget? loadingWidget,
      Widget? failedWidget,
      super.key}) {
    _xGridRender = xGridRender;
    _yGridRender = yGridRender;
    _leftScaleRender = leftScaleRender;
    _rightScaleRender = rightScaleRender;
    _topScaleRender = topScaleRender;
    _bottomScaleRender = bottomScaleRender;
    _chartRenderList = chartRenderList;
    _loadingWidget = loadingWidget;
    _failedWidget = failedWidget;
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    return BaseChartRenderObject(ChartBean(
        width: width,
        height: height,
        xMax: xMax,
        xMin: xMin,
        yMax: yMax,
        yMin: yMin,
        xGridRender: _xGridRender,
        yGridRender: _yGridRender,
        leftScaleRender: _leftScaleRender,
        rightScaleRender: _rightScaleRender,
        topScaleRender: _topScaleRender,
        bottomScaleRender: _bottomScaleRender,
        chartRenderList: _chartRenderList,
        loadingWidget: _loadingWidget,
        failedWidget: _failedWidget));
  }
}

class BaseChartRenderObject extends RenderBox {
  ChartBean chartBean;

  BaseChartRenderObject(this.chartBean);

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    result.add(BoxHitTestEntry(this, position));
    if (chartBean.chartRenderList == null) {
      return false;
    }

    bool needRefresh = false;
    for (BaseChartContentRender render in chartBean.chartRenderList!) {
      render.hitTestSelf(position);
      needRefresh = true;
    }
    if (needRefresh) {
      markNeedsPaint();
    }
    return true;
  }

  @override
  void performLayout() {
    size = Size(constraints.maxWidth, constraints.maxHeight);
    if (parentData is BoxParentData) {
      (parentData as BoxParentData).offset = Offset.zero;
    }
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    super.computeDryLayout(constraints);
    return Size(constraints.maxWidth, constraints.maxHeight);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    if (chartBean.xMin >= chartBean.xMax) return;
    if (chartBean.yMin >= chartBean.yMax) return;
    double w = chartBean.width ?? constraints.maxWidth;
    double h = chartBean.height ?? constraints.maxHeight;
    BaseDrawInfo drawInfo = BaseDrawInfo(
        w: w,
        h: h,
        xMax: chartBean.xMax,
        xMin: chartBean.xMin,
        yMax: chartBean.yMax,
        yMin: chartBean.yMin);
    printLog(message: "w:$w,h:$h", methodName: "paint");
    chartBean.leftScaleRender?.info = drawInfo;
    Rect leftScaleRect = chartBean.leftScaleRender?.getDrawArea() ?? Rect.zero;
    leftScaleRect = leftScaleRect.shift(offset);
    printLog(message: "leftScaleRect:$leftScaleRect", methodName: "paint");

    chartBean.rightScaleRender?.info = drawInfo;
    Rect rightScaleRect =
        chartBean.rightScaleRender?.getDrawArea() ?? Rect.zero;
    rightScaleRect = rightScaleRect.shift(offset);
    printLog(message: "rightScaleRect:$rightScaleRect", methodName: "paint");

    chartBean.topScaleRender?.info = drawInfo;
    Rect topScaleRect = chartBean.topScaleRender?.getDrawArea() ?? Rect.zero;
    topScaleRect = topScaleRect.shift(offset);
    printLog(message: "topScaleRect:$topScaleRect", methodName: "paint");

    chartBean.bottomScaleRender?.info = drawInfo;
    Rect bottomScaleRect =
        chartBean.bottomScaleRender?.getDrawArea() ?? Rect.zero;
    bottomScaleRect = bottomScaleRect.shift(offset);
    printLog(message: "bottomScaleRect:$bottomScaleRect", methodName: "paint");

    Rect contentRect = Rect.fromLTRB(leftScaleRect.right, topScaleRect.bottom,
        rightScaleRect.left, bottomScaleRect.top);
    printLog(message: "contentRect:$contentRect", methodName: "paint");

    chartBean.xGridRender?.info = drawInfo;
    chartBean.xGridRender?.draw(context, contentRect, contentRect);

    chartBean.yGridRender?.info = drawInfo;
    chartBean.yGridRender?.draw(context, contentRect, contentRect);
    chartBean.leftScaleRender?.draw(context, leftScaleRect, contentRect);

    chartBean.topScaleRender?.draw(context, topScaleRect, contentRect);

    chartBean.rightScaleRender?.draw(context, rightScaleRect, contentRect);

    chartBean.bottomScaleRender?.draw(context, bottomScaleRect, contentRect);

    if (chartBean.chartRenderList != null) {
      for (int index = 0; index < chartBean.chartRenderList!.length; index++) {
        chartBean.chartRenderList![index].info = drawInfo;
        chartBean.chartRenderList![index]
            .draw(context, contentRect, contentRect);
      }
    }
  }
}

class ChartBean {
  ///图表宽度，如果为null，则和父控件宽度保持一致
  double? width;

  ///图表高度，如果为null，则和父控件高度保持一致
  double? height;

  ///图表X轴最大值
  double xMax;

  ///图表X轴最小值
  double xMin;

  ///图表Y轴最大值
  double yMax;

  ///图表Y轴最小值
  double yMin;

  ///X轴网格线绘制
  BaseChartXGridRender? xGridRender;

  ///Y轴网格线绘制
  BaseChartYGridRender? yGridRender;

  ///左边Y轴刻度线绘制
  BaseChartYScaleRender? leftScaleRender;

  ///右边Y轴刻度线绘制
  BaseChartYScaleRender? rightScaleRender;

  ///顶部X轴刻度线绘制
  BaseChartXScaleRender? topScaleRender;

  ///底部X轴刻度线绘制
  BaseChartXScaleRender? bottomScaleRender;

  ///图表内容绘制
  List<BaseChartContentRender>? chartRenderList;

  ///数据加载中显示的UI
  Widget? loadingWidget;

  ///数据加载失败显示的UI
  Widget? failedWidget;

  ChartBean(
      {this.width,
      this.height,
      required this.xMax,
      required this.xMin,
      required this.yMax,
      required this.yMin,
      this.xGridRender,
      this.yGridRender,
      this.leftScaleRender,
      this.rightScaleRender,
      this.topScaleRender,
      this.bottomScaleRender,
      this.chartRenderList,
      this.loadingWidget,
      this.failedWidget});
}
