import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_accounts/data/bloc/accounts/account_bloc.dart';
import 'package:manager_accounts/data/bloc/accounts/account_state.dart';
import 'package:manager_accounts/data/bloc/accounts/bloc_event.dart';
import 'package:manager_accounts/utils/config/AppTheme.dart';
import 'package:manager_accounts/data/models/accounts/get_accounts_response.dart';
import 'package:manager_accounts/presentation/widgets/accounts/accounts.dart';
import 'package:manager_accounts/presentation/widgets/commons/commons.dart';
import 'package:manager_accounts/presentation/widgets/modals/commons/common_modal_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardAccount extends StatelessWidget {
  final AccountResponse item;
  // ignore: prefer_const_constructors_in_immutables
  CardAccount({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ExpansionTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                showTrailingIcon: false,
                tilePadding: const EdgeInsets.symmetric(horizontal: 12),
                iconColor: Colors.black,
                textColor: Colors.black,
                title: HeaderTitle(item: item),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ColumnText(
                                title: 'Contraseña',
                                text: item.passAccount.replaceRange(
                                    2, item.passAccount.length, '*****'),
                              ),
                              ColumnText(
                                title: 'Perfil cuenta',
                                text: item.nameProfile,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ColumnText(
                              title: 'Fecha de vencimiento:',
                              text: item.expirationDate,
                            ),
                            ColumnText(
                              title: 'Pin cuenta',
                              text: item.codeProfile.toString(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 19,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ButtonWithIcon(
                              text: 'Eliminar',
                              icon: Icons.delete_forever,
                              onPress: () {
                                CommonModalController.deleteDialog(
                                    context: context,
                                    deletedTap: () {
                                      context
                                          .read<AccountBloc>()
                                          .add(DeleteAccountEvent(item.id));
                                      Navigator.pop(context);
                                    },
                                    message:
                                        'Si elimina esta cuenta no se podrá volver a recuperar su información');
                              },
                              backgroundColor:
                                  AppTheme.colors['primary'] ?? Colors.blue,
                            ),
                            ButtonWithIcon(
                              text: 'Editar',
                              icon: Icons.edit,
                              onPress: () {
                                Navigator.pushNamed(context, '/accountForm',
                                    arguments: {
                                      'item': item,
                                    });
                              },
                              backgroundColor:
                                  AppTheme.colors['secondaryColorButton'] ??
                                      Colors.blue,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({
    Key? key,
    required this.item,
  }) : super(key: key);

  final AccountResponse item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
      
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.emailAccount, style: AppTheme.textStyle['bodyText2']),
              const SizedBox(
                height: 5,
              ),
              Text(
                item.nameUser,
                style: AppTheme.textStyle['bodyText1']
                    ?.copyWith(fontSize: 12.sp, color: Colors.blueGrey),
              ),
            ],
          ),
        )
      ],
    );
  }
}
