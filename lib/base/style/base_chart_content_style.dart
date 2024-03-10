import '../../helper/chart_helper.dart';
import 'base_chart_style.dart';

///Created by jdz on 2024/2/28 0028 23:10
///@brief 图表内容样式基类
abstract class BaseChartContentStyle extends BaseChartStyle {
  ChartClick? chartClick;

  BaseChartContentStyle({super.color, this.chartClick});
}
