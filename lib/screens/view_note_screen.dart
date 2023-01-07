import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:write_it/utils/colors.dart';
import 'package:write_it/utils/constants.dart';

import '../services/services.dart';

class ViewNoteScreen extends ConsumerWidget {
  const ViewNoteScreen({
    required this.noteInfo,
    super.key,
  });
  final noteInfo;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log('viewscreen');
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);

    log('id v :${noteInfo['noteId']}');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(actions: [
          IconButton(
              onPressed: () {
                var note = {
                  'noteId': noteInfo['noteId'],
                  'title': noteInfo['title'] ?? '',
                  'description': noteInfo['description'] ?? '',
                };
                context.push(Routes.editNotePath, extra: note);
              },
              icon: const Icon(Icons.edit))
        ]),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: ListView(
            children: [
              Text(
                noteInfo['title'] ?? '',
                softWrap: true,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  color: kWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const Divider(
                color: kLightWhite,
                thickness: 1,
              ),
              addVerticalSizedBox(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    noteInfo['time'],
                    style: const TextStyle(
                      color: kWhite,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    noteInfo['date'],
                    style: const TextStyle(
                      color: kWhite,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const Divider(
                color: kLightWhite,
                thickness: 1,
              ),
              addVerticalSizedBox(25),
              Text(
                noteInfo['description'],
                style: const TextStyle(
                  color: kWhite,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
