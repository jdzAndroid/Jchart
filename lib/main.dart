import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jchart/example/example_bar_chart.dart';
import 'package:jchart/example/example_line_chart.dart';

void main() {
  runApp(MyApp());
}

typedef getWidget = Widget Function(BuildContext? context);

class PopMenuType {
  String title;
  getWidget gW;
  getWidget getContent;

  PopMenuType(
      {required this.title, required this.gW, required this.getContent});
}

class MyApp extends StatelessWidget {
  final List<PopMenuType> menuList = List.empty(growable: true);
  Rx<int> selIndex = 0.obs;

  MyApp({super.key}) {
    menuList.add(PopMenuType(
        title: "柱状图",
        gW: (ctx) => const Text("柱状图"),
        getContent: (ctx) {
          return const ExampleBarChart();
        }));
    menuList.add(PopMenuType(
        title: "折线图",
        gW: (ctx) => const Text("折线图"),
        getContent: (ctx) {
          return const ExampleLineChart();
        }));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              width: 50,
              height: 80,
            ),
            PopupMenuButton(
              position: PopupMenuPosition.over,
              itemBuilder: (BuildContext context) {
                List<PopupMenuItem> list = [];
                for (int index=0;index<menuList.length;index++) {
                  PopMenuType element=menuList[index];
                  list.add(PopupMenuItem(
                    child: element.gW(context),
                    onTap: () {
                      selIndex.value=index;
                    },
                  ));
                }
                return list;
              },
              onSelected: (index) {
                selIndex.value = index;
              },
              initialValue: "柱状图",
              elevation: 10,
              shadowColor: Colors.grey,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(menuList[selIndex.value].title),
                  Icon(Icons.person)
                ],
              ),
            ),
            Obx(() => menuList[selIndex.value].getContent(context))
          ],
        ),
      ),
    );
  }
}
