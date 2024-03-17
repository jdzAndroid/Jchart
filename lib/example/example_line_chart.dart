import 'package:flutter/material.dart';
import 'package:jchart/def/line/line_chart_data.dart';
import 'package:jchart/enum/chart_type_enum.dart';
import 'package:jchart/j_chart.dart';

import 'example_chart_widget.dart';

class ExampleLineChart extends BaseExampleChartWidget {
  ExampleLineChart({super.key, required super.width, required super.height});

  @override
  Widget buildChart(BuildContext context) {
    return BaseChartWidget(
      xMin: 1,
      xMax: 12,
      yMin: 1,
      yMax: 20,
      width: width,
      height: height,
      xGridEnable: true,
      xGridDataList: List.generate(
          5,
          (index) => BaseChartXGridData(
              value: 4.0 * (index + 1), color: Colors.primaries[index])),
      yGridEnable: true,
      yGridDataList: List.generate(
          6,
          (index) => BaseChartYGridData(
              value: (index + 1) * 2.toDouble(),
              color: Colors.primaries[index])),
      yLeftScaleEnable: true,
      yLeftScaleDataList: List.generate(
          5,
          (index) => BaseYScaleData(
              value: 4.0 * (index + 1),
              label: (4 * (index + 1)).toString(),
              labelPadding:
                  index == 4 ? null : const EdgeInsets.only(left: 4))),
      xBottomScaleEnable: true,
      xBottomScaleDataList: List.generate(
          6,
          (index) => BaseXScaleData(
              value: (index + 1) * 2, label: ((index + 1) * 2).toString())),
      chartTypeList: const [ChartTypeEnum.line],
      chartDataList: [
        List.generate(
            4,
            (index) => LineChartData(
                xValue: (index + 1) * 2.toDouble(),
                yValue: 5 * (index + 1),
                supportSel: true))
      ],
    );
  }
}
