import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manager_accounts/data/bloc/accounts/account_bloc.dart';
import 'package:manager_accounts/data/bloc/accounts/account_state.dart';
import 'package:manager_accounts/data/bloc/accounts/bloc_event.dart';
import 'package:manager_accounts/data/bloc/users/users_bloc.dart';
import 'package:manager_accounts/data/models/accounts/get_accounts_response.dart';
import 'package:manager_accounts/presentation/screens/account_form/fom.dart';
import 'package:manager_accounts/presentation/widgets/modals/commons/modal_loading.dart';
import 'package:manager_accounts/utils/config/constants.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:manager_accounts/utils/date_format_string.dart';

import '../../../utils/config/AppTheme.dart';
import '../../widgets/commons/commons.dart';

class AccountForm extends StatelessWidget {
  const AccountForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, AccountResponse>? arguments;

    arguments = ModalRoute.of(context)?.settings.arguments
        as Map<String, AccountResponse>?;

    final title = arguments?['item'] != null
        ? AppBarTitle.updateAccount
        : AppBarTitle.newAccounts;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FormInputsAccount(arguments: arguments),
            ),
          ],
        ),
      ),
    );
  }
}

class FormInputsAccount extends StatelessWidget {
  const FormInputsAccount({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final Map<String, AccountResponse>? arguments;

  @override
  Widget build(BuildContext context) {
    final item = arguments?['item'];

    final date = DateTime.parse(item?.expirationDate != null
        ? formatDateString(item?.expirationDate)
        : DateTime.now().add(const Duration(days: 30)).toString());
    final bloc = context.read<AccountBloc>();
    return BlocConsumer<AccountBloc, AccountState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is LoadingState && state.load) {
            showLoading(context);
          } else if (state is LoadingState && !state.load) {
            hideLoading(context);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return ReactiveFormBuilder(
              form: buildForm,
              builder: (context, form, child) {
                return Column(
                  children: [
                    InputBase(
                      form: form,
                      defaultValue: item?.emailAccount,
                      padding: EdgeInsets.only(top: 23.h),
                      formControl: "email_account",
                      label: 'Correo de cuenta',
                      onChanged: (String text) {},
                    ),
                    BlocBuilder<UsersBloc, UsersState>(
                      bloc: context.read<UsersBloc>(),
                      builder: (context, state) {
                        if (state is ListUsersData) {
                          final users = state.list;
                          return SelectInput<String>(
                              defaultValue: item?.idUser,
                              form: form,
                              items: [
                                const DropdownMenuItem(
                                    value: "dsfdsfsf",
                                    enabled: false,
                                    child: Text("Seleccione un nombre")),
                                ...users.map((item) => DropdownMenuItem(
                                      value: item.id,
                                      child: Text(item.nameUser),
                                    )),
                              ],
                              label: "Nombre de cliente",
                              onChanged: (p0) {},
                              formControl: "client_id");
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 23.h),
                      child: InputDateTime(
                        defaultValue: date,
                        form: form,
                        formControlName: 'expiration_date',
                        label: 'Fecha de renovacion',
                      ),
                    ),
                    InputBase(
                      defaultValue: item?.codeProfile.toString(),
                      form: form,
                      padding: EdgeInsets.only(top: 23.h),
                      formControl: "pin_account",
                      label: 'Pin de cuenta',
                      keyboardType: TextInputType.number,
                      onChanged: (String text) {},
                    ),
                    InputBase(
                      defaultValue: item?.nameProfile,
                      form: form,
                      padding: EdgeInsets.only(top: 8.h),
                      formControl: "account_profile",
                      label: 'Perfil de cuenta',
                      keyboardType: TextInputType.number,
                      onChanged: (String text) {},
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: InputPasswordBase(
                        defaultValue: item?.passAccount,
                        form: form,
                        padding: EdgeInsets.only(top: 8.h),
                        formControl: "password",
                        label: 'Contraseña',
                        onChanged: (String text) {},
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Button(
                          width: 150.w,
                          height:  45.w,
                        title: item != null ? 'Actualizar' : 'Guardar',
                        onTap: () {
                          if (item != null) {
                            bloc.add(UpdateAccountEvent(form, item.id));
                            return;
                          }
                          bloc.add(NewAccountEvent(form));
                        }),
                 
                    Button(
                        width: 150.w,
                        height:  45.w,
                        title: "Cancelar",
                        background: AppTheme.colors['secondaryColorButton'],
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        }),
                    ],)
                  ],
                );
              });
        });
  }
}
