import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'features/home/home_page.dart';

/// 简洁克制:单一主色(PRD §2),亮暗双主题由 Material 3 生成。
void main() {
  runApp(const ProviderScope(child: ZhabitApp()));
}

class ZhabitApp extends StatelessWidget {
  const ZhabitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zhabit',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D6B))),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D6B),
          brightness: Brightness.dark,
        ),
      ),
      home: const HomePage(),
    );
  }
}