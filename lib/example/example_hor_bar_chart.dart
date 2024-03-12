import 'package:flutter/material.dart';
import 'package:jchart/def/hor_bar/hor_bar_data.dart';
import 'package:jchart/def/hor_bar/hor_bar_render.dart';
import 'package:jchart/def/hor_bar/hor_bar_style.dart';
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
      xGridRender: BaseChartXGridRender(
          dataList: List.generate(
              5,
              (index) => BaseChartXGridData(
                  value: 20.0 * (index + 1), color: Colors.primaries[index])),
          style: ChartGlobalConfig.getXGridDefStyle()..color = Colors.red),
      yGridRender: BaseChartYGridRender(
          dataList: List.generate(
              12,
              (index) => BaseChartYGridData(
                  value: (index + 1).toDouble(),
                  color: Colors.primaries[index])),
          style: ChartGlobalConfig.getYGridDefStyle()..color = Colors.red),
      leftScaleRender: BaseChartYScaleRender(
          dataList: List.generate(
              5,
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
              5,
              (index) => BaseYScaleData(
                  value: 20.0 * (index + 1),
                  label: (20 * (index + 1)).toString())),
          style: ChartGlobalConfig.getRightScaleDefStyle()
            ..color = Colors.green
            ..labelAlign = Alignment.center
            ..showLabel = true
            ..labelPadding = const EdgeInsets.only(left: 2),
          left: false),
      bottomScaleRender: BaseChartXScaleRender(
          dataList: List.generate(
              12,
              (index) => BaseXScaleData(
                  value: (index + 1), label: ((index + 1)).toString())),
          style: ChartGlobalConfig.getBottomScaleDefStyle()
            ..labelAlign = Alignment.center,
          top: false),
      topScaleRender: BaseChartXScaleRender(
          dataList: List.generate(
              12,
              (index) => BaseXScaleData(
                  value: (index + 1.0), label: ((index + 1)).toString())),
          style: ChartGlobalConfig.getTopScaleDefStyle()
            ..labelAlign = Alignment.center,
          top: true),
      chartRenderList: [
        HorBarRender(
            style: HorBarStyle(
              heightRadius: 0.8,
              showLabel: true,
              labelTextStyle: TextStyle(color: Colors.blueAccent.shade200,fontSize: 12),
              startColor: Colors.white,
              endColor: Colors.red,
              labelPadding: EdgeInsets.zero,
              barLeftRadius: Radius.zero,
              barRightRadius: Radius.zero,
              labelLeft: true,
              strokeWidth: 5,
              barStyle: PaintingStyle.fill
            ),
            dataList: List.generate(
                6,
                (index) => HorBarData(
                  startColor: null,
                  endColor: null,
                  yValue: index*20,
                  xStartValue: 1,
                  xEndValue: (index+1)*2,
                  label: (index+1).toString(),
                  labelLeft: true,
                )))
      ],
    );
  }
}
