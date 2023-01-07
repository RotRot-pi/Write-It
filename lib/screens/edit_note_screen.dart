import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:write_it/utils/colors.dart';
import 'package:write_it/utils/constants.dart';

import '../services/providers/provider.dart';

class EditNoteScreen extends ConsumerWidget {
  EditNoteScreen({
    required this.noteInfo,
    super.key,
  });
  final noteInfo;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log('editscreen');

    log('id e:${noteInfo['noteId']}');
    FormState formData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add note'),
        actions: [
          IconButton(
            onPressed: () {
              if (noteInfo['title'] != null ||
                  noteInfo['description'] != null) {
                formData = _formKey.currentState!;
                formData.save();
                ref.read(fireCrudProvider).updateNote(
                      noteInfo['noteId'],
                      context,
                      title: noteInfo['title'],
                      description: noteInfo['description'],
                      time: timeFormatter.format(DateTime.now()),
                      date: dateFormatter.format(DateTime.now()),
                    );
              }
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              EditTitle(noteInfo: noteInfo),
              addVerticalSizedBox(10),
              EditDescription(noteInfo: noteInfo),
            ],
          ),
        ),
      ),
    );
  }
}

class EditDescription extends StatelessWidget {
  const EditDescription({
    Key? key,
    required this.noteInfo,
  }) : super(key: key);

  final noteInfo;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: const Key('description'),
      initialValue: noteInfo['description'],
      onSaved: (value) => noteInfo['description'] = value,
      maxLines: null,
      style: const TextStyle(
        color: kWhite,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'description',
        hintStyle: TextStyle(
          color: kWhite.withOpacity(0.4),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}

class EditTitle extends StatelessWidget {
  const EditTitle({
    Key? key,
    required this.noteInfo,
  }) : super(key: key);

  final noteInfo;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: const Key('title'),
      initialValue: noteInfo['title'],
      onSaved: (value) => noteInfo['title'] = value,
      maxLines: 1,
      maxLength: 35,
      style: const TextStyle(
        color: kWhite,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Title',
        hintStyle: TextStyle(
          color: kWhite.withOpacity(0.4),
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        counterStyle: TextStyle(
          color: kWhite.withOpacity(0.4),
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    );
  }
}
