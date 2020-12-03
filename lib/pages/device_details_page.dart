import 'package:embesys_ctrl/constants.dart';
import 'package:embesys_ctrl/models/device_model.dart';
import 'package:flutter/material.dart';

class DeviceDetailsPage extends StatelessWidget {
  final DeviceModel model;

  const DeviceDetailsPage({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextStyle label = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );
    TextStyle details = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
    );
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.05),
                  offset: Offset(0, 1),
                  blurRadius: 10,
                ),
              ],
              color: Colors.white,
            ),
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 32,
              bottom: 16,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: boxGrad.colors[1],
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Details of the device scanned',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Device details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(
                top: 24,
                left: 24,
                right: 24,
              ),
              children: [
                Text(
                  'ID',
                  style: label,
                ),
                Text(
                  model.uniqueId,
                  style: details,
                ),
                SizedBox(height: 8),
                Text(
                  'Type',
                  style: label,
                ),
                Text(
                  model.type,
                  style: details,
                ),
                SizedBox(height: 8),
                Text(
                  'Device tag',
                  style: label,
                ),
                Text(
                  model.deviceTag,
                  style: details,
                ),
                SizedBox(height: 8),
                Text(
                  'Device Name',
                  style: label,
                ),
                Text(
                  model.deviceName,
                  style: details,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
