import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:write_it/utils/colors.dart';
import 'package:go_router/go_router.dart';

import '../services/services.dart';
import '../widgets/widgets.dart';

//TODO: add Trasitions to the navigation system
//TODO: use the StaggredGridView  intead of the GridView
//TODO: Commit the changes
//TODO: make a better designed UI for the app

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(firebaseAuthProvider);
    final notesDocuments = ref.watch(notesProvider);
    List<NoteModel> notes = [];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Write It'), actions: [
          SignOutButton(auth: auth),
        ]),
        body: HomeScreenView(
          notesDocuments: notesDocuments,
          notes: notes,
          ref: ref,
        ),
      ),
    );
  }
}

class SignOutButton extends StatelessWidget {
  const SignOutButton({
    Key? key,
    required this.auth,
  }) : super(key: key);

  final Authentication auth;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        auth.signOut();
      },
      icon: const Icon(Icons.exit_to_app),
    );
  }
}

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({
    Key? key,
    required this.notesDocuments,
    required this.notes,
    required this.ref,
  }) : super(key: key);

  final AsyncValue<QuerySnapshot<Map<String, dynamic>>> notesDocuments;
  final List<NoteModel> notes;
  final WidgetRef ref;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        notesDocuments.when(
          data: (data) {
            var docs = data.docs;
            for (var doc in docs) {
              NoteModel note = NoteModel(
                  id: doc.id,
                  title: doc.data()['title'],
                  description: doc.data()['description'],
                  date: doc.data()['date'],
                  time: doc.data()['time']);

              notes.add(note);
              debugPrint('notes :$notes');
            }
            return NotesGridView(
              notes: notes,
              ref: ref,
            );
          },
          error: ((error, stackTrace) => Center(child: Text('error:$error'))),
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: CircularProgressIndicator(),
            ),
          ),
        ),
        const AddNoteButton()
      ],
    );
  }
}

class AddNoteButton extends StatelessWidget {
  const AddNoteButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 25,
      right: 25,
      child: GestureDetector(
        onTap: () => context.pushNamed(Routes.addNoteName),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                offset: const Offset(1.0, 1.0),
                color: kWhite.withAlpha(30),
                spreadRadius: 0.3,
                blurRadius: 0.3,
              ),
              BoxShadow(
                offset: const Offset(-1.0, -1.0),
                color: Colors.black.withAlpha(30),
                spreadRadius: 0.3,
                blurRadius: 0.3,
              ),
            ],
            color: kBlack.withAlpha(100),
          ),
          width: 50,
          height: 50,
          child: const Icon(
            Icons.add,
            color: kWhite,
            size: 35,
          ),
        ),
      ),
    );
  }
}

class NotesGridView extends StatelessWidget {
  const NotesGridView({
    Key? key,
    required this.notes,
    required this.ref,
  }) : super(key: key);

  final List<NoteModel> notes;
  final WidgetRef ref;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: notes.length,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: GestureDetector(
              onTap: () {
                var noteInfo = {
                  'noteId': notes[index].id,
                  'title': notes[index].title ?? '',
                  'description': notes[index].description ?? '',
                  'date': notes[index].date,
                  'time': notes[index].time,
                };

                context.pushNamed(Routes.viewNoteName, extra: noteInfo);
              },
              onLongPress: () {
                showDialog(
                  barrierColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Delete'),
                      content: const Text('Do you want to delete this note'),
                      actions: [
                        IconButton(
                            onPressed: () => context.pop(),
                            icon: const Icon(Icons.clear)),
                        IconButton(
                            onPressed: (() {
                              ref
                                  .read(fireCrudProvider)
                                  .deleteNote(notes[index].id!, context)
                                  .then((value) => context.pop());

                              notes.remove(notes[index]);
                            }),
                            icon: const Icon(Icons.delete))
                      ],
                    );
                  },
                );
              },
              child: NoteCard(
                note: notes[index],
              ),
            ),
          );
        }));
  }
}
