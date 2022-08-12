import 'package:flutter/material.dart';

class UiLoader extends StatelessWidget {
  const UiLoader({super.key, this.value, this.color});

  final double? value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        value: value,
        backgroundColor: Colors.white,
        valueColor: const AlwaysStoppedAnimation<Color?>(
          Colors.green,
        ),
      ),
    );
  }
}
