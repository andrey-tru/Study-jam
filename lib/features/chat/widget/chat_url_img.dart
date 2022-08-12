import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/features/widgets/widgets.dart';

class ChatUrlImg extends StatelessWidget {
  const ChatUrlImg({
    super.key,
    required this.textEditingController,
    required this.onPressedBtn,
  });

  final TextEditingController textEditingController;
  final VoidCallback onPressedBtn;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.black87,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 5.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            Text(
              tr('chat.urlImg'),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: tr('chat.url'),
                hintStyle: const TextStyle(color: Colors.white),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 30),
            UiButton(
              title: tr('chat.insert'),
              onPressed: onPressedBtn,
            ),
          ],
        ),
      ),
    );
  }
}
