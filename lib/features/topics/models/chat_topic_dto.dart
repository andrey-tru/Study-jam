import 'package:surf_practice_chat_flutter/features/topics/topics.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

/// Data transfer object representing simple chat topic.
///
/// Is different from [ChatTopicSendDto], because it does contain id.
/// This topic has already been created in API.
class ChatTopicDto {
  const ChatTopicDto({
    required this.id,
    this.name,
    this.description,
  });

  ChatTopicDto.fromSJClient({
    required SjChatDto sjChatDto,
  })  : id = sjChatDto.id,
        name = sjChatDto.name,
        description = sjChatDto.description;

  final int id;
  final String? name;
  final String? description;

  @override
  String toString() =>
      'ChatTopicDto(id: $id, name: $name, description: $description)';
}
