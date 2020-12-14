import 'package:embesys_finals/models/ir_model.dart';
import 'package:embesys_finals/pages/edit_remote_page.dart';
import 'package:embesys_finals/provider/ir_list_provider.dart';
import 'package:embesys_finals/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:timeago/timeago.dart' as timeago;

class RemoteButtonsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiColors.primaryColor,
      appBar: AppBar(
        title: Text('Buttons Page'),
        backgroundColor: UiColors.secondaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            color: UiColors.lightTextColor,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Instructions'),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Tap and hold a card to edit'),
                      Text('Double tap to delete.')
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
                ),
              );
            },
          )
        ],
      ),
      body: Consumer<IRListProvider>(
        builder: (context, value, child) {
          if (value.irRecvList.length == 0) {
            return Center(
              child: Text('None found'),
            );
          }

          value.irRecvList.sort((a, b) => b.dateAdded.compareTo(a.dateAdded));

          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text('Filters'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: value.irRecvList.length,
                  itemBuilder: (context, index) {
                    IRModel model = value.irRecvList[index];
                    return Container(
                      margin: EdgeInsets.only(
                        bottom: 8,
                        right: 16,
                        left: 16,
                      ),
                      decoration: BoxDecoration(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: UiColors.lightTextColor,
                            child: Icon(
                              Icons.settings_remote,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                // send channel signal
                              },
                              onLongPress: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditRemotePage(
                                        index: index,
                                      ),
                                    ));
                              },
                              onDoubleTap: () {
                                value.deleteIRData(index);
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Deleted"),
                                      content: Text('Button has been deleted.'),
                                      actions: [
                                        FlatButton(
                                          child: Text('Dismiss'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: UiColors.secondaryColor,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5,
                                      color: Colors.black.withOpacity(.15),
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${model.label ?? "Tap and hold to edit."}"),
                                    Divider(),
                                    Text(
                                      "HEX_VAL: ${model.value}",
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(.5),
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "Category: ${model.category ?? "Edit to add a category"}",
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(.5),
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 14,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${timeago.format(model.dateAdded)}",
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(.5),
                                            fontSize: 12,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Icon(
                                          Icons.access_time,
                                          size: 15,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                    return Card(
                      color: UiColors.secondaryColor,
                      margin: EdgeInsets.only(
                        bottom: 8,
                        right: 16,
                        left: 16,
                        top: index == 0 ? 8 : 0,
                      ),
                      child: ListTile(
                        title: Text(value.irRecvList[index].label ??
                            "Tap and hold to edit"),
                        subtitle: Text(
                            "Added ${timeago.format(value.irRecvList[index].dateAdded)}"),
                        trailing: Icon(
                          Icons.arrow_forward,
                        ),
                        leading: Icon(
                          Icons.settings_remote,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
