import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/vibration_patterns.dart';

/// Hızlı Kod Grid - 6 Buton (3x2)
class QuickCodeGrid extends StatelessWidget {
  final List<VibrationCode> codes;
  final Function(VibrationCode) onCodeTap;

  const QuickCodeGrid({
    super.key,
    required this.codes,
    required this.onCodeTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.0,
      ),
      itemCount: codes.length > 6 ? 6 : codes.length,
      itemBuilder: (context, index) {
        return QuickCodeButton(
          code: codes[index],
          onTap: () => onCodeTap(codes[index]),
        );
      },
    );
  }
}

/// Tek Hızlı Kod Butonu
class QuickCodeButton extends StatefulWidget {
  final VibrationCode code;
  final VoidCallback onTap;

  const QuickCodeButton({
    super.key,
    required this.code,
    required this.onTap,
  });

  @override
  State<QuickCodeButton> createState() => _QuickCodeButtonState();
}

class _QuickCodeButtonState extends State<QuickCodeButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: Matrix4.identity()..scale(_isPressed ? 0.95 : 1.0),
        decoration: BoxDecoration(
          color: widget.code.color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: widget.code.color.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Emoji
            Text(
              widget.code.emoji,
              style: const TextStyle(fontSize: 36),
            ).animate(
              onPlay: (controller) {
                if (_isPressed) {
                  controller.forward();
                }
              },
            ).shake(
              hz: 4,
              duration: const Duration(milliseconds: 300),
            ),
            
            const SizedBox(height: 8),
            
            // Kod Adı
            Text(
              widget.code.name,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.textOnPink,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
