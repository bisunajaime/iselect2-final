import 'package:embesys_ctrl/constants.dart';
import 'package:embesys_ctrl/pages/other_devices_page.dart';
import 'package:embesys_ctrl/pages/qr_scanner_page.dart';
import 'package:flutter/material.dart';

class OtherDevicesButtonsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 50,
              child: FlatButton(
                color: boxGrad.colors[1],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OtherDevicesPage(),
                    ),
                  );
                },
                child: Text(
                  'Other Devices',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          SizedBox(
            height: 50,
            width: 50,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.zero,
              color: Colors.white,
              child: Icon(
                Icons.camera_alt,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QrScannerPage(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
