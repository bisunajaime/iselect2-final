import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:embesys_ctrl/providers/temperature_reading_provider.dart';
import 'package:flutter/material.dart';

/// Timeseries chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TemperatureReadingWidget extends StatefulWidget {
  @override
  _TemperatureReadingWidgetState createState() =>
      _TemperatureReadingWidgetState();
}

class _TemperatureReadingWidgetState extends State<TemperatureReadingWidget> {
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      print('Requesting');
      Provider.of<TemperatureReadingProvider>(context, listen: false)
          .loadDhtReadings();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: Consumer<TemperatureReadingProvider>(
        builder: (context, value, child) {
          if (value.busy)
            return Center(
              child: CircularProgressIndicator(),
            );
          List<TimeSeriesSales> temp = value.readings
              .map((e) => TimeSeriesSales(
                  DateTime.parse(e.createdAt), e.temperature.toDouble()))
              .toList();
          List<TimeSeriesSales> humid = value.readings.map((e) {
            return TimeSeriesSales(
                DateTime.parse(e.createdAt), e.humidity.toDouble());
          }).toList();
          return SimpleTimeSeriesChart(
              SimpleTimeSeriesChart.loadData(temp, humid));
        },
      ),
    );
  }
}

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleTimeSeriesChart(this.seriesList, {this.animate});

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

  static List<charts.Series<TimeSeriesSales, DateTime>> loadData(
    List<TimeSeriesSales> temp,
    List<TimeSeriesSales> humid,
  ) {
    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Temp Readings',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: temp,
        displayName: 'Temperature',
      ),
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Humid Readings',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: humid,
        displayName: 'Humidity',
      )
    ];
  }

  // static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
  //   final data = [
  //     new TimeSeriesSales(new DateTime(2017, 1, 19), 5),
  //     new TimeSeriesSales(new DateTime(2017, 2, 26), 25),
  //     new TimeSeriesSales(new DateTime(2017, 3, 3), 100),
  //     new TimeSeriesSales(new DateTime(2017, 4, 10), 75),
  //     new TimeSeriesSales(new DateTime(2017, 5, 10), Random().nextInt(100)),
  //     new TimeSeriesSales(new DateTime(2017, 6, 10), Random().nextInt(100)),
  //     new TimeSeriesSales(new DateTime(2017, 7, 10), Random().nextInt(100)),
  //     new TimeSeriesSales(new DateTime(2017, 8, 10), Random().nextInt(100)),
  //     new TimeSeriesSales(new DateTime(2017, 9, 10), Random().nextInt(100)),
  //     new TimeSeriesSales(new DateTime(2017, 10, 10), Random().nextInt(100)),
  //     new TimeSeriesSales(new DateTime(2017, 11, 10), Random().nextInt(100)),
  //     new TimeSeriesSales(new DateTime(2017, 12, 10), Random().nextInt(100)),
  //     new TimeSeriesSales(new DateTime(2018, 1, 10), Random().nextInt(100)),
  //     new TimeSeriesSales(new DateTime(2018, 2, 10), Random().nextInt(100)),
  //     new TimeSeriesSales(new DateTime(2018, 3, 10), Random().nextInt(100)),
  //     new TimeSeriesSales(new DateTime(2018, 4, 10), Random().nextInt(100)),
  //   ];

  //   return [
  //     new charts.Series<TimeSeriesSales, DateTime>(
  //       id: 'Sales',
  //       colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
  //       domainFn: (TimeSeriesSales sales, _) => sales.time,
  //       measureFn: (TimeSeriesSales sales, _) => sales.sales,
  //       data: data,
  //     )
  //   ];
  // }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final double sales;

  TimeSeriesSales(this.time, this.sales);
}
