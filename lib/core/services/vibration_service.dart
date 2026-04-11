import 'package:vibration/vibration.dart';

class VibrationService {
  /// Titreşim yeteneği var mı kontrol et
  static Future<bool> hasVibrator() async {
    return (await Vibration.hasVibrator()) ?? false;
  }

  /// Özel deseni oynat
  static Future<void> playPattern(List<int> pattern) async {
    if (await hasVibrator()) {
      Vibration.vibrate(pattern: pattern);
    }
  }

  /// Basit titreşim (Geri bildirim için)
  static Future<void> vibrate() async {
    if (await hasVibrator()) {
      Vibration.vibrate(duration: 50);
    }
  }

  /// İptal et
  static Future<void> cancel() async {
    Vibration.cancel();
  }
}
