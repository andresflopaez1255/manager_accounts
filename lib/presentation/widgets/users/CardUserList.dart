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
    final categories = item.accounts.map((e) => e.category).toList();
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
            title: HeaderTitleUser(item: item),
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       
                        ColumnText(
                          title: 'Plataformas',
                          text: categories.isNotEmpty
                              ? categories.join(', ')
                              : 'No tiene cuentas',
                        ),

                         ColumnText(
                          title: 'Correo electrónico',
                          text: item.emailUser.isNotEmpty
                              ? item.emailUser
                              : 'No registrado',
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
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
                          backgroundColor:
                              AppTheme.colors['primary'] ?? Colors.blue,
                        ),
                        ButtonWithIcon(
                          text: 'Editar',
                          icon: Icons.edit,
                          onPress: () {
                            Navigator.pushNamed(context, '/userForm',
                                arguments: {
                                  'item': item,
                                });
                          },
                          backgroundColor:
                              AppTheme.colors['secondaryColorButton'] ??
                                  Colors.blue,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class HeaderTitleUser extends StatelessWidget {
  const HeaderTitleUser({
    Key? key,
    required this.item,
  }) : super(key: key);

  final UsersResponse item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ColumnText(title: "Nombre", text: item.nameUser)],
          ),
          ColumnText(
            title: 'Celular',
            text: item.cellphoneUser,
          ),
        ],
      ),
    );
  }
}
