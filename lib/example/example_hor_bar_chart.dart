import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jchart/def/hor_bar/hor_bar_data.dart';
import 'package:jchart/enum/chart_type_enum.dart';
import 'package:jchart/j_chart.dart';

import 'example_chart_widget.dart';

class ExampleHorBarChart extends BaseExampleChartWidget {
  ExampleHorBarChart({super.key, required super.width, required super.height});

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
      xGridDataList: List.generate(
          5,
          (index) => BaseChartXGridData(
              value: 20.0 * (index + 1), color: Colors.primaries[index])),
      yGridEnable: true,
      yGridDataList: List.generate(
          12,
          (index) => BaseChartYGridData(
              value: (index + 1).toDouble(), color: Colors.primaries[index])),
      yLeftScaleEnable: true,
      yLeftScaleDataList: List.generate(
          5,
          (index) => BaseYScaleData(
              value: 20.0 * (index + 1),
              label: (20 * (index + 1)).toString(),
              labelPadding:
                  index == 4 ? null : const EdgeInsets.only(left: 4))),
      xBottomScaleEnable: true,
      xBottomScaleDataList: List.generate(
          12,
          (index) => BaseXScaleData(
              value: (index + 1), label: ((index + 1)).toString())),
      chartTypeList: const [ChartTypeEnum.horBar],
      chartDataList: [
        List.generate(
            5,
            (index) => HorBarData(
                  startColor: null,
                  endColor: null,
                  yStartValue: max(1, 100 - (index + 1) * 20),
                  yEndValue: 100 - index * 20,
                  xStartValue: 1,
                  xEndValue: (index + 1) * 2,
                  label: (index + 1).toString(),
                  labelLeft: false,
                ))
      ],
    );
  }
}
