import 'package:embesys_ctrl/constants.dart';
import 'package:embesys_ctrl/models/modules_model.dart';
import 'package:embesys_ctrl/providers/room_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomsPagesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<RoomProvider>(context);

    return Expanded(
      child: Container(
        child: PageView.builder(
          controller: pageProvider.pageController,
          itemCount: pageProvider.pages.length,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            final List<ModulesModel> model = pageProvider.pages[i].modules;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              itemCount: model.length,
              physics: BouncingScrollPhysics(),
              // shrinkWrap: true,
              itemBuilder: (context, index) {
                ModulesModel module = model[index];
                bool isOn = !module.isOn;
                return Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: isOn ? boxGrad : null,
                    color: isOn ? null : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(.05),
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            module.icon,
                            color: isOn ? Colors.white : Colors.black,
                          ),
                          Transform.scale(
                            scale: .8,
                            child: Switch(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              onChanged: (value) {
                                print(value);
                                print(
                                    pageProvider.pages[i].modules[index].isOn);
                                pageProvider.toggleLed(
                                  index,
                                  i,
                                  state: value,
                                );
                              },
                              activeColor: boxGrad.colors[0],
                              activeTrackColor: boxGrad.colors[1],
                              value: !pageProvider.pages[i].modules[index].isOn,
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: SizedBox()),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            module.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: isOn ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            isOn ? "OPENED" : "CLOSED",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: isOn ? Colors.white70 : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
