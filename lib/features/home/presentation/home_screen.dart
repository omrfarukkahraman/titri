import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vibration/vibration.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/vibration_patterns.dart';
import '../../../core/services/vibration_service.dart';
import 'widgets/active_user_card.dart';
import 'widgets/quick_code_grid.dart';
import 'widgets/daily_routine_card.dart';

/// Ana Ekran - Mockup'a birebir uygun
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Aktif kullanıcı (şimdilik mock data)
  String? activeUserName = 'Aktif Kişi';
  String? activeUserAvatar = '😊';
  bool isOnline = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            
            // Aktif Kişi Kartı
            if (activeUserName != null)
              ActiveUserCard(
                name: activeUserName!,
                avatar: activeUserAvatar ?? '😊',
                isOnline: isOnline,
                onRemove: () {
                  setState(() {
                    activeUserName = null;
                  });
                },
              ),
            
            const SizedBox(height: 24),
            
            // Hızlı Kodlar Başlık
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.quickCodes,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                TextButton(
                  onPressed: () => context.pushNamed('createCode'),
                  child: const Text(
                    AppStrings.addNew,
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Hızlı Kod Grid (6 Buton)
            QuickCodeGrid(
              codes: DefaultVibrationCodes.codes,
              onCodeTap: _handleCodeTap,
            ),
            
            const SizedBox(height: 24),
            
            // Günlük Rutin Kartı
            const DailyRoutineCard(),
            
            const SizedBox(height: 100), // Bottom nav için boşluk
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        AppStrings.appName,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        // Simülasyon Butonu (Demo İçin)
        IconButton(
          onPressed: () => context.pushNamed('testing'),
          tooltip: 'Ar-Ge Testi Başlat',
          icon: const Icon(
            Icons.science_rounded,
            color: AppColors.info,
          ),
        ),
        IconButton(
          onPressed: _simulateIncomingMessage,
          tooltip: 'Gelen Mesajı Simüle Et',
          icon: const Icon(
            Icons.phonelink_ring_rounded,
            color: AppColors.secondary,
          ),
        ),

        IconButton(
          onPressed: () {
            // TODO: Ayarlar
          },
          icon: const Icon(
            Icons.settings_rounded,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Future<void> _handleCodeTap(VibrationCode code) async {
    // Titreşim çal (Service üzerinden)
    await VibrationService.playPattern(code.pattern);
    
    // Feedback göster
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${code.emoji} ${code.name} gönderildi!'),
          duration: const Duration(milliseconds: 800),
        ),
      );
    }
  }

  void _simulateIncomingMessage() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Senaryo Seç (Demo)',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            
            // 1. Engelsiz Yaşam (Navigasyon/Uyarı)
            _buildScenarioItem(
              icon: Icons.blind_rounded,
              color: AppColors.info,
              title: 'Engelsiz Yaşam: Navigasyon',
              subtitle: 'Titri: "Sağa Dön" komutu (2 Kısa)',
              pattern: [0, 200, 100, 200],
              message: 'Navigasyon: Sağa dönün ➡️',
            ),
            
            // 2. Aşk (Kalp Atışı)
            _buildScenarioItem(
              icon: Icons.favorite_rounded,
              color: AppColors.primary,
              title: 'Sosyal: Aşk',
              subtitle: 'Titri: Kalp Ritmi (Güm Güm)',
              pattern: [0, 100, 100, 100, 100, 200], // Basit kalp ritmi
              message: '❤️ Ahmet sana kalp gönderdi!',
            ),
            
            // 3. SOS (Acil Durum)
            _buildScenarioItem(
              icon: Icons.sos_rounded,
              color: AppColors.error,
              title: 'Güvenlik: SOS',
              subtitle: 'Titri: Tehlike! (Sürekli Titreşim)',
              pattern: [0, 500, 100, 500, 100, 500],
              message: '🚨 ACİL DURUM: Ayşe yardım istiyor!',
            ),
            
            // 4. Aile (Eve Geldim)
            _buildScenarioItem(
              icon: Icons.home_rounded,
              color: AppColors.success,
              title: 'Aile: Haberleşme',
              subtitle: 'Titri: "Eve Geldim" (3 Kısa)',
              pattern: [0, 100, 50, 100, 50, 100],
              message: '🏠 Baba: Eve geldim.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScenarioItem({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required List<int> pattern,
    required String message,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(title, style: const TextStyle(color: AppColors.textPrimary)),
      subtitle: Text(subtitle, style: const TextStyle(color: AppColors.textSecondary)),
      onTap: () {
        Navigator.pop(context); // Menüyü kapat
        _playSimulation(pattern, message, color, icon);
      },
    );
  }

  void _playSimulation(List<int> pattern, String message, Color color, IconData icon) {
    // 1. Titreşimi Başlat
    VibrationService.playPattern(pattern);
    
    // 2. Görsel Bildirim (Dialog)
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: color, width: 2),
        ),
        title: Row(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(width: 10),
            const Text('Gelen Mesaj', style: TextStyle(color: Colors.white)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              '(Telefon Titriyor...)',
              style: TextStyle(color: Colors.white54, fontStyle: FontStyle.italic),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Tamam', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
