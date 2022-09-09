import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:magic_8_ball/components/shadow_of_doubt.dart';
import 'package:magic_8_ball/components/sphere_of_destiny.dart';
import 'package:magic_8_ball/components/text_eight.dart';
import 'package:magic_8_ball/components/window_of_opportunity.dart';

class Magic8Ball extends StatefulWidget {
  const Magic8Ball({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _Magic8BallState createState() => _Magic8BallState();
}

class _Magic8BallState extends State<Magic8Ball>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  double wobble = 0.0;
  @override
  void initState() {
    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 1500));
    controller.addListener(() => setState);
    animation = CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
        reverseCurve: Curves.elasticIn);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _start(Offset offset, Size size) {
    controller.forward(from: 0);
    _update(offset, size);
  }

  void _update(Offset position, Size size) {
    Offset currentPosition = Offset((2 * position.dx / size.width) - 1,
        (2 * position.dy / size.height) - 1);
    if (tapPosition.distance > 0.85) {
      tapPosition = Offset.fromDirection(tapPosition.direction, 0.85);
    }
    setState(() {
      tapPosition = currentPosition;
    });
  }

  void _end() {
    final rand = math.Random();
    wobble = rand.nextDouble() * (wobble.isNegative ? 0.5 : -0.5);
    controller.reverse(from: 1);
  }

  static const lightSource = Offset(0, -0.75);

  String prediction = 'The MAGIC\n8-Ball';
  static const restPosition = Offset(0, -0.15);
  Offset tapPosition = Offset.zero;
  @override
  Widget build(BuildContext context) {
    final windowPosition =
        Offset.lerp(restPosition, tapPosition, animation.value)!;

    final size = Size.square(MediaQuery.of(context).size.shortestSide);
    return Stack(
      children: [
        ShadowOfDoubt(
          diameter: size.shortestSide,
        ),
        GestureDetector(
          onPanStart: (details) => _start(details.localPosition, size),
          onPanUpdate: (details) => _update(details.localPosition, size),
          onPanEnd: (_) => _end(),
          child: SphereOfDestiny(
            lightSource: lightSource,
            diameter: size.shortestSide,
            child: Transform(
              origin: size.center(Offset.zero),
              transform: Matrix4.identity()
                ..translate(windowPosition.dx * size.width / 2,
                    windowPosition.dy * size.height / 2)
                ..rotateZ(windowPosition.direction)
                ..rotateY(windowPosition.distance * math.pi / 2)
                ..rotateZ(-windowPosition.direction)
                ..scale(0.5 - 0.15 * windowPosition.distance),
              child: WindowOfOpportunity(
                lightSource: lightSource - windowPosition,
                child: Opacity(
                  opacity: 1 - controller.value, // fading out when moving
                  child: Transform.rotate(
                    angle: wobble,
                    child: const TextEight(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
