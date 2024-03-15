import 'package:flutter/material.dart';
import 'package:jchart/def/line/line_chart_data.dart';
import 'package:jchart/def/line/line_chart_render.dart';
import 'package:jchart/def/line/line_chart_style.dart';
import 'package:jchart/j_chart.dart';
import 'package:jchart/enum/line_type_enum.dart';

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
        LineChartRender(
            style: LineChartStyle(
                lineType: LineTypeEnum.dashed,
                lineSize: 1,
                width: 8,
                dashWidth: 3,
                dashColor: Colors.transparent,
                lineColor: Colors.yellow,
                showCircle: true,
                circleRadius: 5,
                circleStrokeRadius: 8,
                circleStyle: PaintingStyle.stroke,
                circleColor: Colors.red,
                circleStrokeColor: Colors.blue,
                circleSelColor: Colors.purpleAccent,
                circleStrokeSelColor: Colors.purple),
            dataList: List.generate(
                4,
                (index) => LineChartData(
                    xValue: (index + 1) * 2.toDouble(),
                    yValue: 5 * (index + 1),
                    supportSel: true)))
      ],
    );
  }
}
