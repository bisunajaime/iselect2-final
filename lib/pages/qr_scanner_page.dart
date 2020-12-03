import 'package:embesys_ctrl/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';

class QrScannerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Scan QR Code to \nadd a Device',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                height: 280,
                margin: EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 10,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Center(
                  child: QrReaderView(
                    height: 250,
                    width: 250,
                    callback: (QrReaderViewController val) {
                      print(val.id);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'Button will be enabled once device has\nbeen recognized',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(.5),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: FlatButton(
                    child: Text(
                      'Save device',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: boxGrad.colors[1].withOpacity(.5),
                    onPressed: () {},
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Go Back',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(.5),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
