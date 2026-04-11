import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';

/// Aktif Kullanıcı Kartı - Mockup'a uygun
class ActiveUserCard extends StatelessWidget {
  final String name;
  final String avatar;
  final bool isOnline;
  final VoidCallback onRemove;

  const ActiveUserCard({
    super.key,
    required this.name,
    required this.avatar,
    required this.isOnline,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardPink,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                avatar,
                style: const TextStyle(fontSize: 28),
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // İsim ve Durum
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textOnPink,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isOnline ? AppColors.online : AppColors.offline,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      isOnline ? AppStrings.online : AppStrings.offline,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textOnPink.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Kaldır Butonu
          IconButton(
            onPressed: onRemove,
            icon: Icon(
              Icons.close_rounded,
              color: AppColors.textOnPink.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
