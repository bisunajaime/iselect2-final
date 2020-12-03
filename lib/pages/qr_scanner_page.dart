import 'dart:convert';
import 'dart:developer';

import 'package:embesys_ctrl/constants.dart';
import 'package:embesys_ctrl/models/device_model.dart';
import 'package:embesys_ctrl/pages/device_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QrScannerPage extends StatefulWidget {
  @override
  _QrScannerPageState createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  String data;
  DeviceModel _model;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 150,
                width: 150,
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
                    child: Image.asset(
                      'assets/images/qr.png',
                      scale: 12,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Scan QR Code to \nadd a Device',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: FlatButton(
                    child: data == null
                        ? Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          )
                        : Text(
                            'Tap here to scan ${data != null ? 'again' : ''}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: boxGrad.colors[1],
                    onPressed: () async {
                      final result = await FlutterBarcodeScanner.scanBarcode(
                        '#ff6666',
                        'Dismiss',
                        true,
                        ScanMode.QR,
                      );
                      print(result);
                      DeviceModel model;
                      try {
                        var res = jsonDecode(result);
                        model = DeviceModel.fromJson(res);
                        log(model.type);
                        log(model.deviceName);
                        log(model.deviceTag);
                      } catch (e) {
                        setState(() {
                          data = null;
                        });
                        log(e.toString());
                        return;
                      }
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              Text('Loading'),
                            ],
                          ),
                        ),
                      );
                      await Future.delayed(Duration(seconds: 1));
                      Navigator.pop(context);
                      setState(() {
                        data = result;
                        _model = model;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              if (data != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: FlatButton(
                      child: Text(
                        'Save device',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      disabledColor: boxGrad.colors[1].withOpacity(.5),
                      color: boxGrad.colors[1],
                      onPressed: data != null
                          ? () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DeviceDetailsPage(
                                      model: _model,
                                    ),
                                  ));
                            }
                          : null,
                    ),
                  ),
                ),
              if (data != null)
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
