import 'package:auth_sample/core/localization/app_localization.dart';
import 'package:auth_sample/core/localization/language_provider.dart';
import 'package:auth_sample/core/utils/responsive_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/router/app_router.dart';
import 'features/auth/presentation/blocs/auth_bloc.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await getIt.allReady();
  ResponsiveUtil.init(Size(390, 844));
  runApp(
    ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => getIt<AuthBloc>())],
      child: MaterialApp(
        title: 'Fitness Theme App',
        themeMode: ThemeMode.light,
        themeAnimationDuration: Duration.zero,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppRouter.splash,
        debugShowCheckedModeBanner: false,
        locale: languageProvider.locale,
        supportedLocales: const [Locale('en'), Locale('ar')],
        localizationsDelegates: [
          AppLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}
