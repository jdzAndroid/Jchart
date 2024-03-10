import '../data/base_chart_grid_data.dart';
import '../data/base_draw_info.dart';
import '../style/base_chart_grid_style.dart';
import 'base_chart_decoration_render.dart';

///Created by jdz on 2024/2/28 0028 23:00
///@brief 图表网格线绘制基类
abstract class BaseChartGridRender<STYLE extends BaseChartGridStyle,
        INFO extends BaseDrawInfo, DATA extends BaseChartGridData>
    extends BaseChartDecorationRender<STYLE, INFO, DATA> {
  BaseChartGridRender(
      {required super.dataList, required super.style});
}
