import 'package:flutter/material.dart';

class ErrorDialogWidget extends StatelessWidget {
  final BuildContext ctx;
  const ErrorDialogWidget(this.ctx);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text('Something went wrong! Please try again later.'),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(ctx).pop();
          },
          child: Text('Okay'),
        )
      ],
    );
  }
}
