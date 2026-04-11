import 'package:flutter/material.dart';

/// Titri App Color Palette
/// Renk şeması mockup'lardan çıkarıldı
class AppColors {
  AppColors._();

  // Ana Renkler
  static const Color primary = Color(0xFFF67280);      // Coral Pink - Ana buton ve vurgular
  static const Color secondary = Color(0xFFFFB3BA);    // Secondary - Açık pembe / Vurgu
  static const Color primaryDark = Color(0xFFE85A6B);  // Koyu pembe
  static const Color primaryLight = Color(0xFFFFB3BA); // Açık pembe
  
  // Arka Plan Renkleri
  static const Color background = Color(0xFF2D2A4A);   // Koyu lacivert - Ana arka plan
  static const Color backgroundDark = Color(0xFF1E1B38); // Daha koyu versiyon
  static const Color surface = Color(0xFF3D3A5C);      // Kart arka planları (koyu)
  
  // Kart Renkleri
  static const Color cardPink = Color(0xFFF67280);     // Pembe kartlar
  static const Color cardPinkLight = Color(0xFFFFB3BA); // Açık pembe (input alanları)
  
  // Metin Renkleri
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFB8B5C8);
  static const Color textOnPink = Color(0xFF2D2A4A);   // Pembe üzerinde koyu metin
  static const Color textAccent = Color(0xFFF67280);   // Vurgulu metin (link vb.)
  
  // Hızlı Kod Renkleri (6 kod için)
  static const Color codeAsk = Color(0xFFF67280);      // ❤️ Aşk - Pembe
  static const Color codeEnerji = Color(0xFFF67280);   // ⚡ Enerji - Pembe
  static const Color codeEv = Color(0xFFF67280);       // 🏠 Ev - Pembe
  static const Color codeAcil = Color(0xFFF67280);     // 🚨 Acil - Pembe
  static const Color codeKahve = Color(0xFFF67280);    // ☕ Kahve - Pembe
  static const Color codeGece = Color(0xFFF67280);     // 🌙 Gece - Pembe
  
  // Durum Renkleri
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFA726);
  static const Color info = Color(0xFF29B6F6);
  
  // Online/Offline Durumu
  static const Color online = Color(0xFF4CAF50);
  static const Color offline = Color(0xFF9E9E9E);
  
  // Gradient'lar
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [background, backgroundDark],
  );
  
  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [primary, primaryDark],
  );
}
