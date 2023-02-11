import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:device_preview_screenshot/device_preview_screenshot.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;
import 'package:universal_platform/universal_platform.dart';

import 'src/bloc/poker_bloc.dart';
import 'src/util/app_splash.dart';
import 'src/util/app_text.dart';
import 'src/widgets/table.dart';

void main() {
  AppSplash.preserve(
    WidgetsFlutterBinding.ensureInitialized(),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  FlutterError.onError = (details) => log(
        details.exceptionAsString(),
        stackTrace: details.stack,
      );
  runZonedGuarded(
    () => runApp(
      DevicePreview(
        enabled: !kReleaseMode && UniversalPlatform.isDesktop,
        storage: DevicePreviewStorage.none(),
        tools: [
          ...DevicePreview.defaultTools,
          DevicePreviewScreenshot(
            onScreenshot: (context, screenshot) => screenshotAsFiles(
              Directory(
                path.join(
                  Directory.current.path,
                  'screenshots',
                ),
              ),
            ).call(context, screenshot),
          ),
        ],
        builder: (context) => const MyApp(),
      ),
    ),
    (error, stack) => log(
      '$error',
      stackTrace: stack,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const MyHomePage(title: AppText.title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
    ).whenComplete(
      () => AppSplash.remove(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (_) => PokerBloc(),
          child: const WidgetTable(),
        ),
      ),
    );
  }
}
