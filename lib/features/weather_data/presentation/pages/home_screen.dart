import 'package:flutter/material.dart';
import '../widgets/widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: const <Widget>[
          SizedBox(
            height: 20,
          ),
          HeaderWidget()
        ],
      )),
    );
  }
}
