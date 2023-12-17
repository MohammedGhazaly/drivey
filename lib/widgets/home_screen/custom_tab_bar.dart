import 'package:drivey_files/core/utils/app_colors.dart';
import 'package:drivey_files/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final String text;
  final bool isSelected;
  const CustomTabBar({super.key, required this.text, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isSelected ? Colors.deepOrangeAccent : Colors.transparent,
        // color: Colors.transparent,
      ),
      child: Center(
          child: Text(
        text,
        style: AppStyles.textStyle(
          fontSize: 14,
          color: isSelected ? Colors.white : AppColors.textColor,
          fontWeight: FontWeight.bold,
        ),
      )),
    );
  }
}
