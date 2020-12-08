import 'package:embesys_ctrl/constants.dart';
import 'package:flutter/material.dart';

class RemoteControlWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<int> remoteVal = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          // vol and channel
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.volume_up,
                    color: Colors.grey[400],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 225,
                    width: 80,
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.08),
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          )
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        Text(
                          'Vol',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ), // bold
                        Icon(Icons.remove)
                      ],
                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.redAccent,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.black.withOpacity(.08),
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: Icon(
                    Icons.power_settings_new,
                    color: Colors.white,
                  ),
                ),
              ),
              Column(
                children: [
                  Icon(
                    Icons.tv,
                    color: Colors.grey[400],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 225,
                    width: 80,
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color: Colors.black.withOpacity(.08),
                            offset: Offset(0, 2),
                          )
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.keyboard_arrow_up),
                        Text(
                          'Ch',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ), // bold
                        Icon(Icons.keyboard_arrow_down)
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          // add remotes, a/c control, servo motor for analog control pages
          Expanded(
            child: PageView(
              children: [
                Container(
                  height: double.infinity,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1.25,
                    ),
                    itemCount: remoteVal.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              color: Colors.black.withOpacity(.08),
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            remoteVal[index].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: double.infinity,
                  // color: Colors.blueAccent,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Custom Buttons',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          children: List.generate(10, (index) {
                            return Card(
                              margin: EdgeInsets.only(top: 8),
                              child: ListTile(
                                title: Text(index.toString()),
                                subtitle: Text('Channel Name'),
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
