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
    formState = GlobalKey<FormState>();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(firebaseAuthProvider);

    final isLogin = ref.watch(isLoginState);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
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
                      UserNameFormField(usernameController: usernameController),
                    if (!isLogin) addVerticalSizedBox(20),
                    EmailFormField(emailController: emailController),
                    addVerticalSizedBox(20),
                    PasswordFormField(passwordController: passwordController),
                  ],
                ),
              ),
              addVerticalSizedBox(40),
              AuthButton(
                  isLogin: isLogin,
                  auth: auth,
                  formState: formState,
                  emailController: emailController,
                  passwordController: passwordController,
                  ref: ref,
                  usernameController: usernameController),
              addVerticalSizedBox(20),
              SwitchAuthInterface(
                isLogin: isLogin,
                ref: ref,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SwitchAuthInterface extends StatelessWidget {
  const SwitchAuthInterface({
    Key? key,
    required this.isLogin,
    required this.ref,
  }) : super(key: key);

  final bool isLogin;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return RichText(
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
                  ref.read(isLoginState.notifier).state == false
                      ? ref.read(isLoginState.notifier).state = true
                      : ref.read(isLoginState.notifier).state = false;
                },
            ),
          ]),
    );
  }
}

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.isLogin,
    required this.auth,
    required this.formState,
    required this.emailController,
    required this.passwordController,
    required this.ref,
    required this.usernameController,
  }) : super(key: key);

  final bool isLogin;
  final Authentication auth;
  final GlobalKey<FormState> formState;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final WidgetRef ref;
  final TextEditingController usernameController;

  @override
  Widget build(BuildContext context) {
    return SignUpLogInButton(
        text: isLogin ? 'Log In' : 'Sign Up',
        authF: isLogin
            ? () async {
                await auth.loginMethode(
                  context,
                  formState,
                  emailController.text,
                  passwordController.text,
                );
                () => ref.read(userState.notifier).state.asData == null
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
                () => ref.read(userState.notifier).state.asData == null
                    ? showLoading(context)
                    : null;
              });
  }
}

class PasswordFormField extends StatelessWidget {
  const PasswordFormField({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) => passwordController.text = value.trim(),
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
    );
  }
}

class EmailFormField extends StatelessWidget {
  const EmailFormField({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
    );
  }
}

class UserNameFormField extends StatelessWidget {
  const UserNameFormField({
    Key? key,
    required this.usernameController,
  }) : super(key: key);

  final TextEditingController usernameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (value) => usernameController.text = value.trim(),
      validator: (value) {
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
    );
  }
}

final isLoginState = StateProvider<bool>(((ref) => false));
