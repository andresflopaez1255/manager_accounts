import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manager_accounts/data/bloc/users/users_bloc.dart';
import 'package:manager_accounts/data/models/users/userContact.dart';
import 'package:manager_accounts/data/models/users/userData.dart';
import 'package:manager_accounts/presentation/widgets/users/form_edit/form_fields.dart';
import 'package:manager_accounts/utils/config/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../utils/config/AppTheme.dart';
import '../../widgets/commons/commons.dart';

class UserForm extends StatelessWidget {
  const UserForm({Key? key}) : super(key: key);

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
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final Map<String, UsersResponse>? arguments;
  final bloc = UsersBloc;

  @override
  Widget build(BuildContext context) {
    final item = arguments?['item'];

    Future<void> seleccionarContacto() async {
      // Paso 1: Solicitar permiso manualmente
      var status = await Permission.contacts.status;
      if (!status.isGranted) {
        status = await Permission.contacts.request();
        if (!status.isGranted) {
          debugPrint('Permiso denegado');
          return;
        }
      }

      // Paso 2: Abrir selector nativo
      final contacto = await FlutterContacts.openExternalPick();
      if (contacto == null) {
        debugPrint('No se seleccionó contacto o se canceló');
        return;
      }

      final detalles = await FlutterContacts.getContact(contacto.id);
      debugPrint('Contacto seleccionado: $detalles');

      // ignore: use_build_context_synchronously
      context.read<UsersBloc>().add(SetContactUser(Usercontact(
            name: detalles?.displayName,
            phone: detalles?.phones.isNotEmpty == true
                ? detalles!.phones.first.number
                : null,
          )));
    }

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
              BlocConsumer<UsersBloc, UsersState>(
                listener: (context, state) {
                  if (state is UserContactState) {
                    form.control('name_user').value = state.contact.name;
                    form.control('phone_user').value = state.contact.phone;
                  }
                },
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputBase(
                        form: form,
                        defaultValue: item?.nameUser,
                        padding: const EdgeInsets.only(bottom: 12),
                        label: 'Nombre usuario',
                        formControl: 'name_user',
                      ),
                      InputBase(
                        form: form,
                        defaultValue: item?.cellphoneUser,
                        padding: const EdgeInsets.only(bottom: 12),
                        label: 'Celular de contacto',
                        keyboardType: TextInputType.phone,
                        formControl: 'phone_user',
                      ),
                      InputBase(
                        form: form,
                        height: 45.h,
                        defaultValue: item?.emailUser,
                        label: 'Correo electronico',
                        formControl: 'email_user',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 40),
                        child: InkWell(
                            onTap: () {
                              seleccionarContacto();
                            },
                            child: Text(
                              "Seleccionar contacto",
                              textAlign: TextAlign.left,
                              style: AppTheme.textStyle["bodyText2"]?.copyWith(
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.solid,
                              ),
                            )),
                      ),
                    ],
                  );
                },
              ),
              Button(
                  title: 'Guardar',
                  onTap: (() {
                    context.read<UsersBloc>().add(NewUserEvent(data: form));

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
  }
}
