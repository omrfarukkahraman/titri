import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/services/vibration_service.dart';

/// Özel Titreşim Kodu Oluşturma Ekranı
class CreateCodeScreen extends StatefulWidget {
  const CreateCodeScreen({super.key});

  @override
  State<CreateCodeScreen> createState() => _CreateCodeScreenState();
}

class _CreateCodeScreenState extends State<CreateCodeScreen> {
  final _nameController = TextEditingController();
  String _selectedEmoji = '❤️';
  List<int> _pattern = [200, 100, 200];
  
  final List<String> _emojis = [
    '❤️', '💕', '😊', '😎', '🔥', '⭐',
    '🎉', '👋', '✅', '❌', '🚨', '☕',
    '🌙', '☀️', '⚡', '🏠', '🎵', '🎮',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.close),
        ),
        title: const Text('Yeni Kod'),
        actions: [
          TextButton(
            onPressed: _saveCode,
            child: const Text('Kaydet'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kod Adı
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cardPink,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kod Adı',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textOnPink,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _nameController,
                    style: TextStyle(color: AppColors.textOnPink),
                    decoration: const InputDecoration(
                      hintText: 'Örn: Günaydın',
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Emoji Seçimi
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cardPink,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Emoji Seç',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textOnPink,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: _emojis.map((emoji) {
                      final isSelected = emoji == _selectedEmoji;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedEmoji = emoji),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? AppColors.background 
                                : Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: isSelected
                                ? Border.all(color: AppColors.background, width: 2)
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              emoji,
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Pattern Önizleme
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cardPink,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Titreşim Paterni',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textOnPink,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Pattern Görselleştirme
                  SizedBox(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_pattern.length, (index) {
                        final isVibration = index % 2 == 0;
                        return Container(
                          width: 20,
                          height: isVibration ? _pattern[index] / 10 : 10,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: isVibration 
                                ? AppColors.background 
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Kontroller
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (_pattern.length > 1) {
                            setState(() {
                              _pattern.removeLast();
                              if (_pattern.isNotEmpty) _pattern.removeLast();
                            });
                          }
                        },
                        icon: Icon(
                          Icons.remove_circle_outline,
                          color: AppColors.textOnPink,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 24),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _pattern.addAll([100, 200]);
                          });
                        },
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: AppColors.textOnPink,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Test Butonu
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: _testVibration,
                      icon: const Icon(Icons.vibration),
                      label: const Text('Test Et'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.background,
                        foregroundColor: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _testVibration() {
    // Titreşim desenini servise gönder
    VibrationService.playPattern(_pattern);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('📳 Titreşim test ediliyor...')),
    );
  }

  void _saveCode() {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kod adı girin')),
      );
      return;
    }
    
    // TODO: Firestore'a kaydet
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$_selectedEmoji ${_nameController.text} kaydedildi!')),
    );
    context.pop();
  }
}
