import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:manager_accounts/data/bloc/account_bloc.dart';
import 'package:manager_accounts/data/bloc/account_state.dart';
import 'package:manager_accounts/data/bloc/bloc_event.dart';
import 'package:manager_accounts/data/bloc/users/users_bloc.dart';
import 'package:manager_accounts/data/models/accounts/get_accounts_response.dart';
import 'package:manager_accounts/presentation/screens/account_form/fom.dart';
import 'package:manager_accounts/presentation/widgets/modals/commons/modal_loading.dart';
import 'package:manager_accounts/utils/config/constants.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../utils/config/AppTheme.dart';
import '../../widgets/commons/commons.dart';

class AccountForm extends StatelessWidget {
  const AccountForm({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String,AccountResponse>? arguments;
   
      arguments = ModalRoute.of(context)?.settings.arguments as Map<String,AccountResponse>? ;
       
       final title = arguments?['item'] != null ? AppBarTitle.updateAccount : AppBarTitle.newAccounts;

    return Scaffold(
      backgroundColor: AppTheme.colors['background'],
      appBar: AppBar(title:  Text(title)),
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

class FormInputsAccount extends StatefulWidget {
  late final AccountBloc bloc;
  late final UsersBloc userBloc;
  FormInputsAccount({
    Key? key,
    required this.arguments,
  }) : super(key: key) {
    bloc = Injector.appInstance.get<AccountBloc>();
    userBloc = Injector.appInstance.get<UsersBloc>();
  }

  final Map<String,AccountResponse>? arguments;

  @override
  State<FormInputsAccount> createState() => _FormInputsAccountState();
}

class _FormInputsAccountState extends State<FormInputsAccount> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.userBloc.add(UsersListEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.arguments?['item'];
    return BlocConsumer<AccountBloc, AccountState>(
        bloc: widget.bloc,
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
                      padding: const EdgeInsets.only(top: 23),
                      formControl: "email_account",
                      label: 'Correo de cuenta',
                      onChanged: (String text) {},
                    ),
                    BlocBuilder<UsersBloc, UsersState>(
                      bloc: widget.userBloc,
                      builder: (context, state) {
                        if (state is ListUsersData) {
                          final users = state.list;
                          return SelectInput<int>(
                            defaultValue: item?.idUser,
                            form: form,
                              padding: const EdgeInsets.only(top: 23),
                              items: [
                                const DropdownMenuItem(
                                    value: 0,
                                    enabled: false,
                                    child: Text("Seleccione un nombre")),
                                ...users
                                    .map((item) => DropdownMenuItem(
                                          value: item.id,
                                          child: Text(item.nameUser),
                                        ))
                                    .toList(),
                              ],
                              label: "Nombre de cliente",
                              onChanged: (p0) {},
                              formControl: "client_id");
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    InputBase(
                      defaultValue: item?.codeProfile.toString(),
                      form: form,
                      padding: const EdgeInsets.only(top: 23),
                      formControl: "pin_account",
                      label: 'Pin de cuenta',
                      keyboardType: TextInputType.number,
                      onChanged: (String text) {},
                    ),
                    InputBase(
                      defaultValue: item?.nameProfile,
                       form: form,
                      padding: const EdgeInsets.only(top: 23),
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
                        padding: const EdgeInsets.only(top: 23),
                        formControl: "password",
                        label: 'Contraseña',
                        onChanged: (String text) {},
                      ),
                    ),
                    Button(
                        title: item != null ? 'Actualizar': 'Guardar',
                        onTap: () {
                          if(item != null){
                            widget.bloc.add(UpdateAccountEvent(form, item.id));
                            return;
                          }
                          widget.bloc.add(NewAccountEvent(form));
                        }),
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
