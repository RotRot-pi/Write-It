import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:write_it/widgets/signup_login_button.dart';

import '../services/services.dart';
import '../utils/utils.dart';
import '../widgets/app_icon.dart';

class AuthenticationScreen extends ConsumerStatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  ConsumerState<AuthenticationScreen> createState() =>
      _AuthenticationScreenState();
}

class _AuthenticationScreenState extends ConsumerState<AuthenticationScreen> {
  late GlobalKey<FormState> formState;

  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    log('init');
    formState = GlobalKey<FormState>();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AuthenticationScreen oldWidget) {
    log('update');
    formState = GlobalKey<FormState>();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    log('change');

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    log('dispose');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('build');
    final auth = ref.watch(firebaseAuthProvider);

    final isLogin = ref.watch(isLoginState);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBlack,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIcon(
                image: appIconImage,
                width: 80,
                height: 80,
              ),
              addVerticalSizedBox(10),
              const Text(
                'Welcome',
                style: TextStyle(
                    color: kWhite, fontWeight: FontWeight.bold, fontSize: 30),
              ),
              addVerticalSizedBox(20),
              Form(
                key: formState,
                child: Column(
                  children: [
                    if (!isLogin)
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (value) =>
                            usernameController.text = value.trim(),
                        validator: (value) {
                          debugPrint("value:$value");
                          if (value!.isEmpty && value.length < 6) {
                            return 'the username must contain at least 4 character';
                          }
                          return null;
                        },
                        cursorColor: kYellow,
                        cursorWidth: 2,
                        style: const TextStyle(
                          color: kWhite,
                        ),
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(color: kLightWhite),
                          hintText: 'Username',
                          focusedBorder: authTextFieldInputBorderStyle,
                          enabledBorder: authTextFieldInputBorderStyle,
                          focusedErrorBorder: authTextFieldInputBorderStyle,
                          errorBorder: authTextFieldInputBorderStyle,
                        ),
                      ),
                    if (!isLogin) addVerticalSizedBox(20),
                    TextFormField(
                      onChanged: (value) => emailController.text = value.trim(),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (!value!.isContaing('@', '.')) {
                          return 'The email must be a valid email address';
                        }
                        return null;
                      },
                      cursorColor: kYellow,
                      cursorWidth: 2,
                      style: const TextStyle(
                        color: kWhite,
                      ),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(color: kLightWhite),
                        hintText: 'Email',
                        focusedBorder: authTextFieldInputBorderStyle,
                        enabledBorder: authTextFieldInputBorderStyle,
                        focusedErrorBorder: authTextFieldInputBorderStyle,
                        errorBorder: authTextFieldInputBorderStyle,
                      ),
                    ),
                    addVerticalSizedBox(20),
                    TextFormField(
                      onChanged: (value) =>
                          passwordController.text = value.trim(),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.length < 8) {
                          return 'The password must be at least 8 characters';
                        }
                        if (value.length > 20) {
                          return 'The password must be less than 20 characters';
                        }
                        return null;
                      },
                      cursorColor: kYellow,
                      cursorWidth: 2,
                      obscureText: true,
                      style: const TextStyle(
                        color: kWhite,
                      ),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(color: kLightWhite),
                        hintText: 'Password',
                        focusedBorder: authTextFieldInputBorderStyle,
                        enabledBorder: authTextFieldInputBorderStyle,
                        focusedErrorBorder: authTextFieldInputBorderStyle,
                        errorBorder: authTextFieldInputBorderStyle,
                      ),
                    ),
                  ],
                ),
              ),
              addVerticalSizedBox(40),
              SignUpLogInButton(
                  text: isLogin ? 'Log In' : 'Sign Up',
                  authF: isLogin
                      ? () async {
                          await auth.loginMethode(
                            context,
                            formState,
                            emailController.text,
                            passwordController.text,
                          );
                          () =>
                              ref.read(userState.notifier).state.asData == null
                                  ? showLoading(context)
                                  : null;
                        }
                      : () async {
                          await auth.signUpMethode(
                            context,
                            formState,
                            usernameController.text,
                            emailController.text,
                            passwordController.text,
                          );
                          () =>
                              ref.read(userState.notifier).state.asData == null
                                  ? showLoading(context)
                                  : null;
                        }),
              addVerticalSizedBox(20),
              RichText(
                text: TextSpan(
                    text: isLogin
                        ? 'If you don\'t have an account yet? '
                        : 'If you have an account ',
                    children: [
                      TextSpan(
                        text: isLogin ? 'Sign up' : 'Log in.',
                        style: const TextStyle(color: kYellow),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            log('${!ref.read(isLoginState.notifier).state}');
                            ref.read(isLoginState.notifier).state == false
                                ? ref.read(isLoginState.notifier).state = true
                                : ref.read(isLoginState.notifier).state = false;
                          },
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final isLoginState = StateProvider<bool>(((ref) => false));
