import 'package:flutter/material.dart';

import 'j_chart.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
          child: SizedBox(
            width: 400,
            height: 300,
            child: ColoredBox(
              color: Colors.grey.shade500,
              child: BaseChartWidget(
                xMin: 1,
                xMax: 12,
                yMin: 1,
                yMax: 100,
                width: 400,
                height: 300,
                xGridRender: BaseChartXGridRender(
                    dataList: List.generate(
                        5,
                            (index) => BaseChartXGridData(
                            value: 20.0 * (index+1),
                            color: Colors.primaries[index])),
                    style: ChartGlobalConfig.getXGridDefStyle()
                      ..color = Colors.red),
                yGridRender: BaseChartYGridRender(
                    dataList: List.generate(
                        12, (index) => BaseChartYGridData(value: (index+1).toDouble(),
                        color: Colors.primaries[index])),
                    style: ChartGlobalConfig.getYGridDefStyle()
                      ..color = Colors.red),
                leftScaleRender: BaseChartYScaleRender(
                    dataList: List.generate(
                        5,
                            (index) => BaseYScaleData(
                            value: 20.0 * (index+1),
                            label: (20 * (index+1)).toString(),
                            labelPadding: index==4?null:const EdgeInsets.only(left: 4))),
                    style: ChartGlobalConfig.getLeftScaleDefStyle()
                      ..color = Colors.green
                      ..labelAlign = Alignment.center
                      ..showLabel = true
                      ..labelPadding=const EdgeInsets.only(right: 4),
                    left: true),
                rightScaleRender: BaseChartYScaleRender(
                    dataList: List.generate(
                        5,
                            (index) => BaseYScaleData(
                            value: 20.0 * (index+1),
                            label: (20 * (index+1)).toString())),
                    style: ChartGlobalConfig.getRightScaleDefStyle()
                      ..color = Colors.green
                      ..labelAlign = Alignment.center
                      ..showLabel = true
                      ..labelPadding=EdgeInsets.only(left: 2),
                    left: false),
                bottomScaleRender: BaseChartXScaleRender(
                    dataList: List.generate(
                        12,
                            (index) => BaseXScaleData(
                            value: (index+1),
                            label: ((index+1)).toString())),
                    style: ChartGlobalConfig.getBottomScaleDefStyle()
                      ..labelAlign = Alignment.center,
                    top: false),
                topScaleRender: BaseChartXScaleRender(
                    dataList: List.generate(
                        12,
                            (index) => BaseXScaleData(
                            value: (index+1.0),
                            label: ((index+1)).toString())),
                    style: ChartGlobalConfig.getTopScaleDefStyle()
                      ..labelAlign = Alignment.center,
                    top: true),
                chartRenderList: [
                  BarChartRender(
                      style: BarChartStyle(
                          startColor: Colors.yellow,
                          endColor: Colors.red,
                          topRadius: const Radius.circular(16),
                          bottomRadius: const Radius.circular(16),
                          radius: 0.8),
                      dataList: List.generate(
                          12,
                              (index) => BarChartData(
                              xValue: (index+1).toDouble(),
                              startValue: 1,
                              endValue: (index+1) * 8,
                              topRadius: const Radius.circular(16),
                              bottomRadius: const Radius.circular(16),
                              radius: 0.7)))
                ],
              ),
              ),
          ),
        ));
  }
}
