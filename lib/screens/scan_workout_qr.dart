import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanWorkoutQR extends StatefulWidget {
  const ScanWorkoutQR({Key? key}) : super(key: key);

  @override
  _ScanWorkoutQRState createState() => _ScanWorkoutQRState();
}

class _ScanWorkoutQRState extends State<ScanWorkoutQR> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  late QRViewController controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid)
      controller.pauseCamera();
    else if (Platform.isIOS) controller.resumeCamera();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      HapticFeedback.lightImpact();
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: (result != null)
                ? Text('Data: ${result!.code}')
                : Text('Scan a code'),
          ),
        ),
      ],
    ));
  }
}
