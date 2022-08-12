import 'package:flutter/material.dart';

class AnimationText extends StatefulWidget {
  const AnimationText({super.key});

  @override
  State<AnimationText> createState() => _AnimationTextState();
}

class _AnimationTextState extends State<AnimationText>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );

  late Animation<Color?> animation;
  final String homeText = 'Study Jam';

  @override
  void initState() {
    controller.repeat(reverse: true);
    animation = ColorTween(begin: Colors.green[900], end: Colors.yellow[700])
        .animate(controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Text(
          homeText,
          style: TextStyle(
            fontSize: 70,
            color: animation.value,
          ),
        );
      },
    );
  }
}
