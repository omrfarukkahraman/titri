import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/constants/app_strings.dart';

/// Titri Ana Uygulama Widget'ı
class TitriApp extends ConsumerWidget {
  const TitriApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      
      // Tema
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      
      // Router
      routerConfig: AppRouter.router,
      
      // Localization (gelecekte eklenebilir)
      // localizationsDelegates: [...],
      // supportedLocales: [...],
    );
  }
}
