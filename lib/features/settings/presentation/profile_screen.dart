import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

/// Profil Ekranı
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.profile),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Avatar
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.cardPink,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  '😊',
                  style: TextStyle(fontSize: 48),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // İsim
            Text(
              'Kullanıcı Adı',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            
            const SizedBox(height: 4),
            
            Text(
              'user@example.com',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Ayarlar Listesi
            _buildSettingsTile(
              context,
              icon: Icons.person_outline,
              title: 'Profili Düzenle',
              onTap: () {},
            ),
            _buildSettingsTile(
              context,
              icon: Icons.notifications_outlined,
              title: AppStrings.notifications,
              onTap: () {},
            ),
            _buildSettingsTile(
              context,
              icon: Icons.vibration,
              title: AppStrings.vibration,
              onTap: () {},
            ),
            _buildSettingsTile(
              context,
              icon: Icons.accessibility_new,
              title: AppStrings.accessibility,
              onTap: () {},
            ),
            
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            
            _buildSettingsTile(
              context,
              icon: Icons.logout,
              title: AppStrings.logout,
              onTap: () {
                context.goNamed('login');
              },
              isDestructive: false,
            ),
            _buildSettingsTile(
              context,
              icon: Icons.delete_outline,
              title: AppStrings.deleteAccount,
              onTap: () {},
              isDestructive: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? AppColors.error : AppColors.primary,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? AppColors.error : AppColors.textPrimary,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: AppColors.textSecondary,
      ),
      onTap: onTap,
    );
  }
}
