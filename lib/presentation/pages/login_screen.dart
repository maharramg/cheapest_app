import 'package:cheapest_app/infrastructure/blocs/login/login_bloc.dart';
import 'package:cheapest_app/presentation/pages/registration_screen.dart';
import 'package:cheapest_app/presentation/pages/root_screen.dart';
import 'package:cheapest_app/presentation/shared/snack.dart';
import 'package:cheapest_app/presentation/widgets/components/custom_button.dart';
import 'package:cheapest_app/presentation/widgets/components/custom_text_field.dart';
import 'package:cheapest_app/utilities/constants/theme_globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _bloc = LoginBloc();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: _appBar(),
        body: BlocProvider(
          create: (context) => _bloc,
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginDisplayMessage) {
                Snack.display(context: context, message: state.message);
              } else if (state is LoginSuccess) {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => RootScreen()));
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return _body();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    CustomTextField(
                      controller: _emailController,
                      fieldText: "E-mail",
                      prefixIcon: Icons.email_outlined,
                      onChanged: (value) => _bloc.updateEmail(value),
                    ),
                    SizedBox(height: 10.0),
                    CustomTextField(
                      controller: _passwordController,
                      fieldText: "Password",
                      prefixIcon: Icons.code_outlined,
                      obscureText: true,
                      onChanged: (value) => _bloc.updatePassword(value),
                    ),
                    _loginButton(),
                  ],
                ),
                SizedBox(height: 10.0),
                Divider(),
                SizedBox(height: 10.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't have an account?",
                      style: bodyText2,
                    ),
                    SizedBox(height: 15.0),
                    buildRegisterButton(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginButton() {
    return CustomButton(
      onTap: () => _bloc.add(LoginButtonClicked()),
      title: "Login",
    );
  }

  Widget buildRegisterButton() {
    return CustomButton(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegistrationScreen())),
      title: "Register",
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: primaryColor,
      title: Text(
        "Login",
        style: appBarTitle,
      ),
      centerTitle: true,
    );
  }
}
