import 'dart:io';

import 'package:chatapp/screens/welcome/welcome_screen.dart';
import 'package:chatapp/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart' as window_size;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  void run() async {
    if (!kIsWeb) {
      if (Platform.isWindows || Platform.isMacOS) {
        var window = await window_size.getWindowInfo();
        if (window.screen != null) {
          final screenFrame = window.screen!.visibleFrame;
          final width =
              (window.screen!.visibleFrame.height * 0.95) * (9.0 / 16.0);
          final height = (window.screen!.visibleFrame.height * 0.95);
          final left = ((screenFrame.width - width)).roundToDouble();
          final top = ((screenFrame.height - height) / 3).roundToDouble();
          final frame = Rect.fromLTWH(left, top, width, height);
          window_size.setWindowFrame(frame);
          window_size.setWindowMaxSize(Size(width, height));
          window_size.setWindowMinSize(Size(width, height));
        }
      }
    }
    runApp(const MyApp());
  }

  run();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      home: const WelcomeScreen(),
    );
  }
}
