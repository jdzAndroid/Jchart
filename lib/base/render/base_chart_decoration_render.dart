import 'dart:ui';

import '../data/base_data.dart';
import '../data/base_draw_info.dart';
import '../style/base_chart_style.dart';
import 'base_chart_render.dart';

///Created by jdz on 2024/3/2 0002 21:24
///@brief 图表周边装饰UI渲染
abstract class BaseChartDecorationRender<
    STYLE extends BaseChartStyle,
    INFO extends BaseDrawInfo,
    DATA extends BaseData> extends BaseChartRender<STYLE, INFO, DATA> {

  BaseChartDecorationRender();

  ///获取图表周边UI绘制区域,返回null，表示绘制区域自适应
  Rect? getDrawArea();
}
