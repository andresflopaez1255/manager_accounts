import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manager_accounts/data/bloc/accounts/account_bloc.dart';
import 'package:manager_accounts/data/bloc/accounts/account_state.dart';
import 'package:manager_accounts/data/bloc/accounts/bloc_event.dart';
import 'package:manager_accounts/data/bloc/users/users_bloc.dart';
import 'package:manager_accounts/data/models/accounts/get_accounts_response.dart';
import 'package:manager_accounts/data/models/users/userData.dart';
import 'package:manager_accounts/presentation/screens/account_form/fom.dart';
import 'package:manager_accounts/presentation/widgets/modals/commons/modal_loading.dart';
import 'package:manager_accounts/presentation/widgets/users/form_edit/form_fields.dart';
import 'package:manager_accounts/utils/config/constants.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../utils/config/AppTheme.dart';
import '../../widgets/commons/commons.dart';

class UserForm extends StatelessWidget {
  const UserForm({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, UsersResponse>? arguments;

    arguments = ModalRoute.of(context)?.settings.arguments
        as Map<String, UsersResponse>?;

    final title = arguments?['item'] != null
        ? AppBarTitle.updateUser
        : AppBarTitle.createUser;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FormInputsUser(arguments: arguments),
            ),
          ],
        ),
      ),
    );
  }
}

class FormInputsUser extends StatelessWidget {
  const FormInputsUser({
    super.key,
    required this.arguments,
  });

  final Map<String, UsersResponse>? arguments;

  @override
  Widget build(BuildContext context) {
    final item = arguments?['item'];
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
              form: formUser,
              builder: (context, form, child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25.h,
                    ),
                    const InputBase(
                      padding: EdgeInsets.only(bottom: 12),
                      label: 'Nombre usuario',
                      formControl: 'name_user',
                    ),
                    const InputBase(
                      padding: EdgeInsets.only(bottom: 12),
                      label: 'Celular de contacto',
                      keyboardType: TextInputType.phone,
                      formControl: 'phone_user',
                    ),
                    const InputBase(
                      padding: EdgeInsets.only(bottom: 40),
                      label: 'Correo electronico',
                      formControl: 'email_user',
                    ),
                    Button(
                        title: 'Guardar',
                        onTap: (() {
                          context
                              .read<UsersBloc>()
                              .add(NewUserEvent(data: form));

                          Navigator.pop(context);
                        })),
                    const SizedBox(
                      height: 24,
                    ),
                    OutlineBtn(
                      background: AppTheme.colors['secondaryColorButton'],
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      title: 'Cancelar',
                    ),
                  ],
                );
              });
        });
  }
}
