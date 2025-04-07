import 'package:flutter/material.dart';
import 'package:Ganto/Controllers/User_controller.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class QRScannerPageTeacher extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPageTeacher> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String scannedData = "Scan a QR code";

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  // GeneralController _generalController = Get.find<GeneralController>();
  UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scan QR Code",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.blue,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 250,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(scannedData, style: GoogleFonts.poppins(fontSize: 18),overflow: TextOverflow.ellipsis,),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async{

                    await _userController.CheckTeacherQrCodeTeacher(scannedData);
                  //    Get.back(result: scannedData);
                  },
                  child: Obx(
                        () => !_userController.IsCheckingQrCodeTeacher.value
                        ? Text(
                      "Done",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold),
                    )
                        : SizedBox(
                      child: Row(
                        mainAxisSize: MainAxisSize
                            .min, // Takes only necessary space
                        children: [
                          CircularProgressIndicator(
                            color: Colors.black,
                          ),
                          SizedBox(width: 8), // Optional spacing
                          Text(
                            "Checking",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        scannedData = scanData.code ?? "No Data";
      });
    });
  }
}
