import 'package:flutter/material.dart';

class GeneralButton extends StatelessWidget {
  /// Text inside the button
  final String text;

  /// Called when user tap the button
  final VoidCallback? onTap;

  /// border radius of the button
  final double borderRadius;

  /// Background color of the button
  final Color color;

  const GeneralButton({
    this.borderRadius = 24,
    required this.text,
    this.onTap,
    this.color = Colors.pink,
    Key? key,
  }) : super(key: key);

  double get height => 48;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: color,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 4),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
