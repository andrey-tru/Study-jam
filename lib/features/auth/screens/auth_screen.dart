import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:surf_practice_chat_flutter/features/auth/auth.dart';
import 'package:surf_practice_chat_flutter/features/chat/chat.dart';
import 'package:surf_practice_chat_flutter/features/widgets/widgets.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    super.key,
    required this.authRepository,
  });

  final IAuthRepository authRepository;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FormGroup loginFormGroup = FormGroup(<String, AbstractControl<dynamic>>{
    'login': FormControl<String>(
      validators: <ValidatorFunction>[
        Validators.required,
      ],
    ),
    'password': FormControl<String>(
      validators: <ValidatorFunction>[
        Validators.required,
      ],
    ),
  });

  @override
  void initState() {
    GetIt.I<AuthCubit>().tokenVerification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: Colors.black87,
        child: BlocConsumer<AuthCubit, AuthState>(
          bloc: GetIt.I<AuthCubit>(),
          listener: (BuildContext context, AuthState state) {
            if (state.token != null) {
              _pushToChat(context, state.token!);
            }
          },
          builder: (BuildContext context, AuthState state) {
            if (state.isLoading) {
              const UiLoader();
            }
            return ReactiveForm(
              formGroup: loginFormGroup,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    UiTextField(
                      margin: const EdgeInsets.only(bottom: 30.0),
                      formControlName: 'login',
                      hintText: tr('auth.email'),
                      // keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    UiTextField(
                      margin: const EdgeInsets.only(bottom: 30.0),
                      formControlName: 'password',
                      hintText: tr('auth.password'),
                      // keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    ReactiveFormConsumer(
                      builder: (BuildContext context, FormGroup form, _) {
                        return UiButton(
                          title: tr('auth.btn'),
                          onPressed: () {
                            // pri
                            GetIt.I<AuthCubit>().signIn(form);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _pushToChat(BuildContext context, String token) {
    Navigator.push<ChatScreen>(
      context,
      MaterialPageRoute<ChatScreen>(
        builder: (_) {
          return ChatScreen(
            chatRepository: ChatRepository(
              StudyJamClient().getAuthorizedClient(token),
            ),
          );
        },
      ),
    );
  }
}
