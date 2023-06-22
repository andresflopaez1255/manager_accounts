import 'package:flutter/material.dart';
import 'package:manager_accounts/utils/config/AppTheme.dart';

class ButtonAdd extends StatelessWidget {
  final void Function()? onPressed;
  const ButtonAdd({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Row(
          children: [
            const Icon(
              Icons.add,
            ),
            Text(
              'Agregar',
            ),
          ],
        ));
  }
}
