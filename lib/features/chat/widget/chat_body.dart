import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:surf_practice_chat_flutter/features/chat/chat.dart';
import 'package:surf_practice_chat_flutter/features/widgets/widgets.dart';

class ChatBody extends StatefulWidget {
  const ChatBody({super.key});

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  static final ScrollController _controller = ScrollController();
  String _progress = '0%';

  @override
  void initState() {
    _controller.addListener(() {
      if (_controller.offset <= -100) {
        GetIt.I<ChatCubit>().getMessages();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      bloc: GetIt.I<ChatCubit>(),
      builder: (BuildContext context, ChatState state) {
        if (state.isLoading) {
          _progress = '0%';
          return const UiLoader();
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            if (_controller.offset <= 0) {
              setState(() {
                _progress = '${(_controller.offset).toStringAsFixed(0)}%';
              });
            }
            return true;
          },
          child: Stack(
            children: <Widget>[
              ListView.builder(
                controller: _controller,
                padding: EdgeInsets.zero,
                reverse: true,
                itemCount: state.messages.length,
                itemBuilder: (_, int index) {
                  return _ChatMessage(
                    userName: state.userName,
                    chatData: state.messages
                        .elementAt(state.messages.length - 1 - index),
                  );
                },
              ),
              if (_progress != '0%')
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    _progress,
                    style: const TextStyle(color: Colors.white),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}

class _ChatMessage extends StatelessWidget {
  const _ChatMessage({required this.userName, required this.chatData});

  final String userName;
  final ChatMessageDto chatData;

  Future<void> _openMap(ChatMessageGeolocationDto message) async {
    final List<AvailableMap> availableMaps = await MapLauncher.installedMaps;

    await availableMaps.first.showMarker(
      coords: Coords(message.location.latitude, message.location.longitude),
      title: message.chatUserDto.name ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    ChatMessageGeolocationDto? message;

    if (chatData is ChatMessageGeolocationDto) {
      message = chatData as ChatMessageGeolocationDto;
    }

    final HtmlUnescape unescape = HtmlUnescape();
    final RegExp urlRegExp = RegExp(
      r'((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?',
    );
    final Iterable<RegExpMatch> urlMatches =
        urlRegExp.allMatches(unescape.convert(chatData.message ?? ''));
    final List<String> urls = urlMatches
        .map(
          (RegExpMatch urlMatch) => unescape
              .convert(chatData.message ?? '')
              .substring(urlMatch.start, urlMatch.end),
        )
        .toList();

    return Container(
      width: MediaQuery.of(context).size.width * .8,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (chatData.chatUserDto.name != userName)
            _ChatAvatar(
              userData: chatData.chatUserDto.name ?? 'Incognito user',
            ),
          if (chatData.chatUserDto.name != userName) const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.black87,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    chatData.chatUserDto.name ?? 'Incognito user',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: chatData.chatUserDto.name == null
                          ? Colors.green
                          : Colors.primaries[int.parse(
                              GetIt.I<ChatCubit>()
                                  .state
                                  .userColor[chatData.chatUserDto.name]!
                                  .toString(),
                            )],
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (chatData is ChatMessageGeolocationDto)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if (message!.message != '')
                          Text(
                            '${message.message}',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        GestureDetector(
                          onTap: () => _openMap(message!),
                          child: const Text(
                            'Tap for open map',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    Text(
                      chatData.message ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  if (urls.isNotEmpty)
                    for (final String url in urls)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Image.network(
                          url,
                          width: 100,
                        ),
                      ),
                ],
              ),
            ),
          ),
          if (chatData.chatUserDto.name == userName) const SizedBox(width: 10),
          if (chatData.chatUserDto.name == userName)
            _ChatAvatar(
              userData: chatData.chatUserDto.name ?? 'Incognito user',
            ),
        ],
      ),
    );
  }
}

class _ChatAvatar extends StatelessWidget {
  const _ChatAvatar({required this.userData});

  final String userData;

  @override
  Widget build(BuildContext context) {
    const double size = 42;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.black87),
        color: GetIt.I<ChatCubit>().state.userColor.containsKey(userData)
            ? Colors.primaries[int.parse(
                GetIt.I<ChatCubit>().state.userColor[userData]!.toString(),
              )]
            : Colors.green,
      ),
      child: Center(
        child: Text(
          userData.split(' ').first[0],
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
