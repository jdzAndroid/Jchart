import 'package:flutter/material.dart';

typedef GetLabel = String Function(double value);

///图表点击回调
///@param t 数据
///@param position 点在图表中的位置
///@param rect 点击点在图表中的范围
typedef ChartClick=bool Function<T>(T t,int position,Rect rect);
typedef GetPosition=double Function(double value);

///图表网格线默认粗细
const double chartGridSize=3;
///图表刻度线默认粗细
const double chartScaleSize=5;
///图表网格线默认颜色
const Color chartGridColor=Colors.grey;
///图表刻度线默认颜色
const Color chartScaleColor=Colors.black;

void printLog({required String message, String methodName = ""}) {
  debugPrint(">>>jChart:message:$message,methodName=$methodName");
}