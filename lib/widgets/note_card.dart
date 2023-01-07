import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/services.dart';
import '../utils/utils.dart';

class NoteCard extends ConsumerWidget {
  const NoteCard({
    super.key,
    required this.note,
    this.color = kWhite,
  });
  final NoteModel? note;
  final Color color;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(1.0, 1.0),
            color: Colors.black.withAlpha(30),
            spreadRadius: 0.3,
            blurRadius: 0.3,
          ),
          BoxShadow(
            offset: const Offset(-1.0, -1.0),
            color: kLightWhite.withAlpha(30),
            spreadRadius: 0.3,
            blurRadius: 0.3,
          ),
        ],
        borderRadius: BorderRadius.circular(12),
        color: kBlack,
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ColoredLine(color: color),
              addVerticalSizedBox(10),
              NoteInfo(note: note),
              DateAndTime(note: note)
            ],
          ),
        ],
      ),
    );
  }
}

class DateAndTime extends StatelessWidget {
  const DateAndTime({
    Key? key,
    required this.note,
  }) : super(key: key);

  final NoteModel? note;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          '${note?.date}',
          style: const TextStyle(
            color: kWhite,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${note?.time}',
          style: const TextStyle(
            color: kWhite,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ]),
    );
  }
}

class NoteInfo extends StatelessWidget {
  const NoteInfo({
    Key? key,
    required this.note,
  }) : super(key: key);

  final NoteModel? note;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 12,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${note?.title}',
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                color: kWhite,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            addVerticalSizedBox(10),
            Expanded(
              child: Text(
                '${note?.description}',
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                style: const TextStyle(
                  color: kWhite,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ColoredLine extends StatelessWidget {
  const ColoredLine({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black.withAlpha(120)),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              color: color.withAlpha(180),
            ),
          ),
        ),
      ),
    );
  }
}
