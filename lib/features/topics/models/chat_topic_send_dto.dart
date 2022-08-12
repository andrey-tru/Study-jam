import 'package:surf_practice_chat_flutter/features/topics/topics.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

/// Data transfer object representing simple chat topic.
///
/// Is different from [ChatTopicDto], because it does not contain id.
/// This chat's topic is not yet created in API, & that's why there's
/// no id.
class ChatTopicSendDto {
  const ChatTopicSendDto({
    this.name,
    this.description,
  });

  SjChatSendsDto toSjChatSendsDto() => SjChatSendsDto(
        name: name,
        description: description,
      );

  final String? name;
  final String? description;

  @override
  String toString() =>
      'ChatTopicSendDto(name: $name, description: $description)';
}
