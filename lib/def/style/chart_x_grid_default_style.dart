import '../../base/style/base_chart_x_grid_style.dart';
import '../../enum/line_type_enum.dart';
import '../chart_global_config.dart';

///Created by jdz on 2024/3/2 0002 22:36
///@brief 图表X轴网格线默认样式
class ChartXGridDefStyle extends BaseChartXGridStyle {
  ChartXGridDefStyle({super.color,
      super.lineWidth,
      super.lineHeight = ChartGlobalConfig.lineDefSize,
      super.lineType = LineTypeEnum.line,
      super.dashWidth,
      super.dashColor,
      super.getPosition});
}
