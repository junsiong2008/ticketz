import 'package:ticketz/components/custom_form_field.dart';
import 'package:ticketz/components/page_title.dart';
import 'package:ticketz/components/primary_button.dart';
import 'package:ticketz/providers/auth_state_provider.dart';
import 'package:ticketz/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signIn() async {
    final authStateProvider = Provider.of<AuthStateProvider>(
      context,
      listen: false,
    );

    final String email = emailController.text.trim();
    final String password = passwordController.text;
    if (_formKey.currentState!.validate()) {
      authStateProvider.loading = true;
      await authStateProvider.signInWithEmailAndPassword(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: ((context, constraints) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24.0,
                    horizontal: 16.0,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: <Widget>[
                        const PageTitle(
                          pageTitle: 'Sign In to Ticketz',
                          actions: [],
                        ),
                        Center(
                          child: Lottie.asset(
                            'assets/animations/ticket-query.json',
                            height: constraints.maxHeight * 0.35,
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              CustomFormField(
                                label: 'Email',
                                textEditingController: emailController,
                                onChanged: (value) {},
                                validator: (value) {
                                  RegExp regex = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                  if (value == null ||
                                      value.isEmpty ||
                                      !regex.hasMatch(value)) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              CustomFormField(
                                label: 'Password',
                                textEditingController: passwordController,
                                obscureText: true,
                                onChanged: (value) {},
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a valid password';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 24.0,
                              ),
                              Consumer<AuthStateProvider>(
                                  builder: ((context, value, child) {
                                if (value.loading) {
                                  return const Center(
                                    child: SizedBox(
                                      width: 24.0,
                                      height: 24.0,
                                      child: CircularProgressIndicator(
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                  );
                                } else {
                                  return PrimaryButton(
                                    label: 'Sign In',
                                    onTap: signIn,
                                  );
                                }
                              })),
                            ],
                          ),
                        ),
                        Consumer<AuthStateProvider>(
                          builder: ((context, value, child) {
                            if (value.errorString != null) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                ),
                                child: Text(
                                  value.errorString!,
                                  style: kErrorTextStyle,
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
