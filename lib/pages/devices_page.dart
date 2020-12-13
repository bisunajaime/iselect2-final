import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:embesys_finals/models/dht_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:web_socket_channel/io.dart';

class DevicesPage extends StatefulWidget {
  final String socketUrl;

  const DevicesPage({Key key, this.socketUrl}) : super(key: key);
  @override
  _DevicesPageState createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  IOWebSocketChannel channel;
  StreamController<Map> _socketController = StreamController.broadcast();
  StreamController<List<DhtModel>> _dhtListStream =
      StreamController.broadcast();
  StreamController<bool> _ledStatusStream = StreamController.broadcast();
  StreamController<String> _doorbellStream = StreamController.broadcast();
  StreamController<String> _irStream = StreamController.broadcast();
  List<DhtModel> _dhtReadings = [];

  @override
  void initState() {
    super.initState();
    print(widget.socketUrl);
    initSocket();
  }

  @override
  void dispose() {
    super.dispose();
    channel.sink.close();
    _dhtListStream.close();
    _ledStatusStream.close();
  }

  void initSocket() {
    channel = IOWebSocketChannel.connect("ws://${widget.socketUrl}:81");
    channel.stream.listen(
      (event) {
        // TODO: Switch case based on event type
        log(event);
        String type = event.toString().split(':')[0].toUpperCase();
        // * type format TYPE:RESULT
        log(type);
        switch (type) {
          case 'DHT':
            // add to list, max of 15
            String removeDht = event.toString().split(':')[1];
            List tempAndHumid = removeDht.split(',');
            double temp = double.parse(tempAndHumid[0]);
            double humid = double.parse(tempAndHumid[1]);
            try {
              print(_dhtReadings.length);
              if (_dhtReadings.length > 14) {
                _dhtReadings.removeAt(0);
              }
              _dhtReadings.add(DhtModel(
                date: DateTime.now(),
                humidity: humid,
                temperature: temp,
              ));
              setState(() {});
            } catch (e) {
              return;
            }
            break;
          case 'BUZZER':
            // Doorbell push notif
            _doorbellStream.add('Ring');
            break;
          case 'IR_RECEIVE':
            // insert to db or array IR Model, should be unique and editable
            break;
          case 'LED_ON':
            // update led state
            _ledStatusStream.add(true);
            break;
          case 'LED_OFF':
            _ledStatusStream.add(false);
            break;
          case 'LED_STATUS':
            double status = double.parse(event.toString().split(':')[1]);
            print(status);
            if (status != 0) {
              _ledStatusStream.add(false);
            } else {
              _ledStatusStream.add(true);
            }
            break;
          case 'DOORBELL':
            String type = event.toString().split(':')[1];
            if (type == "PUSHED") {
              _doorbellStream.add("Someone is ringing the doorbell!");
            } else {
              _doorbellStream.add("");
            }
            break;
          case 'LDR_VAL':
            String response = event.toString().split(':')[1];
            print('$event : $response');
            break;
          case 'IR_VAL':
            String response = event.toString().split(':')[1];
            print("$event : $response");
            break;
          default:
            print('$event : DEFAULT');
            break;
        }
      },
      onError: (error) {
        log('There was a problem $error');
      },
      cancelOnError: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Devices Page'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Music Player'),
                  // ! Music player widget
                  Row(
                    children: [
                      Expanded(
                        child: FlatButton(
                          child: Text('Play'),
                          onPressed: () {
                            channel.sink.add('PLAY_MUSIC');
                          },
                        ),
                      ),
                      Expanded(
                        child: FlatButton(
                          child: Text('STOP'),
                          onPressed: () {
                            channel.sink.add('STOP_MUSIC');
                          },
                        ),
                      )
                    ],
                  ),
                  // ! Temperature chart widget
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    // Chart title
                    title: ChartTitle(
                      text: 'Temperature Readings',
                      alignment: ChartAlignment.near,
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    legend: Legend(
                        isVisible: true, position: LegendPosition.bottom),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries<DhtModel, String>>[
                      LineSeries<DhtModel, String>(
                        dataSource: _dhtReadings,
                        animationDuration: 0,
                        xValueMapper: (DhtModel sales, _) =>
                            DateFormat().add_jms().format(sales.date),
                        yValueMapper: (DhtModel sales, _) => sales.temperature,
                        dataLabelSettings: DataLabelSettings(
                          isVisible: false,
                        ),
                        legendItemText: 'Temperature',
                      ),
                      LineSeries<DhtModel, String>(
                        dataSource: _dhtReadings,
                        animationDuration: 0,
                        xValueMapper: (DhtModel sales, _) =>
                            DateFormat().add_jms().format(sales.date),
                        yValueMapper: (DhtModel sales, _) => sales.humidity,
                        dataLabelSettings: DataLabelSettings(
                          isVisible: false,
                        ),
                        legendItemText: 'Humidity',
                      ),
                    ],
                  ),
                  Text('Notifications'),
                  // * Remote Control List Button (Navigate to page) {Might make a db for this}
                  StreamBuilder<bool>(
                    stream: _ledStatusStream.stream,
                    // initialData: false,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text('Loading');
                      }
                      // return Slider(
                      //   value: 0,
                      //   onChanged: (value) {
                      //     channel.sink.add(jsonEncode({
                      //       'LED1': 255,
                      //       'LED2': 255,
                      //       'LED_STATE': value.toInt(),
                      //     }));
                      //   },
                      //   max: 255,
                      //   min: 0,
                      // );
                      return SwitchListTile(
                        value: snapshot.data,
                        onChanged: (value) {
                          print(value);
                          _ledStatusStream.add(value);
                          channel.sink.add(jsonEncode({
                            'LED1': 255,
                            'LED2': 255,
                            'LED_STATE': value ? 0 : 255
                          }));
                        },
                        title: Text('LED State'),
                        subtitle:
                            Text('Tap to turn ${snapshot.data ? 'off' : 'on'}'),
                      );
                    },
                  ),
                  // ! Lights Widget
                ],
              ),
            ),
          ),
          StreamBuilder<String>(
            stream: _doorbellStream.stream,
            builder: (context, snapshot) {
              if (snapshot.data == null || snapshot.data.trim().isEmpty) {
                return Container();
              }

              return Container(
                width: double.infinity,
                color: Colors.grey[850],
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Text(
                  snapshot.data,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
