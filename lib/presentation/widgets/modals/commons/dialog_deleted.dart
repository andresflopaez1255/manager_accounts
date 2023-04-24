import 'package:flutter/material.dart';
import 'package:manager_accounts/utils/config/AppTheme.dart';
import 'package:manager_accounts/presentation/widgets/commons/commons.dart';

class DialogDelete extends StatelessWidget {
  final String? message;
  final void Function() deleteTap;
  final Function? cancelTap;

  const DialogDelete({
    Key? key,
    this.message,
    required this.deleteTap,
    this.cancelTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      title: const Text('¿Está seguro que desea Eliminar?',
          textAlign: TextAlign.center),
      content: Text(message ??
          'Si elimina esta cuenta no se podrá volver a recuperar su información',
          textAlign: TextAlign.center,
          ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Button(
              width: 100,
              height: 40,
              title: 'Si, Eliminar',
              textStyle: AppTheme.textStyle['button'],
              onTap: deleteTap,
            ),
            const SizedBox(
              width: 10,
            ),
            Button(
              width: 120,
              height: 40,
              title: 'No, Cancelar',
              textStyle: AppTheme.textStyle['button'],
              background: AppTheme.colors['secondaryColorButton'],
              onTap: () {
                cancelTap ?? Navigator.of(context).pop();
              },
            ),
          ],
        )
      ],
    );
  }
}
