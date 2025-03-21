import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class QRCodeGenerator extends StatefulWidget {
  final String tableId;

  const QRCodeGenerator({super.key, required this.tableId});

  @override
  State<QRCodeGenerator> createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  final ScreenshotController screenshotController = ScreenshotController();

  Future<void> _saveQRCode() async {
    try {
      Uint8List? imageBytes = await screenshotController.capture();
      if (imageBytes == null) {
        throw "Không thể chụp ảnh QR Code!";
      }

      // Lưu ảnh vào thư viện
      final result = await ImageGallerySaver.saveImage(imageBytes);
      if (result['isSuccess']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Ảnh đã được lưu vào thư viện!")),
        );
      } else {
        throw "Lưu ảnh thất bại!";
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi khi lưu ảnh: $error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String qrData = "https://pbqpos.netlify.app/customer/order/table/${widget.tableId}";

    return Scaffold(
      appBar: AppBar(title: const Text("QR Code Generator")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Screenshot(
              controller: screenshotController,
              child: QrImageView(
                data: qrData,
                version: QrVersions.auto,
                size: 200.0,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _saveQRCode,
              icon: const Icon(Icons.download),
              label: const Text("Tải ảnh về"),
            ),
          ],
        ),
      ),
    );
  }
}
