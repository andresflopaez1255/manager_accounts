import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_accounts/data/bloc/accounts/account_bloc.dart';
import 'package:manager_accounts/data/bloc/accounts/account_state.dart';
import 'package:manager_accounts/data/bloc/accounts/bloc_event.dart';
import 'package:manager_accounts/presentation/widgets/modals/commons/modal_loading.dart';
import 'package:manager_accounts/utils/config/AppTheme.dart';
import 'package:manager_accounts/data/models/accounts/get_accounts_response.dart';
import 'package:manager_accounts/presentation/widgets/accounts/accounts.dart';
import 'package:manager_accounts/presentation/widgets/commons/commons.dart';
import 'package:manager_accounts/presentation/widgets/modals/commons/common_modal_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardAccount extends StatelessWidget {
  final AccountResponse item;
  final controller = ExpansibleController();
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
          child: InkWell(
            onTap: () {
              if (controller.isExpanded) {
                controller.collapse();
              } else {
                controller.expand();
              }
            },
            onLongPress: () async {
              final data =
                  "Correo: ${item.emailAccount}\nContraseña: ${item.passAccount}\nPerfil: ${item.nameProfile}\nPin: ${item.codeProfile}\nVence: ${item.expirationDate}";

              CommonModalController.infoDialogAccount(
                context: context,
                item: item,
                onTap: () {
                  Clipboard.setData(ClipboardData(text: data));
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Información de la cuenta copiada al portapapeles',
                        style: AppTheme.textStyle['bodyText2']
                            ?.copyWith(color: Colors.white),
                      ),
                      backgroundColor:
                          AppTheme.colors['primary'] ?? Colors.blue,
                    ),
                  );
                },
              );
            },
            child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ExpansionTile(
                  enableFeedback: true,
                  dense: false,
                  controller: controller,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  showTrailingIcon: false,
                  tilePadding: const EdgeInsets.symmetric(horizontal: 12),
                  title: HeaderTitle(item: item),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
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
                          const SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ColumnText(
                                  title: 'Fecha de renov:',
                                  text: item.expirationDate,
                                ),
                                ColumnText(
                                  title: 'Pin cuenta',
                                  text: item.codeProfile.toString(),
                                ),
                              ],
                            ),
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
                                        if (state is LoadingState) {
                                          showLoading(context);
                                        } else if (state is SuccessState) {
                                          hideLoading(context);
                                        }
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
          ),
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

  Widget generateTag(String category) {
    Color colorContainerTag = Colors.black;
    Color colorTextTag = Colors.red;
    if (category.contains("Netflix")) {
      colorContainerTag = Colors.black;
      colorTextTag = Colors.red;
    } else if (category.contains("HBO")) {
      colorContainerTag = Colors.red;
      colorTextTag = Colors.white;
    } else if (category.contains("Disney")) {
      colorContainerTag = Colors.blueAccent;
      colorTextTag = Colors.white;
    } else if (category.contains("Spotify")) {
      colorContainerTag = Colors.green;
      colorTextTag = Colors.white;
    } else if (category.contains("Amazon")) {
      colorContainerTag = Colors.orange;
      colorTextTag = Colors.white;
    } else if (category.contains("Apple")) {
      colorContainerTag = Colors.grey;
      colorTextTag = Colors.white;
    }

    return Container(
      height: 20.h,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: colorContainerTag,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          item.category!,
          textAlign: TextAlign.center,
          style: AppTheme.textStyle['bodyText2']?.copyWith(
            color: colorTextTag,
            fontSize: 10.sp,
          ),
        ),
      ),
    );
  }

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
            children: [
              Text(item.emailAccount, style: AppTheme.textStyle['bodyText2']),
              const SizedBox(
                height: 5,
              ),
              Text(
                item.nameUser,
                style:
                    AppTheme.textStyle['bodyText1']?.copyWith(fontSize: 12.sp),
              ),
            ],
          ),
          generateTag(item.category!)
        ],
      ),
    );
  }
}
