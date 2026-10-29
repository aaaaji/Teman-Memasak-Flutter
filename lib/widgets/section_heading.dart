import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    required this.title,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.ink,
              fontSize: 19,
              fontWeight: FontWeight.w900,
              letterSpacing: -.25,
            ),
          ),
        ),
        if (actionLabel != null && onAction != null)
          TextButton(
            onPressed: onAction,
            child: Text(actionLabel!,
                style: const TextStyle(
                  color: AppColors.navy,
                  fontWeight: FontWeight.w700,
                )),
          ),
      ],
    );
  }
}
