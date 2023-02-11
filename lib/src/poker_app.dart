import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'poker_page.dart';
import 'util/app_text.dart';

class PokerApp extends StatelessWidget {
  const PokerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppText.title,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        canvasColor: Colors.lightGreen,
      ),
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      builder: DevicePreview.appBuilder,
      home: const PokerPage(title: AppText.title),
    );
  }
}
