import 'package:embesys_ctrl/constants.dart';
import 'package:embesys_ctrl/widgets/remote_control_widget.dart';
import 'package:flutter/material.dart';

class RemoteControlPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Remote Control',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        backgroundColor: boxGrad.colors[1],
        actions: [
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
      backgroundColor: scaffoldBgColor,
      body: true
          ? RemoteControlWidget()
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: boxGrad,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text('Channel Name'),
                      Text('HexValue'),
                      Text('Time Added'), // use timeago
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                            ),
                            onPressed: () {
                              // Edit page
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                            ),
                            onPressed: () {
                              // Delete page
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
