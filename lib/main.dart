import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_practice_chat_flutter/features/auth/repository/auth_repository.dart';
import 'package:surf_practice_chat_flutter/features/auth/screens/auth_screen.dart';
import 'package:surf_practice_chat_flutter/features/utils/utils.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SharedPreferences.getInstance();

  await configureDependencies();

  runApp(
    EasyLocalization(
      supportedLocales: <Locale>['en'.toLocale(), 'ru'.toLocale()],
      useOnlyLangCode: true,
      path: 'assets/translations',
      fallbackLocale: 'en'.toLocale(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: GetIt.I<NavigationService>().navigatorKey,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: AuthScreen(
        authRepository: AuthRepository(StudyJamClient()),
      ),
    );
  }
}
