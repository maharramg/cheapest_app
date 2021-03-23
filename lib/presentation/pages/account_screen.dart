import 'package:cheapest_app/infrastructure/blocs/account/account_bloc.dart';
import 'package:cheapest_app/infrastructure/global_view_model.dart';
import 'package:cheapest_app/infrastructure/locator.dart';
import 'package:cheapest_app/infrastructure/models/account_model.dart';
import 'package:cheapest_app/infrastructure/services/preferences_service.dart';
import 'package:cheapest_app/presentation/pages/login_screen.dart';
import 'package:cheapest_app/presentation/widgets/components/custom_button.dart';
import 'package:cheapest_app/utilities/constants/theme_globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _bloc = AccountBloc();

  @override
  void initState() {
    super.initState();
    _bloc.add(FetchAccount());
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state is AccountDisplayMessage) {
              print(state.message);
            }
          },
          child: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              if (state is AccountLoaded) {
                return _buildBody(account: state.account);
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody({AccountModel account}) {
    var globalViewModel = Provider.of<GlobalViewModel>(context, listen: false);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            CircleAvatar(
              maxRadius: 70,
              backgroundImage: NetworkImage("https://w7.pngwing.com/pngs/178/419/png-transparent-man-illustration-computer-icons-avatar-login-user-avatar-child-web-design-face-thumbnail.png"),
            ),
            SizedBox(height: 20),
            Text(
              "${account.username}",
              style: bodyText1Bold.copyWith(fontSize: 22),
            ),
            SizedBox(height: 20),
            Text(
              "E-mail: ${account.email}",
              style: bodyText2,
            ),
            SizedBox(height: 20),
            Text(
              "ID: ${account.id}",
              style: bodyText2,
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: CustomButton(
                color: primaryColor,
                title: "Logout",
                onTap: () async {
                  await globalViewModel.logUserOut();
                  await locator<PreferencesService>().persistToken(token: null);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
