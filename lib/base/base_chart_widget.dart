import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../def/style/chart_left_scale_def_style.dart';
import '../enum/chart_type_enum.dart';
import '../helper/chart_helper.dart';
import '../enum/line_type_enum.dart';
import 'data/base_chart_x_grid_data.dart';
import 'data/base_content_data.dart';
import 'data/base_draw_info.dart';
import 'data/base_y_scale_data.dart';
import 'render/base_chart_content_render.dart';
import 'render/base_chart_x_grid_render.dart';
import 'render/base_chart_x_scale_render.dart';
import 'render/base_chart_y_grid_render.dart';
import 'render/base_chart_y_scale_render.dart';
import 'style/base_chart_content_style.dart';
import 'style/base_chart_x_grid_style.dart';
import 'style/base_chart_y_grid_style.dart';
import 'style/base_chart_y_scale_style.dart';

///Created by jdz on 2024/2/29 13:43
///@brief 图标控件基类
class BaseChartWidget extends LeafRenderObjectWidget {
  /*图表通用属性----------------------------------------------------------------------------------------------------------------------*/

  ///图表宽度，如果为null，则和父控件宽度保持一致
  final double? width;

  ///图表高度，如果为null，则和父控件高度保持一致
  final double? height;

  ///图表X轴最大值
  final double xMax;

  ///图表X轴最小值
  final double xMin;

  ///图表Y轴最大值
  final double yMax;

  ///图表Y轴最小值
  final double yMin;

  /*图表X轴网格线属性----------------------------------------------------------------------------------------------------------------------*/

  ///是否绘制X轴网格线，默认不绘制
  bool xGridEnable = false;

  ///X轴网格线颜色,如果没有设置，就采用全局配置
  final Color? xGridColor;

  ///X轴网格线风格,如果没有设置，就采用全局配置
  final LineTypeEnum? xGridLineStyle;

  ///X轴网格线数据
  final List<BaseChartXGridData>? xGridDataList;

  ///X轴网格线线条高度,如果没有设置，就采用全局配置
  final double? xGridLineHeight;

  ///自定义X轴网格线样式,如果不为空，它的样式设置优先级最高
  final BaseChartXGridStyle? xGridStyle;

  ///自定义网格线渲染器,如果为空就用默认的
  final BaseChartXGridRender? xGridRender;

  /*图表Y轴网格线属性----------------------------------------------------------------------------------------------------------------------*/

  ///是否绘制Y轴网格线，默认不绘制
  bool yGridEnable = false;

  ///Y轴网格线颜色,如果没有设置，就采用全局配置
  final Color? yGridColor;

  ///Y轴网格线风格,如果没有设置，就采用全局配置
  final LineTypeEnum? yGridLineStyle;

  ///Y轴网格线数据
  final List<BaseChartXGridData>? yGridDataList;

  ///Y轴网格线线条宽度,如果没有设置，就采用全局配置
  final double? yGridLineHeight;

  ///自定义Y轴网格线样式,如果不为空，它的样式设置优先级最高
  final BaseChartYGridStyle? yGridStyle;

  ///自定义网格线渲染器,如果为空就用默认的
  final BaseChartYGridRender? yGridRender;

  /*图表Y轴左侧刻度属性----------------------------------------------------------------------------------------------------------------------*/

  ///Y轴左侧刻度是否显示,默认显示
  bool yLeftScaleEnable = true;

  ///Y轴左侧刻度线宽度,如果没有设置，就采用全局配置
  final bool? yLeftScaleLineWidth;

  ///Y轴左侧刻度线风格,如果没有设置，就采用全局配置
  final LineTypeEnum? yLeftScaleLineType;

  ///Y轴左侧刻度数据
  final List<BaseYScaleData>? yLeftScaleDataList;

  ///Y轴左侧刻度线颜色,如果没有设置，就采用全局配置
  final Color? yLeftScaleLineColor;

  ///Y轴左侧刻度线文本对齐方式,如果没有设置，就采用全局配置
  final Alignment? yLeftScaleLabelAlign;

  ///Y轴左侧刻度值颜色,如果没有设置，就采用全局配置
  final Color? yLeftScaleLabelColor;

  ///Y轴左侧刻度值字体大小,如果没有设置，就采用全局配置
  final double? yLeftScaleLabelSize;

  ///Y轴左侧刻度自定义，如果不为空，它的样式设置优先级最高
  final BaseChartYScaleStyle? yLeftScaleStyle;

  ///自定义Y轴左侧刻度渲染器
  final BaseChartYScaleRender? yLeftScaleRender;

  /*图表Y轴右侧刻度属性----------------------------------------------------------------------------------------------------------------------*/

  ///Y轴右侧刻度是否显示,默认不显示
  bool yRightScaleEnable = false;

  ///Y轴右侧刻度线宽度,如果没有设置，就采用全局配置
  final bool? yRightScaleLineWidth;

  ///Y轴右侧刻度线风格,如果没有设置，就采用全局配置
  final LineTypeEnum? yRightScaleLineType;

  ///Y轴右侧刻度数据
  final List<BaseYScaleData>? yRightScaleDataList;

  ///Y轴右侧刻度线颜色,如果没有设置，就采用全局配置
  final Color? yRightScaleLineColor;

  ///Y轴右侧刻度线文本对齐方式,如果没有设置，就采用全局配置
  final Alignment? yRightScaleLabelAlign;

  ///Y轴右侧刻度值颜色,如果没有设置，就采用全局配置
  final Color? yRightScaleLabelColor;

  ///Y轴右侧刻度值字体大小,如果没有设置，就采用全局配置
  final double? yRightScaleLabelSize;

  ///Y轴右侧刻度自定义，如果不为空，它的样式设置优先级最高
  final BaseChartYScaleStyle? yRightScaleStyle;

  ///自定义Y轴右侧刻度渲染器
  final BaseChartYScaleRender? yRightScaleRender;

  /*图表X轴顶部刻度属性----------------------------------------------------------------------------------------------------------------------*/

  ///X轴顶部刻度是否显示,默认不显示
  bool xTopScaleEnable = false;

  ///X轴顶部刻度线高度,如果没有设置，就采用全局配置
  final bool? xTopScaleLineHeight;

  ///X轴顶部刻度线风格,如果没有设置，就采用全局配置
  final LineTypeEnum? xTopScaleLineType;

  ///X轴顶部刻度数据
  final List<BaseYScaleData>? xTopScaleDataList;

  ///X轴顶部刻度线颜色,如果没有设置，就采用全局配置
  final Color? xTopScaleLineColor;

  ///X轴顶部刻度线文本对齐方式,如果没有设置，就采用全局配置
  final Alignment? xTopScaleLabelAlign;

  ///X轴顶部刻度值颜色,如果没有设置，就采用全局配置
  final Color? xTopScaleLabelColor;

  ///X轴顶部刻度值字体大小,如果没有设置，就采用全局配置
  final double? xTopScaleLabelSize;

  ///X轴顶部刻度自定义，如果不为空，它的样式设置优先级最高
  final BaseChartYScaleStyle? xTopScaleStyle;

  ///自定义X轴顶部刻度渲染器
  final BaseChartYScaleRender? xTopScaleRender;

  /*图表X轴底部刻度属性----------------------------------------------------------------------------------------------------------------------*/

  ///X轴底部刻度是否显示,默认显示
  bool xBottomScaleEnable = true;

  ///X轴底部刻度线高度,如果没有设置，就采用全局配置
  final bool? xBottomScaleLineHeight;

  ///X轴底部刻度线风格,如果没有设置，就采用全局配置
  final LineTypeEnum? xBottomScaleLineType;

  ///X轴底部刻度数据
  final List<BaseYScaleData>? xBottomScaleDataList;

  ///X轴底部刻度线颜色,如果没有设置，就采用全局配置
  final Color? xBottomScaleLineColor;

  ///X轴底部刻度线文本对齐方式,如果没有设置，就采用全局配置
  final Alignment? xBottomScaleLabelAlign;

  ///X轴底部刻度值颜色,如果没有设置，就采用全局配置
  final Color? xBottomScaleLabelColor;

  ///X轴底部刻度值字体大小,如果没有设置，就采用全局配置
  final double? xBottomScaleLabelSize;

  ///X轴底部刻度自定义，如果不为空，它的样式设置优先级最高
  final BaseChartYScaleStyle? xBottomScaleStyle;

  ///自定义X轴底部刻度渲染器
  final BaseChartYScaleRender? xBottomScaleRender;

  /*图表内容----------------------------------------------------------------------------------------------------------------------*/

  ///图表类型 如果为空或者是子项数据是 @link ChartTypeEnum.none 则表示不绘制任何内容
  ///但是注意 chartTypeList  chartStyleList  chartRenderList chartDataList 这三者的大小一定要一样并且子项数据顺序要一一对应
  List<ChartTypeEnum> chartTypeList;

  ///图表类型对应的风格样式,如果为空或者子项数据为空则表示，使用默认图表样式
  List<BaseChartContentStyle?>? chartStyleList;

  ///图表内容渲染器,如果为空且就根据chartTypeList中的内容来使用默认提供的渲染器来绘制
  List<BaseChartContentRender?>? chartRenderList;

  ///图表数据
  List<List<BaseContentData>> chartDataList;

  BaseChartWidget({super.key,
    this.width,
    this.height,
    required this.xMax,
    required this.xMin,
    required this.yMax,
    required this.yMin,
    required this.chartTypeList,
    required this.chartDataList,
    this.xGridEnable = false,
    this.xGridColor,
    this.xGridLineStyle,
    this.xGridDataList,
    this.xGridLineHeight,
    this.xGridStyle,
    this.xGridRender,
    this.yGridEnable = false,
    this.yGridColor,
    this.yGridLineStyle,
    this.yGridDataList,
    this.yGridLineHeight,
    this.yGridStyle,
    this.yGridRender,
    this.yLeftScaleEnable = true,
    this.yLeftScaleLineWidth,
    this.yLeftScaleLineType,
    this.yLeftScaleDataList,
    this.yLeftScaleLineColor,
    this.yLeftScaleLabelAlign,
    this.yLeftScaleLabelColor,
    this.yLeftScaleLabelSize,
    this.yLeftScaleStyle,
    this.yLeftScaleRender,
    this.yRightScaleEnable = false,
    this.yRightScaleLineWidth,
    this.yRightScaleLineType,
    this.yRightScaleDataList,
    this.yRightScaleLineColor,
    this.yRightScaleLabelAlign,
    this.yRightScaleLabelColor,
    this.yRightScaleLabelSize,
    this.yRightScaleStyle,
    this.yRightScaleRender,
    this.xTopScaleEnable = false,
    this.xTopScaleLineHeight,
    this.xTopScaleLineType,
    this.xTopScaleDataList,
    this.xTopScaleLineColor,
    this.xTopScaleLabelAlign,
    this.xTopScaleLabelColor,
    this.xTopScaleLabelSize,
    this.xTopScaleStyle,
    this.xTopScaleRender,
    this.xBottomScaleEnable = true,
    this.xBottomScaleLineHeight,
    this.xBottomScaleLineType,
    this.xBottomScaleDataList,
    this.xBottomScaleLineColor,
    this.xBottomScaleLabelAlign,
    this.xBottomScaleLabelColor,
    this.xBottomScaleLabelSize,
    this.xBottomScaleStyle,
    this.xBottomScaleRender,
    this.chartStyleList,
    this.chartRenderList});

  @override
  RenderObject createRenderObject(BuildContext context) {
    ChartBean(
        {required this.width,
          required this.height,
          required this.xMax,
          required this.xMin,
          required this.yMax,
          required this.yMin,
          this.xGridStyle,
          this.xGridRender,
          this.xGridDataList,
          this.yGridStyle,
          this.yGridRender,
          this.yGridDataList,
          this.yLeftScaleStyle,
          this.yLeftScaleRender,
          this.yLeftScaleDataList,
          this.yRightScaleStyle,
          this.yRightScaleRender,
          this.yRightScaleDataList,
          this.xTopScaleStyle,
          this.xTopScaleRender,
          this.xTopScaleDataList,
          this.xBottomScaleStyle,
          this.xBottomScaleRender,
          this.xBottomScaleDataList,
          this.chartStyleList,
          this.chartRenderList,
          this.chartDataList});
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
        chartRenderList: _chartRenderList));
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
  double? width;

  double? height;

  final double xMax;

  final double xMin;

  final double yMax;

  final double yMin;

  final BaseChartXGridStyle? xGridStyle;
  final BaseChartXGridRender? xGridRender;
  final List<BaseChartXGridData>? xGridDataList;
  final BaseChartYGridStyle? yGridStyle;
  final BaseChartYGridRender? yGridRender;
  final List<BaseChartXGridData>? yGridDataList;
  final BaseChartYScaleStyle? yLeftScaleStyle;
  final BaseChartYScaleRender? yLeftScaleRender;
  final List<BaseYScaleData>? yLeftScaleDataList;
  final BaseChartYScaleStyle? yRightScaleStyle;
  final BaseChartYScaleRender? yRightScaleRender;
  final List<BaseYScaleData>? yRightScaleDataList;
  final BaseChartYScaleStyle? xTopScaleStyle;
  final BaseChartYScaleRender? xTopScaleRender;
  final List<BaseYScaleData>? xTopScaleDataList;
  final BaseChartYScaleStyle? xBottomScaleStyle;
  final BaseChartYScaleRender? xBottomScaleRender;
  final List<BaseYScaleData>? xBottomScaleDataList;
  List<BaseChartContentStyle?>? chartStyleList;
  List<BaseChartContentRender?>? chartRenderList;
  List<List<BaseContentData>?>? chartDataList;

  ChartBean({ this.width,
    this.height,
    required this.xMax,
    required this.xMin,
    required this.yMax,
    required this.yMin,
    this.xGridStyle,
    this.xGridRender,
    this.xGridDataList,
    this.yGridStyle,
    this.yGridRender,
    this.yGridDataList,
    this.yLeftScaleStyle,
    this.yLeftScaleRender,
    this.yLeftScaleDataList,
    this.yRightScaleStyle,
    this.yRightScaleRender,
    this.yRightScaleDataList,
    this.xTopScaleStyle,
    this.xTopScaleRender,
    this.xTopScaleDataList,
    this.xBottomScaleStyle,
    this.xBottomScaleRender,
    this.xBottomScaleDataList,
    this.chartStyleList,
    this.chartRenderList,
    this.chartDataList});
}
