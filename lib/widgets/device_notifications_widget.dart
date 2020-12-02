import 'package:embesys_ctrl/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DeviceNotificationsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      padding: EdgeInsets.symmetric(
          // vertical: 18,
          ),
      child: ListView.builder(
        itemCount: 4,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            height: double.infinity,
            width: 200,
            decoration: BoxDecoration(
              gradient: boxGrad,
              borderRadius: BorderRadius.circular(25),
            ),
            margin: EdgeInsets.only(
              left: 16,
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.ac_unit,
                      color: Colors.white,
                      size: 50,
                    ),
                    Text(
                      TimeOfDay.now().format(context),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Expanded(child: SizedBox()),
                Text(
                  DateFormat.yMd().format(DateTime.now()),
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'Doorbell',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Someone rang the doorbell.',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white.withOpacity(.7),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
