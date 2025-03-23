import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:order_management_flutter_app/features/table/model/table_model.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter/foundation.dart';
import 'dart:html' as html;
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class QRCodeWithBackground extends StatefulWidget {
  final TableModel table;

  const QRCodeWithBackground({super.key, required this.table});

  @override
  State<QRCodeWithBackground> createState() => _QRCodeWithBackgroundState();
}

class _QRCodeWithBackgroundState extends State<QRCodeWithBackground>
    with SingleTickerProviderStateMixin {
  final ScreenshotController screenshotController = ScreenshotController();
  final ScreenshotController titleScreenshotController = ScreenshotController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  late TabController _tabController;

  List<String> backgroundImages = [
    'assets/images/qr_background_1.jpg',
    'assets/images/qr_background_2.jpg',
    'assets/images/qr_background_3.jpg',
  ];
  List<Color> qrColors = [
    Colors.black,
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.teal,
    Colors.pink,
    Colors.cyan,
    Colors.amber
  ];

  String selectedBackground = 'assets/images/qr_background_1.jpg';
  Color selectedQrColor = Colors.black;

  // ValueNotifier for title and description
  final ValueNotifier<String> titleNotifier = ValueNotifier('');
  final ValueNotifier<String> descNotifier = ValueNotifier('');

  @override
  void initState() {
    super.initState();
    titleController.text = widget.table.name;
    descController.text = ''; // Set initial description if needed
    titleNotifier.value = widget.table.name;
    _tabController = TabController(length: 3, vsync: this);

    // Update ValueNotifiers when text changes
    titleController.addListener(() {
      titleNotifier.value = titleController.text;
    });

    descController.addListener(() {
      descNotifier.value = descController.text;
    });
  }

  Future<void> _saveImage() async {
    try {
      Uint8List? finalImageBytes = await titleScreenshotController.capture();
      if (finalImageBytes == null) {
        throw "Không thể chụp màn hình!";
      }

      String fileName = "qrcode_${widget.table.id}.png";

      if (kIsWeb) {
        final blob = html.Blob([finalImageBytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute("download", fileName)
          ..click();
        html.Url.revokeObjectUrl(url);
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi khi lưu ảnh: $error")),
      );
    }
  }

  @override
  void dispose() {
    // Dispose ValueNotifiers to avoid memory leaks
    titleNotifier.dispose();
    descNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // QR Code + Title
          Expanded(
            flex: 6,
            child: SizedBox(
              width: double.infinity,
              child: Screenshot(
                controller: titleScreenshotController,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        selectedBackground,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (titleNotifier != ''  || titleNotifier == null) ...[
                          ValueListenableBuilder<String>(
                            valueListenable: titleNotifier,
                            builder: (context, title, child) {
                              return Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                        ],
                        if (descNotifier != '' || descNotifier == null ) ...[
                          ValueListenableBuilder<String>(
                            valueListenable: descNotifier,
                            builder: (context, desc, child) {
                              return Text(
                                desc,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                        ],
                        Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 5,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: QrImageView(
                              data:
                                  "https://pbqpos.netlify.app/customer/order/table/${widget.table.id}",
                              version: QrVersions.auto,
                              size: 140,
                              foregroundColor: selectedQrColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // TabBar
          Expanded(
            flex: 4,
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: "Thông tin"),
                    Tab(text: "Chọn nền"),
                    Tab(text: "Chọn màu QR"),
                  ],
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  indicator: MaterialIndicator(
                    height: 4,
                    color: Colors.blue,
                    topLeftRadius: 8,
                    topRightRadius: 8,
                    horizontalPadding: 20,
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // Tab 1: Nhập thông tin
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: titleController,
                              decoration: InputDecoration(
                                labelText: "Tiêu đề",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: descController,
                              decoration: InputDecoration(
                                labelText: "Mô tả",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Tab 2: Chọn nền (Background)
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(10),
                          itemCount: backgroundImages.length,
                          itemBuilder: (context, index) {
                            bool isSelected =
                                selectedBackground == backgroundImages[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedBackground =
                                        backgroundImages[index];
                                  });
                                },
                                child: Column(
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.asset(
                                            backgroundImages[index],
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        if (isSelected)
                                          const Positioned(
                                            top: 5,
                                            right: 5,
                                            child: Icon(Icons.check_circle,
                                                color: Colors.green, size: 24),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Nền ${index + 1}",
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.blue
                                            : Colors.black,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // Tab 3: Chọn màu QR
                      GridView.builder(
                        padding: const EdgeInsets.all(10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: qrColors.length,
                        itemBuilder: (context, index) {
                          bool isSelected = selectedQrColor == qrColors[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedQrColor = qrColors[index];
                              });
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: qrColors[index],
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: isSelected ? 3 : 1,
                                      color: isSelected
                                          ? Colors.green
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  const Center(
                                    child: Icon(Icons.check_circle,
                                        color: Colors.white, size: 20),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _saveImage,
                  icon: const Icon(Icons.download),
                  label: const Text("Tải mã QR"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
