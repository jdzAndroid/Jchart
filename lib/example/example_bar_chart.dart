import 'package:flutter/material.dart';
import 'package:jchart/enum/chart_type_enum.dart';
import 'package:jchart/j_chart.dart';

import 'example_chart_widget.dart';

class ExampleBarChart extends BaseExampleChartWidget {
  ExampleBarChart({super.key, required super.width, required super.height});

  @override
  Widget buildChart(BuildContext context) {
    return BaseChartWidget(
      xMin: 1,
      xMax: 12,
      yMin: 1,
      yMax: 100,
      width: width,
      height: height,
      xGridEnable: true,
      chartTypeList: const [ChartTypeEnum.bar],
      xGridDataList: List.generate(
          5,
          (index) => BaseChartXGridData(
              value: (index + 1) * 20.0, color: Colors.primaries[index])),
      yGridEnable: true,
      yGridDataList: List.generate(
          12,
          (index) => BaseChartYGridData(
              value: index + 1, color: Colors.primaries[index])),
      yLeftScaleEnable: true,
      yLeftScaleDataList: List.generate(
          5,
          (index) => BaseYScaleData(
              value: (index + 1) * 20, label: ((index + 1) * 20).toString())),
      xBottomScaleEnable: true,
      xBottomScaleDataList: List.generate(
          12,
          (index) => BaseXScaleData(
              value: (index + 1), label: ((index + 1)).toString())),
      chartDataList: [
        List.generate(
            12,
            (index) => BarChartData(
                xValue: (index + 1).toDouble(),
                startValue: 1,
                endValue: (index + 1) * 8,
                topRadius: const Radius.circular(16),
                bottomRadius: const Radius.circular(16),
                radius: 0.7))
      ],
    );
  }
}
