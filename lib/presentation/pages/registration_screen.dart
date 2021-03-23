import 'package:cheapest_app/infrastructure/blocs/registration/registration_bloc.dart';
import 'package:cheapest_app/presentation/pages/root_screen.dart';
import 'package:cheapest_app/presentation/shared/snack.dart';
import 'package:cheapest_app/presentation/widgets/components/custom_button.dart';
import 'package:cheapest_app/presentation/widgets/components/custom_text_field.dart';
import 'package:cheapest_app/utilities/constants/theme_globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _bloc = RegistrationBloc();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordCController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordCController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<RegistrationBloc, RegistrationState>(
          listener: (context, state) {
            if (state is RegistrationDisplayMessage) {
              Snack.display(context: context, message: state.message);
            }
            if (state is RegistrationSuccess) {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => RootScreen()));
            }
          },
          child: BlocBuilder<RegistrationBloc, RegistrationState>(
            builder: (context, state) {
              if (state is RegistrationLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return _body();
            },
          ),
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      leading: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      title: Text(
        "Registration",
        style: appBarTitle,
      ),
      centerTitle: true,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 15.0),
            _userNameField(context),
            SizedBox(height: 10.0),
            _emailField(context),
            SizedBox(height: 10.0),
            _passwordField(context),
            SizedBox(height: 10.0),
            _passwordCField(context),
            Divider(),
            _registerButton(context),
          ],
        ),
      ),
    );
  }

  Widget _registerButton(context) {
    return CustomButton(
      title: "Register",
      onTap: () => _bloc.add(RegistrationButtonClicked()),
    );
  }

  Widget _userNameField(context) {
    return CustomTextField(
      controller: _userNameController,
      prefixIcon: Icons.person_outlined,
      fieldText: "Username",
      onChanged: (value) => _bloc.updateUsername(value),
    );
  }

  Widget _emailField(context) {
    return CustomTextField(
      controller: _emailController,
      prefixIcon: Icons.email_outlined,
      fieldText: "E-mail",
      onChanged: (value) => _bloc.updateEmail(value),
    );
  }

  Widget _passwordField(context) {
    return CustomTextField(
      controller: _passwordController,
      prefixIcon: Icons.code_outlined,
      fieldText: "Password",
      obscureText: true,
      onChanged: (value) => _bloc.updatePassword(value),
    );
  }

  Widget _passwordCField(context) {
    return CustomTextField(
      controller: _passwordCController,
      prefixIcon: Icons.code_outlined,
      fieldText: "Confirm password",
      obscureText: true,
      onChanged: (value) => _bloc.updatePasswordC(value),
    );
  }
}
