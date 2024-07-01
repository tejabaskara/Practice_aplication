import 'package:flutter/material.dart';
import 'package:tugas_login/component/text.dart';

void showAlertDialog(BuildContext context, String title, String alertMessage) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(alertMessage),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Ok'),
        ),
      ],
    ),
  );
}

void showReminderDialog(BuildContext context, String title, String alertMessage,
    VoidCallback onConfirm) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(alertMessage),
      actions: [
        TextButton(
          onPressed: () {
            onConfirm();
          },
          child: const Text('Ok'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Tidak'),
        ),
      ],
    ),
  );
}

void showAlertDialogExpiredToken(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: textBoldStyle("Token Kadaluarsa", 16),
      content: textStyle("Silahkan login kembali", 12),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/login');
          },
          child: const Text('Ok'),
        ),
      ],
    ),
  );
}
