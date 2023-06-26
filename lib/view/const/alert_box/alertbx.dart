import 'package:flutter/cupertino.dart';

void showQuickAlert(
    BuildContext context, String title, String message, Function onpressed) {
  Widget createDilog(BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: const Text('No'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            child: const Text('Yes'),
            onPressed: () => onpressed(),
          ),
        ],
      );
  showCupertinoDialog(
    barrierDismissible: true,
    context: context,
    builder: createDilog,
  );
}
