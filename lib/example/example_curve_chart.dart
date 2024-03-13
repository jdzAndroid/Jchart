import 'package:flutter/material.dart';
import 'package:jchart/def/curve_chart/curve_chart_render.dart';
import 'package:jchart/j_chart.dart';

import '../def/curve_chart/curve_chart_data.dart';
import '../def/curve_chart/curve_chart_style.dart';
import 'example_chart_widget.dart';

class ExampleCurveChart extends BaseExampleChartWidget {
  ExampleCurveChart({super.key, required super.width, required super.height});

  @override
  Widget buildChart(BuildContext context) {
    return BaseChartWidget(
      xMin: 1,
      xMax: 12,
      yMin: 1,
      yMax: 20,
      width: width,
      height: height,
      xGridRender: BaseChartXGridRender(
          dataList: List.generate(
              5,
              (index) => BaseChartXGridData(
                  value: 4.0 * (index + 1), color: Colors.primaries[index])),
          style: ChartGlobalConfig.getXGridDefStyle()..color = Colors.red),
      yGridRender: BaseChartYGridRender(
          dataList: List.generate(
              6,
              (index) => BaseChartYGridData(
                  value: (index + 1) * 2.toDouble(),
                  color: Colors.primaries[index])),
          style: ChartGlobalConfig.getYGridDefStyle()..color = Colors.red),
      leftScaleRender: BaseChartYScaleRender(
          dataList: List.generate(
              5,
              (index) => BaseYScaleData(
                  value: 4.0 * (index + 1),
                  label: (4 * (index + 1)).toString(),
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
              5,
              (index) => BaseYScaleData(
                  value: 4.0 * (index + 1),
                  label: (4 * (index + 1)).toString())),
          style: ChartGlobalConfig.getRightScaleDefStyle()
            ..color = Colors.green
            ..labelAlign = Alignment.center
            ..showLabel = true
            ..labelPadding = EdgeInsets.only(left: 2),
          left: false),
      bottomScaleRender: BaseChartXScaleRender(
          dataList: List.generate(
              6,
              (index) => BaseXScaleData(
                  value: (index + 1) * 2, label: ((index + 1) * 2).toString())),
          style: ChartGlobalConfig.getBottomScaleDefStyle()
            ..labelAlign = Alignment.center,
          top: false),
      topScaleRender: BaseChartXScaleRender(
          dataList: List.generate(
              6,
              (index) => BaseXScaleData(
                  value: (index + 1.0) * 2,
                  label: ((index + 1) * 2).toString())),
          style: ChartGlobalConfig.getTopScaleDefStyle()
            ..labelAlign = Alignment.center,
          top: true),
      chartRenderList: [
        CurveChartRender(
            style: CurveChartStyle(
                shaderStartColor: Colors.white,
                shaderEndColor: Colors.yellow,
                showLabel: true,
                lineColor: Colors.green,
                lineHeight: 10),
            dataList: List.generate(
                4,
                (index) => CurveChartData(
                    x: (index + 1) * 3,
                    y: (index + 1) * 5,
                    label: index.toString())))
      ],
    );
  }
}
