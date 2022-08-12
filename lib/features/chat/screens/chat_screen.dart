import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:surf_practice_chat_flutter/features/chat/chat.dart';
import 'package:surf_practice_chat_flutter/features/topics/topics.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    required this.chatRepository,
    super.key,
  });

  final IChatRepository chatRepository;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void _onSendPressed(String messageText) {
    GetIt.I<ChatCubit>().sendMessage(messageText);
  }

  @override
  void initState() {
    GetIt.I<ChatCubit>().chatRepository(widget.chatRepository);

    GetIt.I<ChatCubit>().getMessages();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: Colors.green[900]!,
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Expanded(child: ChatBody()),
                ChatTextField(onSendPressed: _onSendPressed),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 70.0),
              child: Builder(
                builder: (BuildContext context) => CircularBtn(
                  icons: Icons.menu,
                  onTap: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            )
          ],
        ),
      ),
      drawer: const TopicsScreen(),
    );
  }
}

class CircularBtn extends StatelessWidget {
  const CircularBtn({super.key, required this.icons, required this.onTap});

  final IconData icons;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const double size = 70.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.green,
        ),
        child: Icon(
          icons,
          color: Colors.white,
        ),
      ),
    );
  }
}
