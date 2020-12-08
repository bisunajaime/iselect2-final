import 'package:embesys_ctrl/constants.dart';
import 'package:embesys_ctrl/pages/other_devices_page.dart';
import 'package:embesys_ctrl/pages/remote_control_page.dart';
import 'package:embesys_ctrl/pages/temperature_reading_page.dart';
import 'package:embesys_ctrl/providers/weather_provider.dart';
import 'package:embesys_ctrl/widgets/device_notifications_widget.dart';
import 'package:embesys_ctrl/widgets/other_devices_buttons_widget.dart';
import 'package:embesys_ctrl/widgets/page_list_widget.dart';
import 'package:embesys_ctrl/widgets/remote_control_list.dart';
import 'package:embesys_ctrl/widgets/rooms_pages_widget.dart';
import 'package:embesys_ctrl/widgets/sound_widget.dart';
import 'package:embesys_ctrl/widgets/temperature_reading_widget.dart';
import 'package:embesys_ctrl/widgets/weather_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      // floatingActionButton: FloatingActionButton.extended(
      //   label: Text(
      //     'Add a category',
      //     style: TextStyle(
      //       fontWeight: FontWeight.bold,
      //       fontSize: 10,
      //       letterSpacing: 1.0,
      //     ),
      //   ),
      //   icon: Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      //   onPressed: () {},
      //   backgroundColor: boxGrad.colors[1],
      // ),
      body: RefreshIndicator(
        onRefresh: () async {
          await weatherProvider.loadWeather();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WeatherWidget(),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                child: Text(
                  'Music Player',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SoundWidget(),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                child: Text(
                  'Device Notifications',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              DeviceNotificationsWidget(),
              // PageListWidget(),
              // RoomsPagesWidget(),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                child: Text(
                  'Temperature Reading',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              TemperatureReadingWidget(),
              SizedBox(
                height: 24,
              ),
              OtherDevicesButtonsWidget(),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    child: FlatButton(
                      child: Text('Remote Page'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RemoteControlPage(),
                            ));
                      },
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      child: Text('Remote List'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RemoteControlList(),
                            ));
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
