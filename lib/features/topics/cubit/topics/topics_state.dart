part of 'topics_cubit.dart';

@freezed
class TopicsState with _$TopicsState {
  const factory TopicsState({
    @Default(false) bool isLoading,
    ChatTopicsRepository? chatTopicsRepository,
    @Default(<ChatTopicDto>[]) Iterable<ChatTopicDto> chats,
    int? idActive,
    @Default('Incognito user') String userName,
  }) = _TopicsState;
}
