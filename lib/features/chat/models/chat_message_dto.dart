import 'package:surf_practice_chat_flutter/features/chat/models/chat_user_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_user_local_dto.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

class ChatMessageDto {
  const ChatMessageDto({
    required this.chatUserDto,
    required this.message,
    required this.createdDateTime,
  });

  ChatMessageDto.fromSJClient({
    required SjMessageDto sjMessageDto,
    required SjUserDto sjUserDto,
    required bool isUserLocal,
  })  : chatUserDto = isUserLocal
            ? ChatUserLocalDto.fromSJClient(sjUserDto)
            : ChatUserDto.fromSJClient(sjUserDto),
        message = sjMessageDto.text,
        createdDateTime = sjMessageDto.created;

  final ChatUserDto chatUserDto;
  final String? message;
  final DateTime createdDateTime;

  @override
  String toString() =>
      // ignore: lines_longer_than_80_chars
      'ChatMessageDto(chatUserDto: $chatUserDto, message: $message, createdDate: $createdDateTime)';
}
