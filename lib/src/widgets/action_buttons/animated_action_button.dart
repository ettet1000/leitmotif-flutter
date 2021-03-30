import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// An action button which will be animated.
///
/// It will flown in the visible area using an [AnimatedBuilder]. The button's
/// functionality can be defined by the [onPressed] method.
class AnimatedActionButton extends StatefulWidget
    implements CustomActionButton {
  final Alignment alignment;
  final Widget child;
  final Color backgroundColor;
  final void Function() onPressed;
  final EdgeInsets padding;

  /// Creates an [AnimatedActionButton] [Widget].

  const AnimatedActionButton({
    Key? key,
    required this.alignment,
    required this.child,
    required this.backgroundColor,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(
      vertical: 16.0,
      horizontal: 30.0,
    ),
  }) : super(key: key);
  @override
  _AnimatedActionButtonState createState() => _AnimatedActionButtonState();
}

class _AnimatedActionButtonState extends State<AnimatedActionButton>
    with TickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 250),
      vsync: this,
    );
    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (BuildContext context, Widget? child) {
        return Align(
          alignment: widget.alignment,
          child: FadeInTransformScaleContainer(
            animationController: _animationController,
            transform: Matrix4.translationValues(
                0, 50 * (1 - _animationController!.value), 0),
            scale: 0.25 + (_animationController!.value * 0.75),
            child: Padding(
                padding: widget.padding,
                child: LitTransformAnimatedButton(
                  verticalTransform: 15.0,
                  horizontalTransform: 0.0,
                  child: widget.child,
                  backgroundColor: widget.backgroundColor,
                  onTap: widget.onPressed,
                )),
          ),
        );
      },
    );
  }
}
