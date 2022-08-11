import 'package:surf_study_jam/surf_study_jam.dart';

class ChatUserDto {
  const ChatUserDto({
    required this.name,
  });

  ChatUserDto.fromSJClient(SjUserDto sjUserDto) : name = sjUserDto.username;

  final String? name;

  @override
  String toString() => 'ChatUserDto(name: $name)';
}
