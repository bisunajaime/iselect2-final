import 'package:embesys_ctrl/constants.dart';
import 'package:flutter/material.dart';

class OtherDevicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: scaffoldBgColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: AppBar(
            bottom: TabBar(
              indicatorColor: Colors.white,
              isScrollable: true,
              // labelPadding: EdgeInsets.zero,
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white.withOpacity(.5),
                fontFamily: 'Montserrat',
              ),
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Montserrat',
              ),
              tabs: [
                Tab(
                  child: Text(
                    'Living Room',
                  ),
                ),
                Tab(
                  child: Text(
                    'Kitchen',
                  ),
                ),
                Tab(
                  child: Text(
                    'Entertainment Room',
                  ),
                ),
              ],
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Currently showing Living Room',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(.8),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'Other Devices',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            backgroundColor: boxGrad.colors[1],
            elevation: 1,
          ),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
              padding: EdgeInsets.only(
                top: 8,
                left: 8,
                right: 8,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: index.isEven ? Colors.white : boxGrad.colors[1],
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: index.isEven
                        ? [
                            BoxShadow(
                              blurRadius: 10,
                              color: Colors.black.withOpacity(.05),
                              offset: Offset(0, 1),
                            )
                          ]
                        : null,
                  ),
                );
              },
            ),
            GridView.builder(
              padding: EdgeInsets.only(
                top: 8,
                left: 8,
                right: 8,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: index.isOdd ? Colors.white : boxGrad.colors[1],
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: index.isEven
                        ? [
                            BoxShadow(
                              blurRadius: 10,
                              color: Colors.black.withOpacity(.05),
                              offset: Offset(0, 1),
                            )
                          ]
                        : null,
                  ),
                );
              },
            ),
            GridView.builder(
              padding: EdgeInsets.only(
                top: 8,
                left: 8,
                right: 8,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: index.isEven ? Colors.white : boxGrad.colors[1],
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: index.isEven
                        ? [
                            BoxShadow(
                              blurRadius: 10,
                              color: Colors.black.withOpacity(.05),
                              offset: Offset(0, 1),
                            )
                          ]
                        : null,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
