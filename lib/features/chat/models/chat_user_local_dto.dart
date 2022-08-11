import 'package:surf_practice_chat_flutter/features/chat/models/chat_user_dto.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

class ChatUserLocalDto extends ChatUserDto {
  ChatUserLocalDto({
    required String name,
  }) : super(name: name);

  ChatUserLocalDto.fromSJClient(SjUserDto sjUserDto)
      : super(name: sjUserDto.username);

  @override
  String toString() => 'ChatUserLocalDto(name: $name)';
}
