
import '../data/base_draw_info.dart';
import '../data/base_scale_data.dart';
import '../style/base_chart_scale_style.dart';
import 'base_chart_decoration_render.dart';

///Created by jdz on 2024/2/28 0028 23:02
///@brief 图表标签绘制基类
abstract class BaseChartScaleRender<STYLE extends BaseChartScaleStyle,
INFO extends BaseDrawInfo,DATA extends BaseScaleData> extends BaseChartDecorationRender<STYLE,INFO,DATA>{
  BaseChartScaleRender(
      {required super.dataList, required super.style});
}