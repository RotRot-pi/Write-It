import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:write_it/utils/utils.dart';



class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log('splashscreen');
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 130,
      ),
      color: kWhite,
      child: Center(child: clipBoardImage),
    );
  }
}
