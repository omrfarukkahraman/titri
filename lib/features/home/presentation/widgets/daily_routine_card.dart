import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';

/// Günlük Rutin Kartı - Sabah, Kahve, Gece
class DailyRoutineCard extends StatelessWidget {
  const DailyRoutineCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardPink,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık
          Text(
            AppStrings.dailyRoutine,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.textOnPink,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Rutin Chip'leri
          Row(
            children: [
              _buildRoutineChip(
                context,
                emoji: '☀️',
                label: AppStrings.morning,
                isCompleted: true,  // TODO: Firestore'dan
              ),
              const SizedBox(width: 12),
              _buildRoutineChip(
                context,
                emoji: '☕',
                label: AppStrings.afternoon,
                isCompleted: true,
              ),
              const SizedBox(width: 12),
              _buildRoutineChip(
                context,
                emoji: '🌙',
                label: AppStrings.evening,
                isCompleted: false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoutineChip(
    BuildContext context, {
    required String emoji,
    required String label,
    required bool isCompleted,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isCompleted 
            ? AppColors.background 
            : AppColors.background.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: isCompleted 
            ? null 
            : Border.all(
                color: AppColors.textOnPink.withOpacity(0.3),
                width: 1,
              ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: isCompleted ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
