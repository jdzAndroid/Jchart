import 'package:flutter/material.dart';

import 'base_data.dart';

///Created by jdz on 2024/2/29 0029 22:22
///@brief X轴网格线数据
abstract class BaseChartGridData extends BaseData {
  double value = 0;

  ///线条颜色
  Color? color;

  ///网格线粗细
  double? size;

  BaseChartGridData({required this.value, this.color, this.size});
}
