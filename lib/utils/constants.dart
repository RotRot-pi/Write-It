import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:write_it/utils/colors.dart';

final dateFormatter = DateFormat('yMd');
final timeFormatter = DateFormat.jm();

screenWidth(var context) {
  var width = MediaQuery.of(context).size.width;
  return width;
}

screenHight(var context) {
  var height = MediaQuery.of(context).size.height;
  return height;
}

addVerticalSizedBox(double height) {
  return SizedBox(height: height);
}

addHorizantalSizedBox(double width) {
  return SizedBox(width: width);
}

showLoading(context) {
  return showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: ((context) => AlertDialog(
            backgroundColor: kBlack.withAlpha(150),
            title: const Text(
              'Wait a moment please',
              style: TextStyle(
                color: kWhite,
              ),
            ),
            content: const SizedBox(
              height: 30,
              child: Center(
                  child: LinearProgressIndicator(
                color: kYellow,
              )),
            ),
          )));
}

errorDialog(var context, String? errorMessage) async {
  return AwesomeDialog(
    dialogType: DialogType.error,
    context: context,
    title: 'Error',
    body: SizedBox(
        height: 75,
        child: Text(
          '$errorMessage',
          style: Theme.of(context).textTheme.bodyText1,
        )),
  ).show();
}

invalidDialog(var context, String? errorMessage) async {
  return AwesomeDialog(
    dialogType: DialogType.warning,
    context: context,
    title: 'Error',
    body: SizedBox(
        height: 75,
        child: Text(
          '$errorMessage',
          style: Theme.of(context).textTheme.bodyText1,
        )),
  ).show();
}

extension IsContaining on String {
  isContaing(var x, var y, [var z, var w]) {
    if (z != null) {
      return contains(x) && contains(y) && contains(z);
    }
    if (w != null) {
      return contains(x) && contains(y) && contains(z) && contains(w);
    }
    return contains(x) && contains(y);
  }
}

class FormIsInvalidException implements Exception {
  static constructor(var message, context) {
    return showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'))
              ],
            )));
  }
}
