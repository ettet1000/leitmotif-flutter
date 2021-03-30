import 'dart:ui';

import 'package:flutter/material.dart';

class BluredBackgroundContainer extends StatelessWidget {
  final Widget child;
  final double blurRadius;
  final BorderRadius? borderRadius;

  /// Creates a [BluredBackgroundContainer] [Widget].
  ///
  /// It blurs the provided [child] by applying an [ImageFilter].
  /// The [blurRadius] will control the blur effect.
  const BluredBackgroundContainer({
    Key? key,
    required this.child,
    required this.blurRadius,
    this.borderRadius,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurRadius, sigmaY: blurRadius),
        child: child,
      ),
    );
  }
}
