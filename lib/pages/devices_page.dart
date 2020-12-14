import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:embesys_finals/models/categories_model.dart';
import 'package:embesys_finals/models/dht_model.dart';
import 'package:embesys_finals/models/ir_model.dart';
import 'package:embesys_finals/models/notification_model.dart';
import 'package:embesys_finals/pages/remote_buttons_page.dart';
import 'package:embesys_finals/provider/ir_list_provider.dart';
import 'package:embesys_finals/provider/notification_provider.dart';
import 'package:embesys_finals/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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
    _led2StatusStream.close();
    _doorbellStream.close();
  }

  void initSocket() {
    channel = IOWebSocketChannel.connect("ws://${widget.socketUrl}:81");
    channel.stream.listen(
      (event) {
        log(event);
        String type = event.toString().split(':')[0].toUpperCase();
        // * type format TYPE:RESULT
        log(type);
        // ! Notifications
        // Provider.of<NotificationProvider>(context, listen: false)
        //     .addNotif(new NotificationModel(
        //       type: type,
        //       action: "",
        //       timeStamp: DateTime.now(),
        //     ));
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
          case 'IR_VAL':
            // * Recv ir
            String response = event.toString().split(':')[1];
            print("IRVAL: $response");
            Provider.of<IRListProvider>(context, listen: false)
                .addIRData(new IRModel(
              label: null,
              value: response,
              category: null,
              dateAdded: DateTime.now(),
            ));
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        'LED Controls',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    StreamBuilder<bool>(
                      stream: _led1StatusStream.stream,
                      // initialData: false,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Card(
                            margin: EdgeInsets.only(
                                left: 16, right: 16, bottom: 8, top: 8),
                            color: UiColors.secondaryColor,
                            child: ListTile(
                              title: Text('Loading'),
                              leading: CircularProgressIndicator(),
                            ),
                          );
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
                          return Card(
                            margin:
                                EdgeInsets.only(left: 16, right: 16, bottom: 8),
                            color: UiColors.secondaryColor,
                            child: ListTile(
                              title: Text('Loading'),
                              leading: CircularProgressIndicator(),
                            ),
                          );
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
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Remote Categories',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Consumer<IRListProvider>(
                            builder: (context, value, child) {
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      TextEditingController _categoryName =
                                          TextEditingController();
                                      final _key = GlobalKey<FormState>();
                                      return AlertDialog(
                                        title: Text('Create new category.'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Form(
                                              key: _key,
                                              child: TextFormField(
                                                controller: _categoryName,
                                                validator: (value) {
                                                  if (value
                                                          .replaceAll(' ', '')
                                                          .trim()
                                                          .length ==
                                                      0) {
                                                    return "Required field";
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide:
                                                          BorderSide.none,
                                                    ),
                                                    hintText: 'Type here...'),
                                              ),
                                            )
                                          ],
                                        ),
                                        actions: [
                                          FlatButton(
                                            child: Text('Dismiss'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          FlatButton(
                                            child: Text('Submit'),
                                            onPressed: () {
                                              value.addCategory(
                                                  new CategoriesModel(
                                                buttonCount: 0,
                                                name: _categoryName.text,
                                              ));
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  'Add category',
                                  style: TextStyle(
                                    color: UiColors.lightTextColor,
                                    fontSize: 12,
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Consumer<IRListProvider>(
                      builder: (context, value, child) {
                        return Container(
                          width: double.infinity,
                          height: 80,
                          child: value.categories.length == 0
                              ? GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        TextEditingController _categoryName =
                                            TextEditingController();
                                        final _key = GlobalKey<FormState>();
                                        return AlertDialog(
                                          title: Text('Create new category.'),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Form(
                                                key: _key,
                                                child: TextFormField(
                                                  controller: _categoryName,
                                                  validator: (value) {
                                                    if (value
                                                            .replaceAll(' ', '')
                                                            .trim()
                                                            .length ==
                                                        0) {
                                                      return "Required field";
                                                    }
                                                    return null;
                                                  },
                                                  decoration: InputDecoration(
                                                      filled: true,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        borderSide:
                                                            BorderSide.none,
                                                      ),
                                                      hintText: 'Type here...'),
                                                ),
                                              )
                                            ],
                                          ),
                                          actions: [
                                            FlatButton(
                                              child: Text('Dismiss'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            FlatButton(
                                              child: Text('Submit'),
                                              onPressed: () {
                                                value.addCategory(
                                                    new CategoriesModel(
                                                  buttonCount: 0,
                                                  name: _categoryName.text,
                                                ));
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: UiColors.secondaryColor,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 10,
                                          color: Colors.black.withOpacity(.15),
                                          offset: Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        'No categories yet. Tap here to add.',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: value.categories.length,
                                  itemBuilder: (context, index) {
                                    CategoriesModel model =
                                        value.categories[index];
                                    return Container(
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: UiColors.secondaryColor,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      margin: EdgeInsets.only(
                                          left: 8, right: 8, top: 8, bottom: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            model.name ?? "None",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'Count: ${model.buttonCount}',
                                            style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: FlatButton.icon(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          icon: Icon(
                            Icons.settings_remote,
                            color: Colors.black,
                          ),
                          label: Text(
                            'View Remote',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          color: UiColors.lightTextColor,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RemoteButtonsPage(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
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
            ),
          ],
        ),
      ),
    );
  }
}
