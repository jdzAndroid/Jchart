import '../../def/chart_global_config.dart';
import '../../helper/chart_helper.dart';
import '../../enum/line_type_enum.dart';
import 'base_chart_decoration_style.dart';

///Created by jdz on 2024/2/28 0028 23:08
///@brief 图表网格线样式基类
abstract class BaseChartGridStyle extends BaseChartDecorationStyle {
  ///如果不为空，就通过网格线数值来计算其横向或者纵向中心点坐标，为空就按照数值比例平均分配
  GetPosition? getPosition;

  BaseChartGridStyle({super.color,
    super.lineWidth,
    super.lineHeight = ChartGlobalConfig.lineDefSize,
    super.lineType = LineTypeEnum.line,
    super.dashWidth,
    super.dashColor,
      this.getPosition});
}
