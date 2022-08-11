import 'package:flutter/material.dart';

class UiButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: 16.0),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
          overlayColor:
              MaterialStateProperty.all<Color>(Colors.black.withOpacity(0.08)),
          shadowColor:
              MaterialStateProperty.all<Color>(Colors.black.withOpacity(0.1)),
          padding:
              MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title ?? '',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
