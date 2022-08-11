import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:surf_practice_chat_flutter/features/auth/auth.dart';
import 'package:surf_practice_chat_flutter/features/chat/chat.dart';

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
  void _onUpdatePressed() {
    GetIt.I<ChatCubit>().getMessages();
  }

  void _onSendPressed(String messageText) {
    GetIt.I<ChatCubit>().sendMessage(messageText);
  }

  void _onOut() {
    GetIt.I<AuthCubit>().signOut();
    Navigator.pop(context);
  }

  @override
  void initState() {
    GetIt.I<ChatCubit>().chatRepository(widget.chatRepository);
    _onUpdatePressed();

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircularBtn(
                    icons: Icons.output,
                    onTap: () => _onOut(),
                  ),
                  CircularBtn(
                    icons: Icons.refresh,
                    onTap: () => _onUpdatePressed(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
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
      onTap: () => onTap(),
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
