import 'package:flutter/material.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SpendSavePage extends StatefulWidget {
  const SpendSavePage({Key? key}) : super(key: key);

  @override
  _SpendSavePageState createState() => _SpendSavePageState();
}

class _SpendSavePageState extends State<SpendSavePage> {
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('David', 25, Color.fromRGBO(9, 0, 136, 1)),
      ChartData('Steve', 38, Color.fromRGBO(147, 0, 119, 1)),
      ChartData('Jack', 34, Color.fromRGBO(228, 0, 124, 1)),
      ChartData('Others', 52, Color.fromRGBO(255, 189, 57, 1))
    ];
    return Scaffold(
      appBar: AppBar(title: Text("Chart"),backgroundColor: primaryColor,),
      body: Center(
        child: Column(
          children: [
            Container(
              child: SfCircularChart(
                title: ChartTitle(text: "Spending and Saving"),
                legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap, position: LegendPosition.left),
                series: <CircularSeries>[
                  // Renders doughnut chart
                  DoughnutSeries<ChartData, String>(
                      dataSource: chartData,
                      pointColorMapper: (ChartData data, _) => data.color,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      explode: true,
                      // Explode all the segments
                      explodeAll: true,
                      )
                ],
              ),
            ),
            Container(
              child: SfCircularChart(
                title: ChartTitle(text: "Spending and Saving"),
                legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap, position: LegendPosition.left),
                series: <CircularSeries>[
                  // Renders doughnut chart
                  DoughnutSeries<ChartData, String>(
                      dataSource: chartData,
                      pointColorMapper: (ChartData data, _) => data.color,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      explode: true,
                      // Explode all the segments
                      explodeAll: true,
                      )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
