import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gemini_photex/pages/chat_screen.dart';
import 'env/env.dart';

void main() {
  Gemini.init(apiKey: Env.GEMINI_API_KEY, enableDebugging: true);
  runApp(const ScaffoldExampleApp());
}

class ScaffoldExampleApp extends StatelessWidget {
  const ScaffoldExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const ChatScreen(),
    );
  }
}
