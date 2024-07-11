import 'dart:math';

import 'package:echart_flutter/echart_flutter.dart';

List<List<LineChartSpot>> createSpotsList(
    {required int spotsNum, int? length, required List data}) {
  final spotsList = <List<LineChartSpot>>[];
  final random = Random();
  length = length ?? random.nextInt(20) + 10;
  for (var i = 0; i < spotsNum; i++) {
    var spots = <LineChartSpot>[];
    var current = 0;
    for (var j = 0; j < length; j++) {
      current = data[j];
      spots.add(LineChartSpot(j.toDouble(), current.toDouble()));
    }
    spotsList.add(spots);
  }

  return spotsList;
}
