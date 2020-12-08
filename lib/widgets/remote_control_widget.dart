import 'package:embesys_ctrl/constants.dart';
import 'package:flutter/material.dart';

class RemoteControlWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.grey[400],
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Text('Buttons guide'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Double tap a button to assign a value.'),
                            Text('Tap and hold a button to delete a value.'),
                          ],
                        ),
                        actions: [
                          FlatButton(
                            child: Text('Dismiss'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ));
                },
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Center(
            child: Text('GO BACK'),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.volume_up,
                color: Colors.grey[400],
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[400],
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black.withOpacity(.05),
                      offset: Offset(0, 1),
                    )
                  ],
                ),
                child: Icon(
                  Icons.power_settings_new,
                  color: Colors.black,
                ),
              ),
              Icon(
                Icons.tv,
                color: Colors.grey[400],
              ),
            ],
          ),
          // vol and channel
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 250,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    Text('Vol'), // bold
                    Icon(Icons.remove)
                  ],
                ),
              ),
              Container(
                height: 250,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.keyboard_arrow_up),
                    Text('Ch'), // bold
                    Icon(Icons.keyboard_arrow_down)
                  ],
                ),
              ),
            ],
          ),
          // add remotes, a/c control, servo motor for analog control pages
          // Expanded(
          //    child: PageView(
          //      children: [
          //        // remote,
          //      ],
          //    ),
          // ),
        ],
      ),
    );
  }
}
