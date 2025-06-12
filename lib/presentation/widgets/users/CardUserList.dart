import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_accounts/data/bloc/users/users_bloc.dart';
import 'package:manager_accounts/data/models/users/userData.dart';
import 'package:manager_accounts/utils/config/AppTheme.dart';
import 'package:manager_accounts/presentation/widgets/accounts/accounts.dart';
import 'package:manager_accounts/presentation/widgets/commons/commons.dart';
import 'package:manager_accounts/presentation/widgets/modals/commons/common_modal_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CardUserList extends StatelessWidget {
  final UsersResponse item;
  const CardUserList({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ColumnText(
                    title: 'Nombre cliente',
                    text: item.nameUser,
                  ),
                  ColumnText(
                    title: 'Celular',
                    text: item.cellphoneUser,
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ColumnText(
                    title: 'Plataformas',
                    text: item.nameUser,
                  ),
                ],
              ),
            ]),
            SizedBox(height: 12.h),
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
                              .read<UsersBloc>()
                              .add(DeleteUsersEvent(item.id));

                          Navigator.pop(context);
                        },
                        message:
                            'Si elimina este usuario no se podrá volver a recuperar su información');
                  },
                  backgroundColor: AppTheme.colors['primary'] ?? Colors.blue,
                ),
                ButtonWithIcon(
                  text: 'Editar',
                  icon: Icons.edit,
                  onPress: () {
                    Navigator.pushNamed(context, '/userForm', arguments: {
                      'item': item,
                    });
                  },
                  backgroundColor:
                      AppTheme.colors['secondaryColorButton'] ?? Colors.blue,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
