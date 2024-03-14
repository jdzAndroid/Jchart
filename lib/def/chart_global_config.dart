import 'package:flutter/material.dart';
import 'package:jchart/def/style/chart_bottom_scale_def_style.dart';
import 'package:jchart/def/style/chart_left_scale_def_style.dart';
import 'package:jchart/def/style/chart_right_scale_def_style.dart';
import 'package:jchart/def/style/chart_top_scale_def_style.dart';
import 'package:jchart/def/style/chart_x_grid_default_style.dart';
import 'package:jchart/def/style/chart_y_grid_default_style.dart';

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

  ///获取默认底部X轴刻度样式
  static ChartBottomScaleDefStyle getBottomScaleDefStyle() {
    return ChartBottomScaleDefStyle(
        lineHeight: lineDefSize,
        color: lineDefColor,
        showLabel: true,
        labelStyle: const TextStyle(color: fontColor, fontSize: fontSize));
  }

  ///获取默认左边Y轴刻度样式
  static ChartLeftScaleDefStyle getLeftScaleDefStyle() {
    return ChartLeftScaleDefStyle(
        lineWidth: lineDefSize,
        color: lineDefColor,
        showLabel: true,
        showOut: true,
        labelStyle: const TextStyle(color: fontColor, fontSize: fontSize));
  }

  ///获取默认右边Y轴刻度样式
  static ChartRightScaleDefStyle getRightScaleDefStyle() {
    return ChartRightScaleDefStyle(
        lineWidth: lineDefSize,
        color: lineDefColor,
        showLabel: true,
        showOut: true,
        labelStyle: const TextStyle(color: fontColor, fontSize: fontSize));
  }

  ///获取默认顶部X轴刻度样式
  static ChartTopScaleDefStyle getTopScaleDefStyle() {
    return ChartTopScaleDefStyle(
        lineHeight: lineDefSize,
        color: lineDefColor,
        showLabel: true,
        showOut: true,
        labelStyle: const TextStyle(color: fontColor, fontSize: fontSize));
  }

  ///获取默认顶部X轴网格线样式
  static ChartXGridDefStyle getXGridDefStyle() {
    return ChartXGridDefStyle(lineHeight: lineDefSize, color: lineDefColor);
  }

  ///获取默认顶部Y轴网格线样式
  static ChartYGridDefStyle getYGridDefStyle() {
    return ChartYGridDefStyle(lineWidth: lineDefSize, color: lineDefColor);
  }
}
