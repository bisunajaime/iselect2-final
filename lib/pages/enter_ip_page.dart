import 'package:embesys_finals/pages/devices_page.dart';
import 'package:embesys_finals/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;

class EnterIPPage extends StatefulWidget {
  @override
  _EnterIPPageState createState() => _EnterIPPageState();
}

class _EnterIPPageState extends State<EnterIPPage> {
  TextEditingController _ipController = TextEditingController();
  SwiperController _controller = SwiperController();
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> _carouselItems = [
    {
      'title': 'The Future is Now.',
      'subtitle': RichText(
        textAlign: TextAlign.center,
        text: TextSpan(style: TextStyle(color: Colors.white54), children: [
          TextSpan(text: 'Plug in and connect to your ESP8266 device named '),
          TextSpan(
              text: '"CambooBabbage123"',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
          TextSpan(text: ' to sync and control your devices.'),
        ]),
      ),
      'img': 'assets/images/future.png'
    },
    {
      'title': 'Cross-Platform',
      'subtitle': RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text:
              'Available on both mobile, web, and desktop platforms. Control your devices from anywhere in realtime.',
          style: TextStyle(color: Colors.white54),
        ),
      ),
      'img': 'assets/images/cross_platform.png'
    },
    {
      'title': 'Control Anywhere',
      'subtitle': RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text:
              'Easily control different devices such as your TV, microwave, lights and many more in just one app.',
          style: TextStyle(color: Colors.white54),
        ),
      ),
      'img': 'assets/images/microwave.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    // return _buildHome();
    return Scaffold(
      backgroundColor: UiColors.primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 300,
                  width: double.infinity,
                  child: Swiper(
                    controller: _controller,
                    scrollDirection: Axis.horizontal,
                    itemCount: _carouselItems.length,
                    // pagination: SwiperPagination(
                    //   alignment: Alignment.bottomCenter,
                    //   builder: SwiperCustomPagination(
                    //     builder:
                    //         (BuildContext context, SwiperPluginConfig config) {
                    //       return Row(
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: List.generate(
                    //           config.itemCount,
                    //           (index) => Padding(
                    //             padding: const EdgeInsets.only(
                    //               left: 2.5,
                    //               right: 2.5,
                    //               top: 10,
                    //             ),
                    //             child: CircleAvatar(
                    //               backgroundColor: config.activeIndex == index
                    //                   ? Colors.blueAccent
                    //                   : Colors.grey,
                    //               radius: config.activeIndex == index ? 3 : 2.5,
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Image.asset(
                                _carouselItems[index]['img'],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              _carouselItems[index]['title'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            _carouselItems[index]['subtitle'],
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _ipController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (!RegExp('^(?:[0-9]{1,3}\.){3}[0-9]{1,3}\$')
                              .hasMatch(value)) {
                            return '* Please enter a valid IP.';
                          }

                          if (value.trim().length == 0) {
                            return "* Required field.";
                          }

                          return null;
                        },
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: UiColors.secondaryColor,
                          hintText: '(e.g. 192.168.254.109)',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.white24,
                            fontWeight: FontWeight.normal,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () => _ipController.clear(),
                            child: Icon(
                              Icons.clear,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: FlatButton(
                          color: UiColors.lightTextColor,
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          onPressed: () async {
                            // TODO: make network request and check if response is successful.
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            String ipAddr = "http://${_ipController.text}";
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => DevicesPage(
                                    socketUrl: _ipController.text,
                                  ),
                                ));
                            return;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/**
 * 
 * Add control/category page (e.g. kitchen, living room)
 *    schema (categoryname, label,)
 * Button to "Listen for Control Inputs"
 * Open socket and listen to inputs
 * Save to db
 * add a button below that asks, "Done listening? Tap here to go back."
 * Request control data from db 
 * 
 */
