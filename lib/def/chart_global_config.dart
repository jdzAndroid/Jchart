import 'package:flutter/material.dart';
import 'package:jchart/def/bar/bar_chart_render.dart';
import 'package:jchart/def/bar/bar_chart_style.dart';
import 'package:jchart/def/hor_bar/hor_bar_render.dart';
import 'package:jchart/def/hor_bar/hor_bar_style.dart';
import 'package:jchart/def/line/line_chart_render.dart';
import 'package:jchart/def/style/chart_bottom_scale_def_style.dart';
import 'package:jchart/def/style/chart_left_scale_def_style.dart';
import 'package:jchart/def/style/chart_right_scale_def_style.dart';
import 'package:jchart/def/style/chart_top_scale_def_style.dart';
import 'package:jchart/def/style/chart_x_grid_default_style.dart';
import 'package:jchart/def/style/chart_y_grid_default_style.dart';
import 'package:jchart/enum/chart_type_enum.dart';

import '../base/render/base_chart_content_render.dart';
import '../base/render/base_chart_x_grid_render.dart';
import '../base/render/base_chart_x_scale_render.dart';
import '../base/render/base_chart_y_grid_render.dart';
import '../base/render/base_chart_y_scale_render.dart';
import '../base/style/base_chart_content_style.dart';
import 'line/line_chart_style.dart';

///Created by jdz on 2024/3/2 0002 22:33
///@brief 图表全局属性配置
class ChartGlobalConfig {
  ///线条默认粗细
  static const double lineDefSize = 1;

  ///线条默认颜色
  static const Color lineDefColor = Colors.grey;

  ///用于柱状图图表，表示单个柱子和平均分配后的宽度占比
  static const double barRadius = 1;

  ///柱状图默认填充色
  static const Color barColor = Colors.white;

  ///默认字体大小
  static const double fontSize = 20;

  ///默认字体颜色
  static const Color fontColor = Colors.black;

  ///默认虚线实体部分宽度
  static const double lineSolidWidth = 5;

  ///默认虚线虚体部分宽度
  static const double lineVisualWidth = 3;

  ///默认虚线实体部分线条颜色
  static const Color lineSolidColor = Colors.black;

  ///默认虚线虚体部分线条颜色
  static const Color lineVisualColor = Colors.transparent;

  ///获取默认顶部X轴网格线样式
  static ChartXGridDefStyle getXGridDefStyle() {
    return ChartXGridDefStyle(lineHeight: lineDefSize, color: lineDefColor);
  }

  ///获取默认顶部Y轴网格线样式
  static ChartYGridDefStyle getYGridDefStyle() {
    return ChartYGridDefStyle(lineWidth: lineDefSize, color: lineDefColor);
  }

  ///获取Y轴左侧刻度样式
  static ChartLeftScaleDefStyle getLeftScaleDefStyle() {
    return ChartLeftScaleDefStyle();
  }

  ///获取Y轴右侧刻度样式
  static ChartRightScaleDefStyle getRightScaleDefStyle() {
    return ChartRightScaleDefStyle();
  }

  ///获取X轴顶部刻度样式
  static ChartTopScaleDefStyle getTopScaleDefStyle() {
    return ChartTopScaleDefStyle();
  }

  ///获取X轴底部刻度样式
  static ChartBottomScaleDefStyle getBottomScaleDefStyle() {
    return ChartBottomScaleDefStyle();
  }

  ///X轴网格线渲染器
  static BaseChartXGridRender getXGridDefRender() {
    return BaseChartXGridRender();
  }

  ///Y轴网格线渲染器
  static BaseChartYGridRender getYGridDefRender() {
    return BaseChartYGridRender();
  }

  ///Y轴刻度渲染器
  static BaseChartYScaleRender getYScaleDefRender({required bool left}) {
    return BaseChartYScaleRender(left: left);
  }

  ///X轴刻度渲染器
  static BaseChartXScaleRender getXScaleDefRender({required bool top}) {
    return BaseChartXScaleRender(top: top);
  }

  ///通过图表类型获取对应的默认渲染器
  static BaseChartContentRender? getChartRender(ChartTypeEnum chartType) {
    BaseChartContentRender? result;
    switch (chartType) {
      case ChartTypeEnum.line:
        result = LineChartRender();
        break;
      case ChartTypeEnum.poleLine:
        break;
      case ChartTypeEnum.bar:
        result = BarChartRender();
        break;
      case ChartTypeEnum.heartRate:
        break;
      case ChartTypeEnum.step:
        break;
      case ChartTypeEnum.horBar:
        result = HorBarRender();
        break;
      case ChartTypeEnum.circle:
        break;
      case ChartTypeEnum.twoWayBar:
        break;
      case ChartTypeEnum.tempChange:
        break;
      case ChartTypeEnum.warn:
        break;
      case ChartTypeEnum.custom:
        break;
      default:
        break;
    }
    return result;
  }

  ///通过图表类型获取对应的默认样式
  static BaseChartContentStyle? getChartStyle(ChartTypeEnum chartType) {
    BaseChartContentStyle? result;
    switch (chartType) {
      case ChartTypeEnum.line:
        result = LineChartStyle();
        break;
      case ChartTypeEnum.poleLine:
        break;
      case ChartTypeEnum.bar:
        result = BarChartStyle(
            startColor: Colors.blueGrey, endColor: Colors.blueGrey);
        break;
      case ChartTypeEnum.heartRate:
        break;
      case ChartTypeEnum.step:
        break;
      case ChartTypeEnum.horBar:
        result =
            HorBarStyle(startColor: Colors.blueGrey, endColor: Colors.blueGrey);
        break;
      case ChartTypeEnum.circle:
        break;
      case ChartTypeEnum.twoWayBar:
        break;
      case ChartTypeEnum.tempChange:
        break;
      case ChartTypeEnum.warn:
        break;
      case ChartTypeEnum.custom:
        break;
      default:
        break;
    }
    return result;
  }
}
