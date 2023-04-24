import 'package:flutter/material.dart';
import 'package:manager_accounts/presentation/widgets/modals/commons/commons_modal.dart';

class CommonModalController {
  static Future<dynamic> deleteDialog(
      {required BuildContext context,
      required void Function() deletedTap,
      Function? cancelTap,
      String? message}) {
    return showDialog(
        context: context,
        builder: (_) => DialogDelete(
              deleteTap: deletedTap,
              message: message,
              cancelTap: cancelTap,
            ));
  }
}
