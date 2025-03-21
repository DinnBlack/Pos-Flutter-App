import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return BasicDialogAlert(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        BasicDialogAction(
          title: Text("Hủy"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        BasicDialogAction(
          title: Text("Xóa"),
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
