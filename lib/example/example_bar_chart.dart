import 'package:flutter/material.dart';
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
      xGridRender: BaseChartXGridRender(
          dataList: List.generate(
              4,
              (index) => BaseChartXGridData(
                  value: 20.0 * (index + 1), color: Colors.primaries[index])),
          style: ChartGlobalConfig.getXGridDefStyle()..color = Colors.red),
      yGridRender: BaseChartYGridRender(
          dataList: List.generate(
              0,
              (index) => BaseChartYGridData(
                  value: (index + 1).toDouble(),
                  color: Colors.primaries[index])),
          style: ChartGlobalConfig.getYGridDefStyle()..color = Colors.red),
      leftScaleRender: BaseChartYScaleRender(
          dataList: List.generate(
              0,
              (index) => BaseYScaleData(
                  value: 20.0 * (index + 1),
                  label: (20 * (index + 1)).toString(),
                  labelPadding:
                      index == 4 ? null : const EdgeInsets.only(left: 4))),
          style: ChartGlobalConfig.getLeftScaleDefStyle()
            ..color = Colors.green
            ..labelAlign = Alignment.center
            ..showLabel = true
            ..labelPadding = const EdgeInsets.only(right: 4),
          left: true),
      rightScaleRender: BaseChartYScaleRender(
          dataList: List.generate(
              0,
              (index) => BaseYScaleData(
                  value: 20.0 * (index + 1),
                  label: (20 * (index + 1)).toString())),
          style: ChartGlobalConfig.getRightScaleDefStyle()
            ..color = Colors.green
            ..labelAlign = Alignment.center
            ..showLabel = true
            ..labelPadding = EdgeInsets.only(left: 2),
          left: false),
      bottomScaleRender: BaseChartXScaleRender(
          dataList: List.generate(
              0,
              (index) => BaseXScaleData(
                  value: (index + 1), label: ((index + 1)).toString())),
          style: ChartGlobalConfig.getBottomScaleDefStyle()
            ..labelAlign = Alignment.center,
          top: false),
      // topScaleRender: BaseChartXScaleRender(
      //     dataList: List.generate(
      //         0,
      //         (index) => BaseXScaleData(
      //             value: (index + 1.0), label: ((index + 1)).toString())),
      //     style: ChartGlobalConfig.getTopScaleDefStyle()
      //       ..labelAlign = Alignment.center,
      //     top: true),
      // chartRenderList: [
      //   BarChartRender(
      //       style: BarChartStyle(
      //           startColor: Colors.yellow,
      //           endColor: Colors.red,
      //           topRadius: const Radius.circular(16),
      //           bottomRadius: const Radius.circular(16),
      //           radius: 0.8),
      //       dataList: List.generate(
      //           0,
      //           (index) => BarChartData(
      //               xValue: (index + 1).toDouble(),
      //               startValue: 1,
      //               endValue: (index + 1) * 8,
      //               topRadius: const Radius.circular(16),
      //               bottomRadius: const Radius.circular(16),
      //               radius: 0.7))
      //   )
      // ],
    );
  }
}
