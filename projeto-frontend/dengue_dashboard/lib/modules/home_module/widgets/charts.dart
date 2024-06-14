import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 3,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('JAN/24', style: style),
        );
        break;
      case 1:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('FEV/24', style: style),
        );
        break;
      case 2:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('MAR/24', style: style),
        );
        break;
      case 3:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('ABR/24', style: style),
        );
        break;
      case 4:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('MAI/24', style: style),
        );
        break;
      case 5:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('JUN/24', style: style),
        );
        break;
      case 6:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('JUL/24', style: style),
        );
        break;
      case 7:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('AGO/24', style: style),
        );
        break;
      case 8:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('SEP/24', style: style),
        );
        break;
      case 9:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('OUT/24', style: style),
        );
        break;
      case 10:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('NOV/24', style: style),
        );
        break;
      case 11:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('DEZ/24', style: style),
        );
        break;
      case 12:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('JAN/24', style: style),
        );
        break;
      case 13:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('FEV/24', style: style),
        );
        break;
      case 14:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('MAR/24', style: style),
        );
        break;
      case 15:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('ABR/24', style: style),
        );
        break;
      case 16:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('MAI/24', style: style),
        );
        break;
      case 17:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('JUN/24', style: style),
        );
        break;
      case 18:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('JUL/24', style: style),
        );
        break;
      case 19:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('AGO/24', style: style),
        );
        break;
      case 20:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('SEP/24', style: style),
        );
        break;
      case 21:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('OUT/24', style: style),
        );
        break;
      case 22:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('NOV/24', style: style),
        );
        break;
      case 23:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('DEZ/24', style: style),
        );
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget bottomTitleWidgets2(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('JAN', style: style);
        break;
      case 1:
        text = const Text('FEV', style: style);
        break;
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 3:
        text = const Text('ABR', style: style);
        break;
      case 4:
        text = const Text('MAI', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 6:
        text = const Text('JUL', style: style);
        break;
      case 7:
        text = const Text('AGO', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      case 9:
        text = const Text('OUT', style: style);
        break;
      case 10:
        text = const Text('NOV', style: style);
        break;
      case 11:
        text = const Text('DEZ', style: style);
        break;
      case 12:
        text = const Text('JAN', style: style);
        break;
      case 13:
        text = const Text('FEV', style: style);
        break;
      case 14:
        text = const Text('MAR', style: style);
        break;
      case 15:
        text = const Text('ABR', style: style);
        break;
      case 16:
        text = const Text('MAI', style: style);
        break;
      case 17:
        text = const Text('JUN', style: style);
        break;
      case 18:
        text = const Text('JUL', style: style);
        break;
      case 19:
        text = const Text('AGO', style: style);
        break;
      case 20:
        text = const Text('SEP', style: style);
        break;
      case 21:
        text = const Text('OUT', style: style);
        break;
      case 22:
        text = const Text('NOV', style: style);
        break;
      case 23:
        text = const Text('DEZ', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  /*Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }*/

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.black,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.red,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        /*leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),*/
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 23,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(1, 9),
            FlSpot(2, 5),
            FlSpot(3, 3.1),
            FlSpot(4, 4),
            FlSpot(5, 8),
            FlSpot(6, 4),
            FlSpot(7, 3),
            FlSpot(8, 2),
            FlSpot(9, 8),
            FlSpot(10, 0.1),
            FlSpot(11, 4),
            FlSpot(12, 3),
            FlSpot(13, 9),
            FlSpot(14, 5),
            FlSpot(15, 3.1),
            FlSpot(16, 4),
            FlSpot(17, 8),
            FlSpot(18, 4),
            FlSpot(19, 3),
            FlSpot(20, 2),
            FlSpot(21, 8),
            FlSpot(22, 0.1),
            FlSpot(23, 4),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData minData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.black,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.red,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        /*leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),*/
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 23,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(1, 9),
            FlSpot(2, 5),
            FlSpot(3, 3.1),
            FlSpot(4, 4),
            FlSpot(5, 8),
            FlSpot(6, 4),
            FlSpot(7, 3),
            FlSpot(8, 2),
            FlSpot(9, 8),
            FlSpot(10, 0.1),
            FlSpot(11, 4),
            FlSpot(12, 3),
            FlSpot(13, 9),
            FlSpot(14, 5),
            FlSpot(15, 3.1),
            FlSpot(16, 4),
            FlSpot(17, 8),
            FlSpot(18, 4),
            FlSpot(19, 3),
            FlSpot(20, 2),
            FlSpot(21, 8),
            FlSpot(22, 0.1),
            FlSpot(23, 4),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
