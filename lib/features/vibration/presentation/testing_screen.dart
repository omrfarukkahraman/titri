import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/vibration_patterns.dart';
import '../../../core/services/vibration_service.dart';

/// Deney/Test Ekranı
/// Yarışma raporundaki "Yöntem" kısmını desteklemek için
class TestingScreen extends StatefulWidget {
  const TestingScreen({super.key});

  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  int _currentIndex = 0;
  final List<bool?> _results = List.generate(DefaultVibrationCodes.codes.length, (_) => null);
  bool _isPlaying = false;

  void _playCurrent() async {
    setState(() => _isPlaying = true);
    await VibrationService.playPattern(DefaultVibrationCodes.codes[_currentIndex].pattern);
    setState(() => _isPlaying = false);
  }

  void _recordResult(bool success) {
    setState(() {
      _results[_currentIndex] = success;
      if (_currentIndex < DefaultVibrationCodes.codes.length - 1) {
        _currentIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentCode = DefaultVibrationCodes.codes[_currentIndex];
    final progress = (_currentIndex + 1) / DefaultVibrationCodes.codes.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Ar-Ge: Titreşim Ayırt Etme Testi'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // İlerleme
            LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.backgroundDark,
              color: AppColors.primary,
            ),
            const SizedBox(height: 10),
            Text(
              'Soru ${_currentIndex + 1} / ${DefaultVibrationCodes.codes.length}',
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            
            const Spacer(),
            
            // Test Kartı
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.backgroundDark,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.primary.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Aşağıdaki kodu dinleyin ve ayırt edip edemediğinizi belirtin:',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    currentCode.emoji,
                    style: const TextStyle(fontSize: 64),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    currentCode.name,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Oynat Butonu
                  ElevatedButton.icon(
                    onPressed: _isPlaying ? null : _playCurrent,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    icon: Icon(_isPlaying ? Icons.vibration : Icons.play_arrow),
                    label: Text(_isPlaying ? 'Titriyor...' : 'Titreşimi Dinle'),
                  ),
                ],
              ),
            ),
            
            const Spacer(),
            
            // Değerlendirme Butonları
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _recordResult(false),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Ayırt Edilemedi'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _recordResult(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Anlaşıldı'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            
            // Raporlama Notu
            const Text(
              '* Bu veriler anonim olarak toplanarak yöntemin doğruluğunu kanıtlamak için proje raporunda kullanılacaktır.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white30, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
