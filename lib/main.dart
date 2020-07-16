import 'package:corunha_guide/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:corunha_guide/authentication_bloc/bloc.dart';
import 'package:corunha_guide/repository/user_repository.dart';
import 'package:corunha_guide/screens/home_screen.dart';
import 'package:corunha_guide/login/login.dart';
import 'package:corunha_guide/screens/splash_screen.dart';
import 'package:corunha_guide/simple_bloc_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App());
}

class App extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _AppState state = context.findAncestorStateOfType<_AppState>();
    state.setLocale(locale);
  }

  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Locale _locale;
  final UserRepository _userRepository = UserRepository();
  AuthenticationBloc _authenticationBloc;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.dispatch(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _authenticationBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto',
          primarySwatch: Colors.blue,
          accentColor: const Color(0xFFFF5959),
        ),
        locale: _locale,
        supportedLocales: [
          Locale('es', 'ES'),
          Locale('en', 'US'),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocale.languageCode &&
                locale.countryCode == deviceLocale.countryCode) {
              return deviceLocale;
            }
          }

          return supportedLocales.first;
        },
        home: BlocBuilder(
          bloc: _authenticationBloc,
          // ignore: missing_return
          builder: (BuildContext context, AuthenticationState state) {
            if (state is Uninitialized) {
              return SplashScreen();
            }
            if (state is Unauthenticated) {
              return LoginScreen(userRepository: _userRepository);
            }
            if (state is Authenticated) {
              return HomeScreen(name: state.displayName);
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }
}
