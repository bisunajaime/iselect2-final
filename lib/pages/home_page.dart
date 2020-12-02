import 'package:embesys_ctrl/constants.dart';
import 'package:embesys_ctrl/pages/other_devices_page.dart';
import 'package:embesys_ctrl/providers/weather_provider.dart';
import 'package:embesys_ctrl/widgets/device_notifications_widget.dart';
import 'package:embesys_ctrl/widgets/page_list_widget.dart';
import 'package:embesys_ctrl/widgets/rooms_pages_widget.dart';
import 'package:embesys_ctrl/widgets/sound_widget.dart';
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
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 50,
                        child: FlatButton(
                          color: boxGrad.colors[1],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OtherDevicesPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Other Devices',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.zero,
                        color: Colors.white,
                        child: Icon(
                          Icons.code,
                          color: Colors.black,
                        ),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
