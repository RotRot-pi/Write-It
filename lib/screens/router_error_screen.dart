import 'package:flutter/material.dart';
import 'package:write_it/utils/colors.dart';

class ErrorScreen extends StatelessWidget {
  final Exception? error;

  const ErrorScreen({
    Key? key,
    required this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error Screen'),
      ),
      body: Center(
        child: Text(
          '$error',
          style: const TextStyle(color: kWhite),
        ),
      ),
    );
  }
}
