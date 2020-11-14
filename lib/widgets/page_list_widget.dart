import 'package:embesys_ctrl/models/page_model.dart';
import 'package:embesys_ctrl/providers/room_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<RoomProvider>(context);
    final rooms = pageProvider.pages;
    return Container(
      height: 50,
      width: double.infinity,
      child: ListView.builder(
        itemCount: rooms.length,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          PageModel page = rooms[index];
          return GestureDetector(
            onTap: () {
              pageProvider.updatePage(index);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    page.title,
                    style: TextStyle(
                      fontWeight:
                          page.isSelected ? FontWeight.bold : FontWeight.w400,
                      color: page.isSelected ? Colors.black : Colors.black54,
                    ),
                  ),
                  Icon(
                    Icons.fiber_manual_record,
                    color: page.isSelected ? Colors.black : Colors.transparent,
                    size: 10,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
