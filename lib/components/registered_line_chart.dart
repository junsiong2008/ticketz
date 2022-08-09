import 'dart:collection';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ticketz/models/participant.dart';

class RegisteredLineChart extends StatelessWidget {
  final List<Participant> participants;
  const RegisteredLineChart({
    Key? key,
    required this.participants,
  }) : super(key: key);

  DateTime toYearMonthDay(DateTime datetime) {
    return DateTime(
      datetime.year,
      datetime.month,
      datetime.day,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColors = [
      const Color(0xff23b6e6),
      const Color(0xff02d39a),
    ];

    /*
    *  Group the registration record by date, then count the number of records
    *  in each date
    */
    SplayTreeMap<double, int> dateCountMap = SplayTreeMap<double, int>();

    for (var element in participants) {
      var key = toYearMonthDay(element.datetimeCreated)
          .millisecondsSinceEpoch
          .toDouble();

      if (!dateCountMap.containsKey(key)) {
        dateCountMap[key] = 1;
      } else {
        dateCountMap[key] = dateCountMap[key]! + 1;
      }
    }

    /*
    *  Loop and count cumulative report for each date
    */
    SplayTreeMap<double, int> cumulativeDateCountMap =
        SplayTreeMap<double, int>();
    var dateCountMapEntries = dateCountMap.entries;
    int sum = 0;
    for (var i in dateCountMapEntries) {
      for (var j in dateCountMapEntries) {
        if (j.key <= i.key) {
          sum += j.value;
          cumulativeDateCountMap[i.key] = sum;
        }
      }
      sum = 0;
    }

    debugPrint('Each: ${dateCountMap.toString()}');
    debugPrint('Cumulative: ${cumulativeDateCountMap.toString()}');

    List<FlSpot> flSpots = cumulativeDateCountMap.entries
        .map((mapEntry) =>
            FlSpot(mapEntry.key.toDouble(), mapEntry.value.toDouble()))
        .toList();

    for (FlSpot spot in flSpots) {
      debugPrint('x: ${spot.x.toString()} y: ${spot.y.toString()}');
    }
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          handleBuiltInTouches: false,
        ),
        gridData: FlGridData(
          show: false,
        ),
        titlesData: FlTitlesData(
          show: false,
        ),
        borderData: FlBorderData(
          show: false,
        ),
        /*
        * minX: Time since data first exists
        * maxY: Time since last data
        */
        minX: flSpots.isNotEmpty ? flSpots[0].x : 0,
        maxX: flSpots.isNotEmpty ? flSpots[flSpots.length - 1].x : null,
        minY: 0,
        maxY: flSpots.isEmpty ? null : 600,
        lineBarsData: [
          LineChartBarData(
            spots: flSpots,
            isCurved: false,
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: gradientColors
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
