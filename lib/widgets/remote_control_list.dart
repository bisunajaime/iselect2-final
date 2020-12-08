import 'package:embesys_ctrl/constants.dart';
import 'package:flutter/material.dart';

class RemoteControlList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Remote Control List'),
      ),
      backgroundColor: scaffoldBgColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: boxGrad.colors[1],
                      radius: 25,
                    ),
                    Text('Mapped to controller')
                  ],
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                    ),
                    Text('Not yet mapped')
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                  color: true
                      ? Colors.white
                      : boxGrad.colors[
                          1], // if button is mapped or label is not null, make it blue. NOTE: Add a key to identify the button
                  child: ListTile(
                    title: Text('Hex value'), // hex value if not yet assigned
                    subtitle: Text('Added at...'), // show timestamp
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
