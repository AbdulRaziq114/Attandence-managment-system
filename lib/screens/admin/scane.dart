import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRAttendanceScreen extends StatefulWidget {
  const QRAttendanceScreen({super.key});

  @override
  State<QRAttendanceScreen> createState() => _QRAttendanceScreenState();
}

class _QRAttendanceScreenState extends State<QRAttendanceScreen> {
  String scannedData = "";
  final MobileScannerController controller = MobileScannerController();

  @override
  void dispose() {
    controller.dispose(); // Camera release
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     const Color accent = Color.fromARGB(255, 0, 5, 43);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Attendance', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: accent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: MobileScanner(
              controller: controller,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  final String? code = barcode.displayValue; // rawValue ki jagah displayValue
                  if (code != null && scannedData.isEmpty) {
                    setState(() {
                      scannedData = code;
                    });
                    // DB ya attendance logic yahan
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Attendance marked for $scannedData"),
                      ),
                    );
                  }
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                scannedData.isEmpty
                    ? "Scan a QR code or Barcode"
                    : "Scanned: $scannedData",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
