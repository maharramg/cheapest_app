import 'package:cheapest_app/app.dart';
import 'package:cheapest_app/infrastructure/blocs/authentication/authentication_bloc.dart';
import 'package:cheapest_app/infrastructure/global_view_model.dart';
import 'package:cheapest_app/infrastructure/locator.dart';
import 'package:cheapest_app/infrastructure/services/preferences_service.dart';
import 'package:cheapest_app/utilities/delegates/simple_bloc_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();

  Bloc.observer = SimpleBlocObserver();

  final isLoggedIn = locator<PreferencesService>().isLoggedIn ?? false;
  runApp(
    BlocProvider(
      create: (_) => AuthenticationBloc(AuthenticationInitial())..add(AppStarted()),
      child: ChangeNotifierProvider(
        create: (_) => GlobalViewModel(),
        child: App(isLoggedIn: isLoggedIn),
      ),
    ),
  );

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
  );
}
