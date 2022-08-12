import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_practice_chat_flutter/features/chat/chat.dart';
import 'package:surf_practice_chat_flutter/features/topics/topics.dart';

part 'chat_state.dart';
part 'chat_cubit.freezed.dart';

@singleton
class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(const ChatState());

  Future<void> getMessages([int? chatId]) async {
    emit(state.copyWith(isLoading: true));

    if (chatId == null) {
      await GetIt.I<TopicsCubit>().getTopics();
    }

    final SharedPreferences localStorageService =
        await SharedPreferences.getInstance();

    Map<String, dynamic> userColor;

    if (localStorageService.getString('userColor') != null) {
      userColor = jsonDecode(localStorageService.getString('userColor')!)
          as Map<String, dynamic>;
    } else {
      userColor = <String, dynamic>{};
    }

    final Iterable<ChatMessageDto> messages =
        await state.chatRepository!.getMessages(
      chatId ?? GetIt.I<TopicsCubit>().state.chats.elementAt(0).id,
    );

    for (final ChatMessageDto message in messages) {
      if (!userColor.keys.contains(message.chatUserDto.name)) {
        userColor.addAll(<String, dynamic>{
          message.chatUserDto.name ?? '':
              Random().nextInt(Colors.primaries.length)
        });
      }

      if (message.chatUserDto is ChatUserLocalDto) {
        GetIt.I<TopicsCubit>().userName(
          message.chatUserDto.name ?? 'Incognito user',
        );
        emit(
          state.copyWith(
            userName: message.chatUserDto.name ?? 'Incognito user',
          ),
        );
      }
    }

    GetIt.I<TopicsCubit>().activeChat(
      chatId ?? GetIt.I<TopicsCubit>().state.chats.elementAt(0).id,
    );

    await localStorageService.setString('userColor', jsonEncode(userColor));

    emit(
      state.copyWith(
        isLoading: false,
        messages: messages,
        userColor: userColor,
      ),
    );
  }

  Future<void> sendMessage(String message) async {
    emit(state.copyWith(isLoading: true));
    String messageText = message;
    Iterable<ChatMessageDto> messages;

    if (state.urlImg != null) {
      messageText = '$message${state.urlImg}';
    }

    if (state.location == null) {
      messages = await state.chatRepository!
          .sendMessage(messageText, GetIt.I<TopicsCubit>().state.idActive);
    } else {
      messages = await state.chatRepository!.sendGeolocationMessage(
        location: state.location!,
        message: messageText,
        chatId: GetIt.I<TopicsCubit>().state.idActive!,
      );

      emit(state.copyWith(location: null));
    }

    emit(state.copyWith(isLoading: false, messages: messages, urlImg: null));
  }

  void chatRepository(IChatRepository chatRepository) {
    emit(state.copyWith(chatRepository: chatRepository));
  }

  Future<void> sendGeoMessage() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future<void>.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future<void>.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future<void>.error(
        // ignore: lines_longer_than_80_chars
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    final Position position = await Geolocator.getCurrentPosition();

    final ChatGeolocationDto location = ChatGeolocationDto(
      latitude: position.latitude,
      longitude: position.longitude,
    );

    emit(state.copyWith(location: location));
  }

  void urlImg(String? url) {
    emit(state.copyWith(urlImg: url));
  }
}
