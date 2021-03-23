import 'package:animations/animations.dart';
import 'package:cheapest_app/infrastructure/blocs/authentication/authentication_bloc.dart';
import 'package:cheapest_app/infrastructure/global_view_model.dart';
import 'package:cheapest_app/presentation/pages/login_screen.dart';
import 'package:cheapest_app/presentation/pages/root_screen.dart';
import 'package:cheapest_app/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  final bool isLoggedIn;

  const App({
    @required this.isLoggedIn,
  });
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<GlobalViewModel>(
          create: (_) => GlobalViewModel(isLoggedIn: widget.isLoggedIn),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Cheapest App",
        theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: SharedAxisPageTransitionsBuilder(
                transitionType: SharedAxisTransitionType.scaled,
              ),
              TargetPlatform.iOS: SharedAxisPageTransitionsBuilder(
                transitionType: SharedAxisTransitionType.scaled,
              ),
            },
          ),
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Inter',
          appBarTheme: AppBarTheme(
            brightness: Brightness.dark,
            color: Colors.white,
            elevation: 1.0,
          ),
        ),
        // locale: model.appLocal,
        // onGenerateRoute: CustomRouter.onGenerateRoute,
        supportedLocales: [
          Locale("az", "AZ"),
          Locale("tr", "TR"),
          Locale("ru", "RU"),
          Locale("en", "EN"),
        ],
        localizationsDelegates: [
          // AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationAuthenticated) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => RootScreen()),
                (route) => false,
              );
            }

            if (state is AuthenticationUnauthenticated) {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoginScreen()));
            }
            return Center(child: CircularProgressIndicator());
          },
          builder: (context, state) {
            return SplashScreen();
          },
        ),
      ),
    );
  }
}
