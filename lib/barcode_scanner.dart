// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({Key? key}) :super(key: key);

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  MobileScannerController? cameraController;
  bool _screenOpened = false;
  bool isTorchEnabled = false;
  CameraFacing cameraFacing = CameraFacing.back;

  @override
  void initState() {
    super.initState();
    cameraController = MobileScannerController();
  }

  @override
  void dispose() {
    cameraController?.dispose();super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("Scan Barcode")),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            cameraController?.dispose();
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            color: Colors.white,
            icon: isTorchEnabled
                ? const Icon(Icons.flash_on, color: Colors.yellow)
                : const Icon(Icons.flash_off, color: Colors.grey),
            iconSize: 32.0,
            onPressed: () {
              setState(() {
                isTorchEnabled = !isTorchEnabled;
                cameraController?.toggleTorch();
              });
            },
          ),
          IconButton(
            color: Colors.white,
            icon: cameraFacing == CameraFacing.front
                ? const Icon(Icons.camera_front, color: Colors.grey)
                : const Icon(Icons.camera_rear, color: Colors.grey),
            iconSize:32.0,
            onPressed: () {
              setState(() {
                cameraFacing = cameraFacing == CameraFacing.front
                    ? CameraFacing.back
                    : CameraFacing.front;
                cameraController?.switchCamera();
              });
            },
          ),
        ],
      ),
      body: cameraController != null
          ? MobileScanner(
        controller: cameraController!,
        onDetect: (capture) {
          if (capture.barcodes.isNotEmpty) {
            final barcode = capture.barcodes.first;
            _foundBarcode(barcode);
          } else {
            debugPrint('No barcodes detected.');
          }
        },
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  void _foundBarcode(Barcode barcode) {
    if (!_screenOpened) {
      final String code = barcode.rawValue ?? "---";
      debugPrint('Barcode found! $code');
      _screenOpened = true;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FoundCodeScreen(
            screenClosed: _screenWasClosed,
            value: code,
          ),
        ),
      );
    }
  }

  void _screenWasClosed() {
    _screenOpened = false;
  }
}

class FoundCodeScreen extends StatefulWidget {
  final String value;
  final Function() screenClosed;
  const FoundCodeScreen({
    Key? key,
    required this.value,
    required this.screenClosed,
  }) : super(key: key);

  @override
  State<FoundCodeScreen> createState() => _FoundCodeScreenState();
}

class _FoundCodeScreenState extends State<FoundCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Found Code"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            widget.screenClosed();
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Scanned Code:", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text(widget.value, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}