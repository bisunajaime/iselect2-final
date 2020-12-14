import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:embesys_finals/models/dht_model.dart';
import 'package:embesys_finals/ui/colors.dart';
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
  StreamController<bool> _led1StatusStream = StreamController.broadcast();
  StreamController<bool> _led2StatusStream = StreamController.broadcast();
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
    _led1StatusStream.close();
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
          case 'LED1_STATUS':
            double status = double.parse(event.toString().split(':')[1]);
            print(status);
            if (status != 0) {
              _led1StatusStream.add(false);
            } else {
              _led1StatusStream.add(true);
            }
            break;
          case 'LED2_STATUS':
            double status = double.parse(event.toString().split(':')[1]);
            print(status);
            if (status != 0) {
              _led2StatusStream.add(false);
            } else {
              _led2StatusStream.add(true);
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
      backgroundColor: UiColors.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Devices.',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Try out some of the controls.',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white60,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: UiColors.secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: Colors.black.withOpacity(.05),
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: UiColors.lightTextColor,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Music Name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Author',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white60,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.fast_rewind,
                                size: 18,
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.play_circle_filled,
                                color: UiColors.lightTextColor,
                                size: 30,
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.fast_forward,
                                size: 18,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    // ! Temperature chart widget
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        // Chart title
                        title: ChartTitle(
                          text: 'DHT11 Readings',
                          alignment: ChartAlignment.near,
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
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
                            yValueMapper: (DhtModel sales, _) =>
                                sales.temperature,
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
                    ),
                    Text('Notifications'),
                    // * Remote Control List Button (Navigate to page) {Might make a db for this}
                    StreamBuilder<bool>(
                      stream: _led1StatusStream.stream,
                      // initialData: false,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text('Loading');
                        }
                        return SwitchListTile(
                          value: snapshot.data,
                          onChanged: (value) {
                            print(value);
                            _led1StatusStream.add(value);
                            channel.sink.add(jsonEncode({
                              'TYPE': "LED1",
                              'LED1_STATE': value ? 0 : 255
                            }));
                          },
                          title: Text('LED1 State'),
                          subtitle: Text(
                              'Tap to turn ${snapshot.data ? 'off' : 'on'}'),
                        );
                      },
                    ),
                    StreamBuilder<bool>(
                      stream: _led2StatusStream.stream,
                      // initialData: false,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text('Loading');
                        }
                        return SwitchListTile(
                          value: snapshot.data,
                          onChanged: (value) {
                            print(value);
                            _led2StatusStream.add(value);
                            channel.sink.add(jsonEncode({
                              'TYPE': "LED2",
                              'LED2_STATE': value ? 0 : 255
                            }));
                          },
                          title: Text('LED2 State'),
                          subtitle: Text(
                              'Tap to turn ${snapshot.data ? 'off' : 'on'}'),
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
      ),
    );
  }
}
