import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:html';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import 'card_model.dart';

import 'dart:async';

class CardView extends StatefulWidget {
  final CardModel card;

  const CardView({Key? key, required this.card}) : super(key: key);

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  late String _qrData;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _workPhoneController = TextEditingController();
  final TextEditingController _faxController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _workAddressController = TextEditingController();
  final GlobalKey _qrImageKey = GlobalKey();
  ScreenshotController screenshotController = ScreenshotController();

// to save image bytes of widget
  Uint8List? bytes;

  @override
  void initState() {
    super.initState();

    _updateQRData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                sizedBox(),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => _updateQRData(),
                ),
                sizedBox(),
                TextFormField(
                  controller: _surnameController,
                  decoration: const InputDecoration(
                    labelText: 'Surname',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => _updateQRData(),
                ),
                sizedBox(),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => _updateQRData(),
                ),
                sizedBox(),
                TextFormField(
                  controller: _companyController,
                  decoration: const InputDecoration(
                    labelText: 'Company',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => _updateQRData(),
                ),
                sizedBox(),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => _updateQRData(),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => _updateQRData(),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _workPhoneController,
                  decoration: const InputDecoration(
                    labelText: 'Work phone',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => _updateQRData(),
                ),
                sizedBox(),
                TextFormField(
                  controller: _faxController,
                  decoration: const InputDecoration(
                    labelText: 'Fax',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => _updateQRData(),
                ),
                sizedBox(),
                TextFormField(
                  controller: _workAddressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => _updateQRData(),
                ),
                sizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      child: const Text(
                        'Download QR Code',
                      ),
                      onPressed: () {
                        screenshotController
                            .capture(delay: Duration(milliseconds: 10))
                            .then((capturedImage) async {
                          ShowCapturedWidget(context, capturedImage!);
                        }).catchError((onError) {
                          print(onError);
                        });
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _clearInputFields();
                        },
                        child: const Text('Clean Inputs')),
                  ],
                ),
                sizedBox(),
                sizedBox(),
                Card(
                  child: RepaintBoundary(
                    key: _qrImageKey,
                    child: Screenshot(
                      controller: screenshotController,
                      child: QrImage(
                        backgroundColor: Colors.white,
                        data: _qrData,
                        size: constraints.maxWidth * 0.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  SizedBox sizedBox() => const SizedBox(height: 12);

  void _updateQRData() {
    _qrData = 'BEGIN:VCARD\n'
        'VERSION:3.0\n'
        'N:${_surnameController.text};${_nameController.text}\n'
        'FN:${_nameController.text} ${_surnameController.text}\n'
        'TITLE:${_titleController.text}\n'
        'EMAIL:${_emailController.text}\n'
        'TEL:${_phoneController.text}\n'
        'TEL;TYPE=WORK:${_workPhoneController.text}\n'
        'TEL;TYPE=FAX:${_faxController.text}\n'
        'ORG:${_companyController.text}\n'
        'ADR;WORK:${_workAddressController.text}\n'
        'END:VCARD';

    setState(() {});
  }

  void _clearInputFields() {
    _nameController.clear();
    _surnameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _companyController.clear();
    _titleController.clear();
    _workPhoneController.clear();
    _faxController.clear();
    _workAddressController.clear();
    _updateQRData();
  }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          title: const Text("QR KOD"),
        ),
        body: Column(
          children: [
            AlertDialog(
              title: Center(
                  child: capturedImage != null
                      ? Card(child: Image.memory(capturedImage))
                      : Container()),
            ),
            ElevatedButton(
              onPressed: () {
                downloadFile(capturedImage,
                    '${_nameController.text} ${_surnameController.text} ${_titleController.text} ${_companyController.text} ${_emailController.text} ${_workAddressController.text}.png');
              },
              child: const Text('Download QR Code'),
            )
          ],
        ),
      ),
    );
  }

  void downloadFile(Uint8List data, String fileName) {
    final blob = Blob([data], 'image/png');

    final url = Url.createObjectUrlFromBlob(blob);
    final anchor = AnchorElement(href: url)..setAttribute('download', fileName);
    document.body!.append(anchor);
    anchor.click();
    anchor.remove();
    Url.revokeObjectUrl(url);
  }
}
