import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:surf_practice_chat_flutter/features/chat/chat.dart';
import 'package:surf_practice_chat_flutter/features/utils/utils.dart';

class ChatTextField extends StatelessWidget {
  ChatTextField({required this.onSendPressed});

  final ValueChanged<String> onSendPressed;

  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _textUrlEditingController =
      TextEditingController();

  void onPressedBtn() {
    GetIt.I<ChatCubit>().urlImg(_textUrlEditingController.text);
    Navigator.pop(
      GetIt.I<NavigationService>().navigatorKey.currentState!.context,
    );
    _textUrlEditingController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<ChatCubit, ChatState>(
      bloc: GetIt.I<ChatCubit>(),
      builder: (BuildContext context, ChatState state) {
        return ColoredBox(
          color: Colors.black87,
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if (state.location == null) {
                    GetIt.I<ChatCubit>().sendGeoMessage();
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      state.location == null
                          ? tr('chat.addGeo')
                          : tr('chat.doneGeo'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  children: <Widget>[
                    if (state.urlImg == null)
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet<void>(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext context) {
                              return ChatUrlImg(
                                textEditingController:
                                    _textUrlEditingController,
                                onPressedBtn: onPressedBtn,
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.image,
                          color: Colors.green,
                        ),
                        color: colorScheme.onSurface,
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Image.network(
                          state.urlImg!,
                          width: 30.0,
                        ),
                      ),
                    Expanded(
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: _textEditingController,
                        decoration: InputDecoration(
                          hintText: tr('chat.message'),
                          hintStyle: const TextStyle(color: Colors.white),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        onSendPressed(_textEditingController.text);
                        _textEditingController.text = '';
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.green,
                      ),
                      color: colorScheme.onSurface,
                    ),
                  ],
                ),
              ),
              if (state.location != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      // ignore: lines_longer_than_80_chars
                      '${state.location!.latitude} : ${state.location!.longitude}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              SizedBox(height: mediaQuery.padding.bottom + 8)
            ],
          ),
        );
      },
    );
  }
}
