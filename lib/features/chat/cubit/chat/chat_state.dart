part of 'chat_cubit.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState({
    @Default(false) bool isLoading,
    IChatRepository? chatRepository,
    @Default(<ChatMessageDto>[]) Iterable<ChatMessageDto> messages,
    ChatGeolocationDto? location,
    @Default(<String, dynamic>{}) Map<String, dynamic> userColor,
    String? urlImg,
    @Default('Incognito user') String userName,
  }) = _ChatState;
}
