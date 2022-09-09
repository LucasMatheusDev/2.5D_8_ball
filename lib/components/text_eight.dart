import 'package:flutter/material.dart';

class TextEight extends StatelessWidget {
  const TextEight({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        fit: BoxFit.cover,
        child: Text(
          "8",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.height * 0.9,
          ),
        ),
      ),
    );
  }
}
