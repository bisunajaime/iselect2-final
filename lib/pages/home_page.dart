import 'package:embesys_ctrl/constants.dart';
import 'package:embesys_ctrl/providers/weather_provider.dart';
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
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          'Add a category',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10,
            letterSpacing: 1.0,
          ),
        ),
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {},
        backgroundColor: boxGrad.colors[1],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await weatherProvider.loadWeather();
        },
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
                'Shared Devices',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            SoundWidget(),
            SizedBox(
              height: 24,
            ),
            PageListWidget(),
            RoomsPagesWidget(),
          ],
        ),
      ),
    );
  }
}
