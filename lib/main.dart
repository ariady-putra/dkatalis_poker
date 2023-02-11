import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:device_preview_screenshot/device_preview_screenshot.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:universal_platform/universal_platform.dart';

import 'src/poker_app.dart';
import 'src/util/app_splash.dart';

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
        builder: (context) => const PokerApp(),
      ),
    ),
    (error, stack) => log(
      '$error',
      stackTrace: stack,
    ),
  );
}
