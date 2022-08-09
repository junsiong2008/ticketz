import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticketz/providers/auth_state_provider.dart';
import 'package:ticketz/screens/main_screen.dart';
import 'package:ticketz/screens/sign_in_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of<AuthStateProvider>(context).getUserStream,
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (user == null) {
          return const SignInScreen();
        } else {
          return const MainScreen();
        }
      },
    );
  }
}
