import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:write_it/utils/utils.dart';

import '../services/providers/provider.dart';

class AddNoteScreen extends ConsumerWidget {
  AddNoteScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log('addscreen');
    final dateFormatter = DateFormat('yMd');
    final timeFormatter = DateFormat.jm();
    TextEditingController title = TextEditingController();
    TextEditingController description = TextEditingController();
    FormState formData;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add note'),
        actions: [
          IconButton(
              onPressed: () {
                if (title.text.isNotEmpty || description.text.isNotEmpty) {
                  formData = _formKey.currentState!;
                  formData.save();
                  ref.read(fireCrudProvider).addNote(
                        context,
                        title: title.text,
                        description: description.text,
                        time: timeFormatter.format(DateTime.now()),
                        date: dateFormatter.format(DateTime.now()),
                        ref: ref,
                      );
                }
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              TextField(
                key: const Key('title'),
                controller: title,
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
              ),
              addVerticalSizedBox(10),
              TextField(
                key: const Key('description'),
                controller: description,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
