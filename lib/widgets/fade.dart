import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;
  final String direction;

  FadeAnimation(this.delay, this.direction, this.child);

  @override
  Widget build(BuildContext context) {
    switch (direction) {
      case 'up':
        final tween = MultiTrackTween([
          Track("opacity")
              .add(Duration(milliseconds: 400), Tween(begin: 0.0, end: 1.0)),
          Track("translateY").add(
              Duration(milliseconds: 400), Tween(begin: -20.0, end: 0.0),
              curve: Curves.easeOut)
        ]);
        return ControlledAnimation(
          delay: Duration(milliseconds: (500 * delay).round()),
          duration: tween.duration,
          tween: tween,
          child: child,
          builderWithChild: (context, child, animation) => Opacity(
            opacity: animation["opacity"],
            child: Transform.translate(
                offset: Offset(0, animation["translateY"]), child: child),
          ),
        );
        break;
      case 'right':
        final tween = MultiTrackTween([
          Track("opacity")
              .add(Duration(milliseconds: 400), Tween(begin: 0.0, end: 1.0)),
          Track("translateX").add(
              Duration(milliseconds: 400), Tween(begin: 10.0, end: 0.0),
              curve: Curves.easeOut)
        ]);
        return ControlledAnimation(
          delay: Duration(milliseconds: (500 * delay).round()),
          duration: tween.duration,
          tween: tween,
          child: child,
          builderWithChild: (context, child, animation) => Opacity(
            opacity: animation["opacity"],
            child: Transform.translate(
                offset: Offset(animation["translateX"], 0), child: child),
          ),
        );
        break;
      case 'fadeIn':
        final tween = MultiTrackTween([
          Track("opacity")
              .add(Duration(milliseconds: 400), Tween(begin: 0.0, end: 1.0)),
        ]);
        return ControlledAnimation(
          delay: Duration(milliseconds: (500 * delay).round()),
          duration: tween.duration,
          tween: tween,
          child: child,
          builderWithChild: (context, child, animation) =>
              Opacity(opacity: animation["opacity"], child: child),
        );
        break;
    }
  }
}
