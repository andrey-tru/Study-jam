import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_practice_chat_flutter/features/auth/models/token_dto.dart';
import 'package:surf_practice_chat_flutter/features/auth/repository/repository.dart';
import 'package:surf_practice_chat_flutter/features/utils/utils.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

@singleton
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  final AuthRepository _authRepository = AuthRepository(StudyJamClient());

  Future<void> tokenVerification() async {
    emit(state.copyWith(isLoading: true));
    final SharedPreferences localStorageService =
        await SharedPreferences.getInstance();

    emit(
      state.copyWith(
        token: localStorageService.getString('token'),
        isLoading: false,
      ),
    );
  }

  Future<void> signIn(FormGroup form) async {
    emit(state.copyWith(isLoading: true));
    final SharedPreferences localStorageService =
        await SharedPreferences.getInstance();

    final TokenDto signIn = await _authRepository.signIn(
      login: form.control('login').value.toString(),
      password: form.control('password').value.toString(),
    );

    if (signIn.token != null) {
      await localStorageService.setString('token', signIn.token!);

      NotifyService.showSuccessNotify('success');

      emit(
        state.copyWith(
          token: localStorageService.getString('token'),
          isLoading: false,
        ),
      );
    } else {
      NotifyService.showErrorNotify(signIn.error!);
    }
  }

  Future<void> signOut() async {
    emit(state.copyWith(token: null));

    final SharedPreferences localStorageService =
        await SharedPreferences.getInstance();

    // await _authRepository.signOut();

    localStorageService.remove('token');
  }
}
