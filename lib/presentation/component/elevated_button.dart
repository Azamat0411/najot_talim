import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton({
    super.key,
    this.radius,
    this.height,
    this.primaryColor,
    this.width,
    required this.child,
    this.onTap,
  });

  final double? width, height, radius;
  final Color? primaryColor;
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
        fixedSize: Size(
          width ?? 0,
          height ?? 48,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 12),
        ),
      ),
      onPressed: onTap,
      child: child,
    );
  }
}
