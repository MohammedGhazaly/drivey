import 'package:flutter/material.dart';

class ColoredContainer extends StatelessWidget {
  final Color color;
  final Icon icon;
  final String option;
  final String titel;
  const ColoredContainer(
      {super.key,
      required this.color,
      required this.icon,
      required this.option,
      required this.titel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: icon,
      ),
    );
  }
}
