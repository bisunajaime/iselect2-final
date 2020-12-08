import 'package:embesys_ctrl/constants.dart';
import 'package:embesys_ctrl/pages/remote_control_page.dart';
import 'package:flutter/material.dart';

class RemoteControlList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Remote Control List',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        backgroundColor: boxGrad.colors[1],
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
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: boxGrad.colors[1],
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Mapped to controller')
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: Colors.black.withOpacity(.08),
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8,
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RemoteControlPage(),
                          ));
                    },
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
