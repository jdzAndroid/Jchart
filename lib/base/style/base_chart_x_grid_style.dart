import '../../def/chart_global_config.dart';
import '../../line_type_enum.dart';
import 'base_chart_grid_style.dart';

///Created by jdz on 2024/2/29 13:27
///@brief 图表X轴网格线样式
class BaseChartXGridStyle extends BaseChartGridStyle {
  BaseChartXGridStyle({super.color,
      super.lineWidth,
      super.lineHeight = ChartGlobalConfig.lineDefSize,
      super.lineType = LineTypeEnum.line,
      super.dashWidth,
      super.dashColor,
      super.getPosition});
}
