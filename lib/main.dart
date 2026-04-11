import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Sistem UI ayarları
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF2D2A4A),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  
  // Dikey yönlendirme zorla
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Firebase başlatma - Firebase kurulduktan sonra aktif et
  /* 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  */
  
  runApp(
    const ProviderScope(
      child: TitriApp(),
    ),
  );
}
