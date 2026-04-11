import 'package:flutter/material.dart';

/// Titreşim Kodu Modeli
class VibrationCode {
  final String id;
  final String name;
  final String emoji;
  final List<int> pattern; // [vibrate_ms, pause_ms, vibrate_ms, ...]
  final Color color;
  final bool isDefault;
  final String? userId; // null = varsayılan kod

  const VibrationCode({
    required this.id,
    required this.name,
    required this.emoji,
    required this.pattern,
    required this.color,
    this.isDefault = false,
    this.userId,
  });
  
  /// Titreşim pattern'ini string'e çevir (Firestore için)
  String get patternString => pattern.join(',');
  
  /// String'den pattern oluştur
  static List<int> parsePattern(String patternStr) {
    return patternStr.split(',').map((e) => int.parse(e.trim())).toList();
  }
}

/// Varsayılan 6 Hızlı Kod - Mockup'a göre
class DefaultVibrationCodes {
  DefaultVibrationCodes._();
  
  static const Color _defaultColor = Color(0xFFF67280); // Coral Pink
  
  static final List<VibrationCode> codes = [
    VibrationCode(
      id: 'ask',
      name: 'Aşk',
      emoji: '❤️',
      pattern: [100, 50, 100, 50, 400, 100, 100, 50, 100, 50, 400], // Kalp atışı ritmi
      color: _defaultColor,
      isDefault: true,
    ),
    VibrationCode(
      id: 'enerji',
      name: 'Enerji',
      emoji: '⚡',
      pattern: [50, 30, 50, 30, 50, 30, 200], // Hızlı enerji patlaması
      color: _defaultColor,
      isDefault: true,
    ),
    VibrationCode(
      id: 'ev',
      name: 'Ev',
      emoji: '🏠',
      pattern: [300, 150, 300], // 2 uzun titreşim - "Eve geldim"
      color: _defaultColor,
      isDefault: true,
    ),
    VibrationCode(
      id: 'acil',
      name: 'Acil',
      emoji: '🚨',
      pattern: [100, 50, 100, 50, 100, 50, 100, 50, 100, 50, 100], // SOS benzeri - acil
      color: _defaultColor,
      isDefault: true,
    ),
    VibrationCode(
      id: 'kahve',
      name: 'Kahve',
      emoji: '☕',
      pattern: [200, 100, 200, 100, 200], // Yavaş ritim - rahat
      color: _defaultColor,
      isDefault: true,
    ),
    VibrationCode(
      id: 'gece',
      name: 'Gece',
      emoji: '🌙',
      pattern: [500, 200, 300], // Yavaş, sakin - iyi geceler
      color: _defaultColor,
      isDefault: true,
    ),
  ];
  
  /// Günlük rutin kodları
  static final List<VibrationCode> dailyRoutineCodes = [
    VibrationCode(
      id: 'sabah',
      name: 'Sabah',
      emoji: '☀️',
      pattern: [100, 50, 200, 100, 300], // Artan ritim - günaydın
      color: _defaultColor,
      isDefault: true,
    ),
    codes[4], // Kahve
    codes[5], // Gece
  ];
}
