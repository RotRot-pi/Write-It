import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:write_it/utils/utils.dart';

class WaitingScreen extends ConsumerWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log('WaitingScreen');
    return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
        ),
        color: kBlack,
        child: appBackGroundImage);
  }
}
