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
                context.pushNamed(Routes.editNoteName, extra: note);
              },
              icon: const Icon(Icons.edit))
        ]),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: ListView(
            children: [
              ViewTitle(noteInfo: noteInfo),
              const Divider(
                color: kLightWhite,
                thickness: 1,
              ),
              addVerticalSizedBox(10),
              ViewDateAndTime(noteInfo: noteInfo),
              const Divider(
                color: kLightWhite,
                thickness: 1,
              ),
              addVerticalSizedBox(25),
              ViewDescription(noteInfo: noteInfo),
            ],
          ),
        ),
      ),
    );
  }
}

class ViewDescription extends StatelessWidget {
  const ViewDescription({
    Key? key,
    required this.noteInfo,
  }) : super(key: key);

  final noteInfo;

  @override
  Widget build(BuildContext context) {
    return Text(
      noteInfo['description'],
      style: const TextStyle(
        color: kWhite,
        fontSize: 20,
      ),
    );
  }
}

class ViewDateAndTime extends StatelessWidget {
  const ViewDateAndTime({
    Key? key,
    required this.noteInfo,
  }) : super(key: key);

  final noteInfo;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

class ViewTitle extends StatelessWidget {
  const ViewTitle({
    Key? key,
    required this.noteInfo,
  }) : super(key: key);

  final noteInfo;

  @override
  Widget build(BuildContext context) {
    return Text(
      noteInfo['title'] ?? '',
      softWrap: true,
      overflow: TextOverflow.clip,
      style: const TextStyle(
        color: kWhite,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
    );
  }
}
