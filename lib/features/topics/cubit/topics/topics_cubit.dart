import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:surf_practice_chat_flutter/features/auth/auth.dart';
import 'package:surf_practice_chat_flutter/features/topics/topics.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

part 'topics_state.dart';
part 'topics_cubit.freezed.dart';

@singleton
class TopicsCubit extends Cubit<TopicsState> {
  TopicsCubit() : super(const TopicsState());

  Future<void> getTopics() async {
    emit(state.copyWith(isLoading: true));

    final ChatTopicsRepository chatTopicsRepository = ChatTopicsRepository(
      StudyJamClient().getAuthorizedClient(GetIt.I<AuthCubit>().state.token!),
    );

    final Iterable<ChatTopicDto> topics = await chatTopicsRepository.getTopics(
      topicsStartDate: DateTime.now().subtract(const Duration(days: 7)),
    );

    emit(
      state.copyWith(
        chatTopicsRepository: chatTopicsRepository,
        chats: topics,
        isLoading: false,
      ),
    );
  }
}
