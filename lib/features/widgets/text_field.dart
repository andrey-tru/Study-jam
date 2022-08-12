import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class UiTextField extends StatelessWidget {
  const UiTextField({
    super.key,
    this.formControlName,
    this.margin,
    this.padding,
    this.obscureText = false,
    this.hintText,
    this.keyboardType,
    this.textInputAction,
  });

  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final String? formControlName;
  final bool obscureText;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.zero,
      margin: margin ?? const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      child: ReactiveTextField<String>(
        keyboardType: keyboardType,
        formControlName: formControlName,
        obscureText: obscureText,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          isDense: true,
          isCollapsed: true,
          hintStyle: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hintText,
        ),
        showErrors: (AbstractControl<dynamic> control) => false,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
