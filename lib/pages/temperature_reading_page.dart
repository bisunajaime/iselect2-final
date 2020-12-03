import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/services.dart';

class TemperatureReadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Reading'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: SimpleTimeSeriesChart(SimpleTimeSeriesChart._createSampleData()),
      ),
    );
  }
}

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleTimeSeriesChart(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory SimpleTimeSeriesChart.withSampleData() {
    return new SimpleTimeSeriesChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      behaviors: [
        new charts.PanAndZoomBehavior(),
      ],
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final data = [
      new TimeSeriesSales(new DateTime(2017, 1, 19), 5),
      new TimeSeriesSales(new DateTime(2017, 2, 26), 25),
      new TimeSeriesSales(new DateTime(2017, 3, 3), 100),
      new TimeSeriesSales(new DateTime(2017, 4, 10), 75),
      new TimeSeriesSales(new DateTime(2017, 5, 10), Random().nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 6, 10), Random().nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 7, 10), Random().nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 8, 10), Random().nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 9, 10), Random().nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 10, 10), Random().nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 11, 10), Random().nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 12, 10), Random().nextInt(100)),
      new TimeSeriesSales(new DateTime(2018, 1, 10), Random().nextInt(100)),
      new TimeSeriesSales(new DateTime(2018, 2, 10), Random().nextInt(100)),
      new TimeSeriesSales(new DateTime(2018, 3, 10), Random().nextInt(100)),
      new TimeSeriesSales(new DateTime(2018, 4, 10), Random().nextInt(100)),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
