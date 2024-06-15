import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ChartScreen extends StatefulWidget {
  List<double> valueFore;
  double maxValue;
  ChartScreen({super.key, required this.valueFore, required this.maxValue});

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
          child: const Text('JAN/25', style: style),
        );
        break;
      case 13:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('FEV/25', style: style),
        );
        break;
      case 14:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('MAR/25', style: style),
        );
        break;
      case 15:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('ABR/25', style: style),
        );
        break;
      case 16:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('MAI/25', style: style),
        );
        break;
      case 17:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('JUN/25', style: style),
        );
        break;
      case 18:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('JUL/25', style: style),
        );
        break;
      case 19:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('AGO/25', style: style),
        );
        break;
      case 20:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('SEP/25', style: style),
        );
        break;
      case 21:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('OUT/25', style: style),
        );
        break;
      case 22:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('NOV/25', style: style),
        );
        break;
      case 23:
        text = text = Transform.rotate(
          angle: -math.pi / 4,
          child: const Text('DEZ/25', style: style),
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

  LineChartData mainData() {
    return LineChartData(
      backgroundColor: Colors.white,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.white,
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
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 23,
      minY: 0,
      maxY: widget.maxValue == 0
          ? 0
          : widget.maxValue > 10000
              ? widget.maxValue + 1000
              : widget.maxValue + 100,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, widget.valueFore[0]),
            FlSpot(1, widget.valueFore[1]),
            FlSpot(2, widget.valueFore[2]),
            FlSpot(3, widget.valueFore[3]),
            FlSpot(4, widget.valueFore[4]),
            FlSpot(5, widget.valueFore[5]),
            FlSpot(6, widget.valueFore[6]),
            FlSpot(7, widget.valueFore[7]),
            FlSpot(8, widget.valueFore[8]),
            FlSpot(9, widget.valueFore[9]),
            FlSpot(10, widget.valueFore[10]),
            FlSpot(11, widget.valueFore[11]),
            FlSpot(12, widget.valueFore[12]),
            FlSpot(13, widget.valueFore[13]),
            FlSpot(14, widget.valueFore[14]),
            FlSpot(15, widget.valueFore[15]),
            FlSpot(16, widget.valueFore[16]),
            FlSpot(17, widget.valueFore[17]),
            FlSpot(18, widget.valueFore[18]),
            FlSpot(19, widget.valueFore[19]),
            FlSpot(20, widget.valueFore[20]),
            FlSpot(21, widget.valueFore[21]),
            FlSpot(22, widget.valueFore[22]),
            FlSpot(23, widget.valueFore[20]),
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
