import 'package:flutter/material.dart';
import 'card_model.dart';
import 'card_view.dart';

class CardPage extends StatelessWidget {
  
  final CardModel card;

  const CardPage({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      backgroundColor: Colors.black,
      body: CardView(card: card),
    )); 
  }
}

