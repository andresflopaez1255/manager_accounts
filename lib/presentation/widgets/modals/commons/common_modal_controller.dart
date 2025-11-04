import 'package:flutter/material.dart';
import 'package:manager_accounts/presentation/widgets/accounts/InfoAccoountContent.dart';
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

  static Future<dynamic> infoDialogAccount(
      {required BuildContext context, required item, void Function()? onTap}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InfoAccountContent(
                        title: "Cuenta:", content: item.emailAccount),
                    InfoAccountContent(
                        title: "Contraseña:", content: item.passAccount),
                    InfoAccountContent(
                        title: 'Perfil:', content: item.nameProfile),
                    InfoAccountContent(
                        title: 'Pin:', content: item.codeProfile.toString()),
                    InfoAccountContent(
                        title: 'Vence:', content: item.expirationDate),
                  ],
                ),
              ),
              IconButton(
                onPressed: onTap,
                icon: const Icon(Icons.copy),
              )
            ],
          ),
        );
      },
    );
  }
}
