import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:surf_practice_chat_flutter/features/topics/topics.dart';
import 'package:surf_practice_chat_flutter/features/widgets/widgets.dart';

class TopicsScreen extends StatefulWidget {
  const TopicsScreen({super.key});

  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  @override
  void initState() {
    GetIt.I<TopicsCubit>().getTopics();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black87,
      child: BlocBuilder<TopicsCubit, TopicsState>(
        bloc: GetIt.I<TopicsCubit>(),
        builder: (BuildContext context, TopicsState state) {
          if (state.isLoading) {
            return const UiLoader();
          }
          return Column(
            children: <Widget>[
              ...state.chats.map(
                (ChatTopicDto chat) => Text(
                  chat.name!,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
