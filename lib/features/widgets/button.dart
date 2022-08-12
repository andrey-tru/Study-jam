import 'package:flutter/material.dart';

class UiButton extends StatefulWidget {
  const UiButton({
    super.key,
    this.margin,
    this.padding,
    this.onPressed,
    this.title,
  });

  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;
  final String? title;

  @override
  State<UiButton> createState() => _UiButtonState();
}

class _UiButtonState extends State<UiButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );

  late Animation<Color?> animation;

  @override
  void initState() {
    controller.repeat(reverse: true);
    animation = ColorTween(begin: Colors.yellow[700], end: Colors.green[900])
        .animate(controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Container(
          margin: widget.margin ?? const EdgeInsets.only(bottom: 16.0),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              backgroundColor:
                  MaterialStateProperty.all<Color>(animation.value!),
              overlayColor: MaterialStateProperty.all<Color>(
                Colors.black.withOpacity(0.08),
              ),
              shadowColor: MaterialStateProperty.all<Color>(
                Colors.black.withOpacity(0.1),
              ),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.zero,
              ),
            ),
            onPressed: widget.onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.title ?? '',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
