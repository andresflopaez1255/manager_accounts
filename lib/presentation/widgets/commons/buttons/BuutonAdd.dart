import 'package:flutter/material.dart';
import 'package:manager_accounts/utils/config/AppTheme.dart';

class ButtonAdd extends StatelessWidget {
  final void Function()?  onPressed;
  const ButtonAdd({
    Key? key, this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromARGB(70, 223, 223, 233))),
        onPressed: onPressed,
        child: Row(
          children: [
            const Icon(
              Icons.add,
              color: Colors.black,
            ),
            Text(
              'Agregar',
              style: AppTheme.textStyle['button']?.copyWith(color: Colors.black),
            ),
          ],
        ));
  }
}