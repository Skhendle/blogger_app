import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blogger_app/bloc/login_bloc.dart';
import 'package:flutter/foundation.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        lazy: false,
        create: (BuildContext context) => LoginBloc(),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Login"),
          ),
          backgroundColor: Color.fromRGBO(51, 153, 255, 1.0),
          body: BlocListener<LoginBloc, LoginState>(

            listener: (context, LoginState state) {
              if (state is LoginSuccess) {
                // Navigate to home page
                Navigator.popAndPushNamed(context, '/home');

                // returns the scaffold and dialogue

                // Scaffold.of(context).hideCurrentSnackBar();
                // showDialog<void>(
                //   context: context,
                //   builder: (_) => SuccessDialog(),
                // );
              }

            },
            child: LoginForm(),
            )
      )

    );


  }
}

class LoginForm extends StatefulWidget {

  const LoginForm({
    Key key,
  }) : super(key: key);

  @override
  _LoginForm createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm>{
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<LoginBloc>().add(EmailUnfocused());
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<LoginBloc>().add(PasswordUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    return BlocBuilder(
      bloc: context.read<LoginBloc>(),
      builder: ( BuildContext context, LoginState state){

        if(state is SubmittingLogin){
          return Center(
            child: CircularProgressIndicator(),
          );

        } else if(state is FailedLogin){

          return Center(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 5.0),

              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(" ${state.message} "),
                    EmailInput(focusNode: _emailFocusNode),
                    PasswordInput(focusNode: _passwordFocusNode),
                    SubmitButton(),
                  ],
                )
              ],
            )
          );
        }else{
          return Center(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20.0),
              children: <Widget>[
                Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    EmailInput(focusNode: _emailFocusNode),
                    PasswordInput(focusNode: _passwordFocusNode),
                    SubmitButton(),
                  ],
                ),
              ],
            )
          );

        }
      }
    );
  }
}


class EmailInput extends StatelessWidget {
  const EmailInput({Key key, this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.email.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.email),
            labelText: 'Email',
            helperText: 'A complete, valid email e.g. joe@gmail.com',
            errorText: state.email.invalid
                ? 'Please ensure the email entered is valid'
                : null,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            context.read<LoginBloc>().add(EmailChanged(email: value));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key key, this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.password.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.lock),
            helperText:
                '''Password should be at least 8 characters with at least one letter and number''',
            helperMaxLines: 2,
            labelText: 'Password',
            errorMaxLines: 2,
            errorText: state.password.invalid
                ? '''Password must be at least 8 characters and contain at least one letter and number'''
                : null,
          ),
          obscureText: true,
          onChanged: (value) {
            context.read<LoginBloc>().add(PasswordChanged(password: value));
          },
          textInputAction: TextInputAction.done,
        );
      },
    );
  }
}

class SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return RaisedButton(
          onPressed: state.status.isValidated
              ? () => context.read<LoginBloc>().add(FormSubmitted())
              : null,
          child: const Text('Submit'),
        );
      },
    );
  }
}

class SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const Icon(Icons.info),
                const Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Form Submitted Successfully!',
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            RaisedButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
