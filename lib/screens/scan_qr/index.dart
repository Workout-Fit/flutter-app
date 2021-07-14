import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:workout/screens/workout_master_detail/workout.dart';
import 'package:workout/screens/workout_master_detail/workout_master_detail_arguments.dart';

class ScanQRPage extends StatefulWidget {
  static const routeName = "/qr-scan";

  const ScanQRPage({Key? key}) : super(key: key);

  @override
  _ScanQRPageState createState() => _ScanQRPageState();
}

class _ScanQRPageState extends State<ScanQRPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
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
      controller.pauseCamera();
      HapticFeedback.lightImpact();
      Navigator.of(context)
          .pushNamed(
            WorkoutMasterDetailPage.routeName,
            arguments: WorkoutMasterDetailArguments(
              workoutId: scanData.code,
            ),
          )
          .then((value) => controller.resumeCamera());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
        ),
      ),
    );
  }
}
