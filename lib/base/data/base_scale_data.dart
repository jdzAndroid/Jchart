import 'package:flutter/material.dart';

import '../../helper/chart_helper.dart';
import 'base_data.dart';

///Created by jdz on 2024/2/29 0029 22:31
///@brief 刻度线数据基类
class BaseScaleData extends BaseData {
  ///刻度值
  double value = 0;

  ///是否显示标签
  bool? showLabel;

  ///刻度标签
  String? label;

  TextStyle? textStyle;

  ///标签文本对齐方式
  Alignment? labelAlign;

  EdgeInsets? labelPadding;

  ///动态获取标签值
  GetLabel? getLabel;

  BaseScaleData(
      {required this.value,
      this.showLabel,
      this.label,
      this.textStyle,
      this.getLabel,
      this.labelAlign,
      this.labelPadding});
}
