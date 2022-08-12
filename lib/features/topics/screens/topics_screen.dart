import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:surf_practice_chat_flutter/features/auth/auth.dart';
import 'package:surf_practice_chat_flutter/features/chat/cubit/cubit.dart';
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

  void _onOut() {
    GetIt.I<AuthCubit>().signOut();
    Navigator.pop(context);
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
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 70.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        state.userName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      IconButton(
                        onPressed: _onOut,
                        icon: const Icon(
                          Icons.output,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const CreateTopicScreen(),
                  const SizedBox(height: 20.0),
                  ...state.chats.map(
                    (ChatTopicDto chat) => GestureDetector(
                      onTap: () {
                        GetIt.I<ChatCubit>().getMessages(chat.id);
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: chat.id == state.idActive
                              ? Colors.green
                              : Colors.green[900],
                        ),
                        child: Row(
                          children: <Widget>[
                            TopicsAvatar(
                              chat: chat,
                            ),
                            Text(
                              chat.name ?? 'Incognito chat',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
