import 'package:flutter/material.dart';

import '../utils/utils.dart';

class SignUpLogInButton extends StatelessWidget {
  final void Function() authF;

  final String text;

  const SignUpLogInButton({
    super.key,
    required this.authF,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: kYellow, width: 2),
        borderRadius: BorderRadius.circular(18),
      ),
      child: MaterialButton(
          onPressed: authF,
          child: Text(
            text,
            style: const TextStyle(color: kWhite, fontWeight: FontWeight.w500),
          )),
    );
  }
}
