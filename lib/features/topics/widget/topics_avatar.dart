import 'dart:math';

import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/features/topics/topics.dart';

class TopicsAvatar extends StatelessWidget {
  const TopicsAvatar({required this.chat});

  final ChatTopicDto chat;

  @override
  Widget build(BuildContext context) {
    const double size = 42;
    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.only(right: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.black87),
        color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      ),
      child: Center(
        child: Text(
          chat.name == null
              ? 'Incognito chat'
              : chat.name!.split(' ').last[0] == '"'
                  ? chat.name!.split(' ').last[1]
                  : chat.name!.split(' ').last[0],
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
