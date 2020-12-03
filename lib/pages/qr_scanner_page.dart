import 'dart:developer';

import 'package:embesys_ctrl/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';
import 'package:flutter_qr_reader/qrcode_reader_view.dart';

class QrScannerPage extends StatefulWidget {
  @override
  _QrScannerPageState createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  QrReaderViewController _controller;
  String data = "";

  @override
  void initState() {
    super.initState();
  }

  void onScan(String v, List<Offset> offsets) {
    print([v, offsets]);
    _controller.stopCamera();
    setState(() {
      data = v;
    });
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Scanned'),
          content: Text(data),
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
  }

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
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: QrReaderView(
                        height: 280,
                        width: 280,
                        callback: (QrReaderViewController val) {
                          setState(() {
                            _controller = val;
                          });
                          _controller.startCamera(onScan);
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              GestureDetector(
                  onTap: () {
                    assert(_controller != null);
                    _controller.startCamera(onScan);
                  },
                  child: Text(
                    'Tap here to scan again.',
                  )),
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
