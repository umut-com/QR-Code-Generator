import 'package:flutter/material.dart';
import 'card_model.dart';
import 'card_view.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(),
    home: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate QR Code For vCard'),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: Builder(
                builder: (context) {
                  double screenWidth = MediaQuery.of(context).size.width;
                  double widthFactor = calculateWidthFactor(screenWidth);

                  return FractionallySizedBox(
                    widthFactor: widthFactor,
                    child: CardView(
                      card: CardModel(
                        name: '',
                        surname: '',
                        title: '',
                        email: '',
                        phone: '',
                        workPhone: '',
                        fax: '',
                        company: '',
                        workAddress: '',
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black12,
    );
  }
}

double calculateWidthFactor(screenWidth) {
  if (screenWidth > 2500) {
    return 0.20;
  } else if (screenWidth > 1920) {
    return 0.25;
  } else if (screenWidth > 1200) {
    return 0.30;
  } else if (screenWidth > 768) {
    return 0.60;
  } else {
    return 1;
  }
}
