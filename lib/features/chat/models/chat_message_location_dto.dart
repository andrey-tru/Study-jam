import 'package:surf_practice_chat_flutter/features/chat/models/chat_geolocation_geolocation_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_user_dto.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

class ChatMessageGeolocationDto extends ChatMessageDto {
  ChatMessageGeolocationDto({
    required super.chatUserDto,
    required this.location,
    required String super.message,
    required DateTime createdDate,
  }) : super(
          createdDateTime: createdDate,
        );

  ChatMessageGeolocationDto.fromSJClient({
    required SjMessageDto sjMessageDto,
    required SjUserDto sjUserDto,
  })  : location = ChatGeolocationDto.fromGeoPoint(sjMessageDto.geopoint!),
        super(
          createdDateTime: sjMessageDto.created,
          message: sjMessageDto.text,
          chatUserDto: ChatUserDto.fromSJClient(sjUserDto),
        );

  final ChatGeolocationDto location;

  @override
  String toString() =>
      // ignore: lines_longer_than_80_chars
      'ChatMessageGeolocationDto(location: $location) extends ${super.toString()}';
}
