import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manager_accounts/data/bloc/accounts/account_bloc.dart';
import 'package:manager_accounts/data/bloc/accounts/account_state.dart';
import 'package:manager_accounts/data/bloc/accounts/bloc_event.dart';
import 'package:manager_accounts/data/bloc/categories/categories_bloc.dart';
import 'package:manager_accounts/data/bloc/categories/categories_event.dart';
import 'package:manager_accounts/data/bloc/categories/categories_state.dart';
import 'package:manager_accounts/data/bloc/users/users_bloc.dart';
import 'package:manager_accounts/data/models/accounts/get_accounts_response.dart';
import 'package:manager_accounts/data/models/categories/categories_response.dart';
import 'package:manager_accounts/presentation/screens/account_form/fom.dart';
import 'package:manager_accounts/presentation/widgets/modals/commons/modal_loading.dart';
import 'package:manager_accounts/utils/config/constants.dart';
import 'package:manager_accounts/utils/hex_to_color.dart';
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

class FormInputsAccount extends StatefulWidget {
  const FormInputsAccount({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final Map<String, AccountResponse>? arguments;

  @override
  State<FormInputsAccount> createState() => _FormInputsAccountState();
}

class _FormInputsAccountState extends State<FormInputsAccount> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UsersBloc>().add(UsersListEvent());
      context.read<CategoriesBloc>().add(CategoriesListEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.arguments?['item'];

    final date = DateTime.parse(item?.expirationDate != null
        ? formatDateString(item?.expirationDate)
        : DateTime.now().add(const Duration(days: 30)).toString());
    final bloc = context.read<AccountBloc>();
    return BlocConsumer<AccountBloc, AccountState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is LoadingState) {
            showLoading(context);
          }
          hideLoading(context);
          if (state is SuccessState) {
            Navigator.pushReplacementNamed(context, '/home');
            /*  if (state is FailureAccount) {
              final snackBar = SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } */
          }
        },
        builder: (context, state) {
          return ReactiveFormBuilder(
              form: buildForm,
              builder: (context, form, child) {
                return Column(
                  children: [
                    item == null
                        ? BlocBuilder<CategoriesBloc, CategoriesState>(
                            builder: (context, state) {
                              if (state is CategoriesDataState) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: CategorySelect(
                                    categories: state.categories,
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          )
                        : const SizedBox.shrink(),
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
                            height: 45.w,
                            title: item != null ? 'Actualizar' : 'Guardar',
                            onTap: () {
                              if (item != null) {
                                form.control('category_id').value =
                                    item.idCategory;
                                bloc.add(UpdateAccountEvent(form, item.id));
                                return;
                              }
                              final state = bloc.state;
                              form.control('category_id').value =
                                  state is ChangeCategoryAccountState
                                      ? state.idCategory
                                      : null;
                              bloc.add(NewAccountEvent(form));
                            }),
                        Button(
                            width: 150.w,
                            height: 45.w,
                            title: "Cancelar",
                            background: AppTheme.colors['secondaryColorButton'],
                            onTap: () {
                              Navigator.pushReplacementNamed(context, '/home');
                            }),
                      ],
                    )
                  ],
                );
              });
        });
  }
}

class CategorySelect extends StatelessWidget {
  final List<Category> categories;

  const CategorySelect({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        // Estado actual seleccionado (ya sea desde bloc o prop inicial)
        final selectedId =
            state is ChangeCategoryAccountState ? state.idCategory : "";

        final isSelected = categories
            .map((cat) => cat.id == selectedId)
            .toList(growable: false);

        return ToggleButtons(
          borderRadius: BorderRadius.circular(8),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          isSelected: isSelected,
          onPressed: (index) {
            context.read<AccountBloc>().add(
                  ChangeCategoryAccountEvent(categories[index].id),
                );
          },
          children: categories.map((category) {
            final color = hexToColor(category.color ?? '#FFFFFF');
            final selected = category.id == selectedId;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: color.withAlpha(selected ? 255 : 50),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: Image.network(
                category.image!,
                width: 45.w,
                height: 45.h,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
