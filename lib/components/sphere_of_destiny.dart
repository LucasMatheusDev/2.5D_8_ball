import 'package:flutter/material.dart';

class SphereOfDestiny extends StatelessWidget {
  const SphereOfDestiny({
    required this.diameter,
    required this.lightSource,
    required this.child,
    Key? key,
  }) : super(key: key);

  final double diameter;
  final Offset lightSource;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            center: Alignment(lightSource.dx, lightSource.dy),
            colors: const [Colors.grey, Colors.black],
          ),
        ),
        child:  child,
      ),
    );
  }
}
