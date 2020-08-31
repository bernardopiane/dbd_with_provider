import 'package:dbd_with_provider/models/data.dart';
import 'package:dbd_with_provider/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Data(),
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: HomePage()
      ),
    );
  }
}
