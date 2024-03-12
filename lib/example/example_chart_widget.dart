import 'package:flutter/material.dart';

abstract class BaseExampleChartWidget extends StatelessWidget {
  double width;
  double height;

  BaseExampleChartWidget(
      {super.key,
      required this.width,
      required this.height});

  Widget buildChart(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
      child: SizedBox(
        width: width,
        height: height,
        child: ColoredBox(
          color: Colors.grey.shade500,
          child: buildChart(context),
        ),
      ),
    ));
  }
}
