import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:jchart/def/chart_global_config.dart';

import '../enum/chart_type_enum.dart';
import '../enum/line_type_enum.dart';
import '../helper/chart_helper.dart';
import 'data/base_chart_x_grid_data.dart';
import 'data/base_chart_y_grid_data.dart';
import 'data/base_content_data.dart';
import 'data/base_draw_info.dart';
import 'data/base_x_scale_data.dart';
import 'data/base_y_scale_data.dart';
import 'render/base_chart_content_render.dart';
import 'render/base_chart_x_grid_render.dart';
import 'render/base_chart_x_scale_render.dart';
import 'render/base_chart_y_grid_render.dart';
import 'render/base_chart_y_scale_render.dart';
import 'style/base_chart_content_style.dart';
import 'style/base_chart_x_grid_style.dart';
import 'style/base_chart_x_scale_style.dart';
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

  ///X轴网格线类别,如果没有设置，就采用全局配置
  final LineTypeEnum? xGridLineType;

  ///X轴网格线数据
  final List<BaseChartXGridData>? xGridDataList;

  ///X轴网格线线条高度,如果没有设置，就采用全局配置
  final double? xGridLineHeight;

  ///自定义X轴网格线样式,如果不为空，它的样式设置优先级最高
  BaseChartXGridStyle? xGridStyle;

  ///自定义网格线渲染器,如果为空就用默认的
  BaseChartXGridRender? xGridRender;

  /*图表Y轴网格线属性----------------------------------------------------------------------------------------------------------------------*/

  ///是否绘制Y轴网格线，默认不绘制
  bool yGridEnable = false;

  ///Y轴网格线颜色,如果没有设置，就采用全局配置
  final Color? yGridColor;

  ///Y轴网格线风格,如果没有设置，就采用全局配置
  final LineTypeEnum? yGridLineType;

  ///Y轴网格线数据
  final List<BaseChartYGridData>? yGridDataList;

  ///Y轴网格线线条宽度,如果没有设置，就采用全局配置
  final double? yGridLineWidth;

  ///自定义Y轴网格线样式,如果不为空，它的样式设置优先级最高
  BaseChartYGridStyle? yGridStyle;

  ///自定义网格线渲染器,如果为空就用默认的
  BaseChartYGridRender? yGridRender;

  /*图表Y轴左侧刻度属性----------------------------------------------------------------------------------------------------------------------*/

  ///Y轴左侧刻度是否显示,默认显示
  bool yLeftScaleEnable = true;

  ///Y轴左侧刻度线宽度,如果没有设置，就采用全局配置
  final double? yLeftScaleLineWidth;

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
  BaseChartYScaleStyle? yLeftScaleStyle;

  ///自定义Y轴左侧刻度渲染器
  BaseChartYScaleRender? yLeftScaleRender;

  /*图表Y轴右侧刻度属性----------------------------------------------------------------------------------------------------------------------*/

  ///Y轴右侧刻度是否显示,默认不显示
  bool yRightScaleEnable = false;

  ///Y轴右侧刻度线宽度,如果没有设置，就采用全局配置
  final double? yRightScaleLineWidth;

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
  BaseChartYScaleStyle? yRightScaleStyle;

  ///自定义Y轴右侧刻度渲染器
  BaseChartYScaleRender? yRightScaleRender;

  /*图表X轴顶部刻度属性----------------------------------------------------------------------------------------------------------------------*/

  ///X轴顶部刻度是否显示,默认不显示
  bool xTopScaleEnable = false;

  ///X轴顶部刻度线高度,如果没有设置，就采用全局配置
  final double? xTopScaleLineHeight;

  ///X轴顶部刻度线风格,如果没有设置，就采用全局配置
  final LineTypeEnum? xTopScaleLineType;

  ///X轴顶部刻度数据
  final List<BaseXScaleData>? xTopScaleDataList;

  ///X轴顶部刻度线颜色,如果没有设置，就采用全局配置
  final Color? xTopScaleLineColor;

  ///X轴顶部刻度线文本对齐方式,如果没有设置，就采用全局配置
  final Alignment? xTopScaleLabelAlign;

  ///X轴顶部刻度值颜色,如果没有设置，就采用全局配置
  final Color? xTopScaleLabelColor;

  ///X轴顶部刻度值字体大小,如果没有设置，就采用全局配置
  final double? xTopScaleLabelSize;

  ///X轴顶部刻度自定义，如果不为空，它的样式设置优先级最高
  BaseChartXScaleStyle? xTopScaleStyle;

  ///自定义X轴顶部刻度渲染器
  BaseChartXScaleRender? xTopScaleRender;

  /*图表X轴底部刻度属性----------------------------------------------------------------------------------------------------------------------*/

  ///X轴底部刻度是否显示,默认显示
  bool xBottomScaleEnable = true;

  ///X轴底部刻度线高度,如果没有设置，就采用全局配置
  final double? xBottomScaleLineHeight;

  ///X轴底部刻度线风格,如果没有设置，就采用全局配置
  final LineTypeEnum? xBottomScaleLineType;

  ///X轴底部刻度数据
  final List<BaseXScaleData>? xBottomScaleDataList;

  ///X轴底部刻度线颜色,如果没有设置，就采用全局配置
  final Color? xBottomScaleLineColor;

  ///X轴底部刻度线文本对齐方式,如果没有设置，就采用全局配置
  final Alignment? xBottomScaleLabelAlign;

  ///X轴底部刻度值颜色,如果没有设置，就采用全局配置
  final Color? xBottomScaleLabelColor;

  ///X轴底部刻度值字体大小,如果没有设置，就采用全局配置
  final double? xBottomScaleLabelSize;

  ///X轴底部刻度自定义，如果不为空，它的样式设置优先级最高
  BaseChartXScaleStyle? xBottomScaleStyle;

  ///自定义X轴底部刻度渲染器
  BaseChartXScaleRender? xBottomScaleRender;

  /*图表内容----------------------------------------------------------------------------------------------------------------------*/

  ///图表类型 如果为空或者是子项数据是 @link ChartTypeEnum.none 则表示不绘制任何内容
  ///但是注意 chartTypeList  chartStyleList  chartRenderList chartDataList 这三者的大小一定要一样并且子项数据顺序要一一对应
  List<ChartTypeEnum>? chartTypeList;

  ///图表类型对应的风格样式,如果为空或者子项数据为空则表示，使用默认图表样式
  List<BaseChartContentStyle?>? chartStyleList;

  ///图表内容渲染器,如果为空且就根据chartTypeList中的内容来使用默认提供的渲染器来绘制
  List<BaseChartContentRender?>? chartRenderList;

  ///图表数据
  List<List<BaseContentData>?>? chartDataList;

  BaseChartWidget(
      {super.key,
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
      this.xGridLineType,
      this.xGridDataList,
      this.xGridLineHeight,
      this.xGridStyle,
      this.xGridRender,
      this.yGridEnable = false,
      this.yGridColor,
      this.yGridLineType,
      this.yGridDataList,
      this.yGridLineWidth,
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
      this.chartRenderList}) {
    assert(xMin < xMax, "xMin<xMax($xMin<$xMax) invalid");
    assert(yMin < yMax, "yMin<yMax($yMin<$yMax) invalid");
    _initXGridAttr();
    _initYGridAttr();
    _initYLeftScaleAttr();
    _initYRightScaleAttr();
    _initXTopScaleAttr();
    _initXBottomScaleAttr();
    _initChartAttr();
  }

  void _initXGridAttr() {
    xGridStyle ??= ChartGlobalConfig.getXGridDefStyle();
    if (xGridColor != null) {
      xGridStyle?.color = xGridColor;
    }
    if (xGridLineType != null) {
      xGridStyle?.lineType = xGridLineType!;
    }
    if (xGridLineHeight != null) {
      xGridStyle?.lineHeight = xGridLineHeight!;
    }
    xGridRender ??= ChartGlobalConfig.getXGridDefRender();
    xGridRender?.setStyle(xGridStyle!);
    xGridRender?.setDataList(xGridDataList);
  }

  void _initYGridAttr() {
    yGridStyle ??= ChartGlobalConfig.getYGridDefStyle();
    if (yGridColor != null) {
      yGridStyle?.color = yGridColor;
    }
    if (yGridLineType != null) {
      yGridStyle?.lineType = yGridLineType!;
    }
    if (yGridLineWidth != null) {
      yGridStyle?.lineWidth = yGridLineWidth!;
    }
    yGridRender ??= ChartGlobalConfig.getYGridDefRender();
    yGridRender?.setStyle(yGridStyle!);
    yGridRender?.setDataList(yGridDataList);
  }

  void _initYLeftScaleAttr() {
    yLeftScaleStyle ??= ChartGlobalConfig.getLeftScaleDefStyle();
    if (yLeftScaleLineWidth != null) {
      yLeftScaleStyle?.lineWidth = yLeftScaleLineWidth!;
    }
    if (yLeftScaleLineType != null) {
      yLeftScaleStyle?.lineType = yLeftScaleLineType!;
    }
    if (yLeftScaleLineColor != null) {
      yLeftScaleStyle?.color = yLeftScaleLineColor!;
    }
    if (yLeftScaleLabelAlign != null) {
      yLeftScaleStyle?.labelAlign = yLeftScaleLabelAlign!;
    }
    if (yLeftScaleLabelColor != null) {
      yLeftScaleStyle!.labelStyle =
          yLeftScaleStyle!.labelStyle.copyWith(color: yLeftScaleLabelColor!);
    }
    if (yLeftScaleLabelSize != null) {
      yLeftScaleStyle!.labelStyle =
          yLeftScaleStyle!.labelStyle.copyWith(fontSize: yLeftScaleLabelSize!);
    }
    yLeftScaleRender ??= ChartGlobalConfig.getYScaleDefRender(left: true);
    yLeftScaleRender?.setStyle(yLeftScaleStyle!);
    yLeftScaleRender?.setDataList(yLeftScaleDataList);
  }

  void _initYRightScaleAttr() {
    yRightScaleStyle ??= ChartGlobalConfig.getLeftScaleDefStyle();
    if (yRightScaleLineWidth != null) {
      yRightScaleStyle?.lineWidth = yRightScaleLineWidth!;
    }
    if (yRightScaleLineType != null) {
      yRightScaleStyle?.lineType = yRightScaleLineType!;
    }
    if (yRightScaleLineColor != null) {
      yRightScaleStyle?.color = yRightScaleLineColor!;
    }
    if (yRightScaleLabelAlign != null) {
      yRightScaleStyle?.labelAlign = yRightScaleLabelAlign!;
    }
    if (yRightScaleLabelColor != null) {
      yRightScaleStyle!.labelStyle =
          yRightScaleStyle!.labelStyle.copyWith(color: yRightScaleLabelColor!);
    }
    if (yRightScaleLabelSize != null) {
      yRightScaleStyle!.labelStyle = yRightScaleStyle!.labelStyle
          .copyWith(fontSize: yRightScaleLabelSize!);
    }
    yRightScaleRender ??= ChartGlobalConfig.getYScaleDefRender(left: false);
    yRightScaleRender?.setStyle(yRightScaleStyle!);
    yRightScaleRender?.setDataList(yRightScaleDataList);
  }

  void _initXTopScaleAttr() {
    xTopScaleStyle ??= ChartGlobalConfig.getTopScaleDefStyle();
    if (xTopScaleLineHeight != null) {
      xTopScaleStyle?.lineHeight = xTopScaleLineHeight!;
    }
    if (xTopScaleLineType != null) {
      xTopScaleStyle?.lineType = xTopScaleLineType!;
    }
    if (xTopScaleLineColor != null) {
      xTopScaleStyle?.color = xTopScaleLineColor!;
    }
    if (xTopScaleLabelAlign != null) {
      xTopScaleStyle?.labelAlign = xTopScaleLabelAlign!;
    }
    if (xTopScaleLabelColor != null) {
      xTopScaleStyle!.labelStyle =
          xTopScaleStyle!.labelStyle.copyWith(color: xTopScaleLabelColor!);
    }
    if (xTopScaleLabelSize != null) {
      xTopScaleStyle!.labelStyle =
          xTopScaleStyle!.labelStyle.copyWith(fontSize: xTopScaleLabelSize!);
    }
    xTopScaleRender ??= ChartGlobalConfig.getXScaleDefRender(top: true);
    xTopScaleRender?.setStyle(xTopScaleStyle!);
    xTopScaleRender?.setDataList(xTopScaleDataList);
  }

  void _initXBottomScaleAttr() {
    xBottomScaleStyle ??= ChartGlobalConfig.getBottomScaleDefStyle();
    if (xBottomScaleLineHeight != null) {
      xBottomScaleStyle?.lineHeight = xBottomScaleLineHeight!;
    }
    if (xBottomScaleLineType != null) {
      xBottomScaleStyle?.lineType = xBottomScaleLineType!;
    }
    if (xBottomScaleLineColor != null) {
      xBottomScaleStyle?.color = xBottomScaleLineColor!;
    }
    if (xBottomScaleLabelAlign != null) {
      xBottomScaleStyle?.labelAlign = xBottomScaleLabelAlign!;
    }
    if (xBottomScaleLabelColor != null) {
      xBottomScaleStyle!.labelStyle = xBottomScaleStyle!.labelStyle
          .copyWith(color: xBottomScaleLabelColor!);
    }
    if (xBottomScaleLabelSize != null) {
      xBottomScaleStyle!.labelStyle = xBottomScaleStyle!.labelStyle
          .copyWith(fontSize: xBottomScaleLabelSize!);
    }
    xBottomScaleRender ??= ChartGlobalConfig.getXScaleDefRender(top: false);
    xBottomScaleRender?.setStyle(xBottomScaleStyle!);
    xBottomScaleRender?.setDataList(xBottomScaleDataList);
  }

  void _initChartAttr() {
    if (chartTypeList == null || chartTypeList!.isEmpty) {
      printLog(message: "图表类型列表为空", methodName: "_initChartAttr");
      chartDataList?.clear();
      chartStyleList?.clear();
      chartRenderList?.clear();
      return;
    }
    List<int> countList = List.empty(growable: true);
    countList.add(chartTypeList!.length);
    if (chartDataList != null) {
      countList.add(chartDataList!.length);
    }
    if (chartStyleList != null) {
      countList.add(chartStyleList!.length);
    }
    if (chartRenderList != null) {
      countList.add(chartRenderList!.length);
    }
    int count = 0;
    for (var itemCount in countList) {
      if (count == 0) {
        count = itemCount;
        continue;
      }
      if (count != itemCount) {
        printLog(message: "图表内容属性大小不一致", methodName: "_initChartAttr");
        chartDataList?.clear();
        chartStyleList?.clear();
        chartRenderList?.clear();
        return;
      }
    }
    for (int index = 0; index < count; index++) {
      ChartTypeEnum itemType = chartTypeList![index];
      if (itemType != ChartTypeEnum.none &&
          itemType != ChartTypeEnum.custom &&
          chartRenderList![index] == null) {
        chartRenderList![index] = ChartGlobalConfig.getChartRender(itemType);
      }
      chartRenderList![index]?.setStyle(
          chartStyleList![index] ?? ChartGlobalConfig.getChartStyle(itemType)!);
      chartRenderList![index]?.setDataList(chartDataList![index]);
    }
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    return BaseChartRenderObject(
        width: width,
        height: height,
        xMax: xMax,
        xMin: xMin,
        yMax: xMin,
        yMin: xMin,
        xGridRender: xGridRender,
        yGridRender: yGridRender,
        yLeftScaleRender: yLeftScaleRender,
        yRightScaleRender: yRightScaleRender,
        xTopScaleRender: xTopScaleRender,
        xBottomScaleRender: xBottomScaleRender,
        chartStyleList: chartStyleList,
        chartRenderList: chartRenderList,
        chartDataList: chartDataList);
  }
}

class BaseChartRenderObject extends RenderBox {
  double? width;

  double? height;

  final double xMax;

  final double xMin;

  final double yMax;

  final double yMin;

  final BaseChartXGridRender? xGridRender;
  final BaseChartYGridRender? yGridRender;
  final BaseChartYScaleRender? yLeftScaleRender;
  final BaseChartYScaleRender? yRightScaleRender;
  final BaseChartXScaleRender? xTopScaleRender;
  final BaseChartXScaleRender? xBottomScaleRender;
  List<BaseChartContentStyle?>? chartStyleList;
  List<BaseChartContentRender?>? chartRenderList;
  List<List<BaseContentData>?>? chartDataList;

  BaseChartRenderObject(
      {this.width,
      this.height,
      required this.xMax,
      required this.xMin,
      required this.yMax,
      required this.yMin,
      this.xGridRender,
      this.yGridRender,
      this.yLeftScaleRender,
      this.yRightScaleRender,
      this.xTopScaleRender,
      this.xBottomScaleRender,
      this.chartStyleList,
      this.chartRenderList,
      this.chartDataList});

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    result.add(BoxHitTestEntry(this, position));
    if (chartRenderList == null || chartRenderList!.isEmpty) {
      return false;
    }

    bool needRefresh = false;
    for (BaseChartContentRender? render in chartRenderList!) {
      if (render == null) {
        continue;
      }
      if (render.hitTestSelf(position)) {
        needRefresh = true;
      }
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
    if (xMin >= xMax) return;
    if (yMin >= yMax) return;
    double w = width ?? constraints.maxWidth;
    double h = height ?? constraints.maxHeight;
    BaseDrawInfo drawInfo = BaseDrawInfo(
        w: w, h: h, xMax: xMax, xMin: xMin, yMax: yMax, yMin: yMin);
    printLog(message: "w:$w,h:$h", methodName: "paint");
    yLeftScaleRender?.setInfo(drawInfo);
    Rect leftScaleRect = yLeftScaleRender?.getDrawArea() ?? Rect.zero;
    leftScaleRect = leftScaleRect.shift(offset);
    printLog(message: "leftScaleRect:$leftScaleRect", methodName: "paint");

    yRightScaleRender?.setInfo(drawInfo);
    Rect rightScaleRect = yRightScaleRender?.getDrawArea() ?? Rect.zero;
    rightScaleRect = rightScaleRect.shift(offset);
    printLog(message: "rightScaleRect:$rightScaleRect", methodName: "paint");

    xTopScaleRender?.setInfo(drawInfo);
    Rect topScaleRect = xTopScaleRender?.getDrawArea() ?? Rect.zero;
    topScaleRect = topScaleRect.shift(offset);
    printLog(message: "topScaleRect:$topScaleRect", methodName: "paint");

    xBottomScaleRender?.setInfo(drawInfo);
    Rect bottomScaleRect = xBottomScaleRender?.getDrawArea() ?? Rect.zero;
    bottomScaleRect = bottomScaleRect.shift(offset);
    printLog(message: "bottomScaleRect:$bottomScaleRect", methodName: "paint");

    Rect contentRect = Rect.fromLTRB(leftScaleRect.right, topScaleRect.bottom,
        rightScaleRect.left, bottomScaleRect.top);
    printLog(message: "contentRect:$contentRect", methodName: "paint");

    xGridRender?.setInfo(drawInfo);
    xGridRender?.draw(context, contentRect, contentRect);

    yGridRender?.setInfo(drawInfo);
    yGridRender?.draw(context, contentRect, contentRect);
    yLeftScaleRender?.draw(context, leftScaleRect, contentRect);

    xTopScaleRender?.draw(context, topScaleRect, contentRect);

    yRightScaleRender?.draw(context, rightScaleRect, contentRect);

    xBottomScaleRender?.draw(context, bottomScaleRect, contentRect);

    if (chartRenderList != null) {
      for (int index = 0; index < chartRenderList!.length; index++) {
        chartRenderList![index]?.setInfo(drawInfo);
        chartRenderList![index]?.draw(context, contentRect, contentRect);
      }
    }
  }
}
