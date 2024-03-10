import 'base_chart_style.dart';

///Created by jdz on 2024/3/3 0003 11:24
///@brief 图表周边UI样式基类
abstract class BaseChartDecorationStyle extends BaseChartStyle {
  ///网格线宽度,如果为null，表示网格线宽度填充该方向剩余所有空间
  double? width;

  ///网格线粗细
  double? height;

  BaseChartDecorationStyle({this.width, this.height,super.color});
}
