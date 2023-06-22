import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_accounts/data/bloc/users/users_bloc.dart';
import 'package:manager_accounts/presentation/widgets/users/form_edit/form_fields.dart';
import 'package:manager_accounts/utils/config/AppTheme.dart';
import 'package:manager_accounts/presentation/widgets/commons/commons.dart';
import 'package:reactive_forms/reactive_forms.dart';

class UserModalContent extends StatelessWidget {
  const UserModalContent({
    Key? key,
    required this.size,
    required TextEditingController controllerEmail,
  })  : _controllerEmail = controllerEmail,
        super(key: key);

  final Size size;
  final TextEditingController _controllerEmail;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(16),
      contentPadding: const EdgeInsets.all(0),
      content: SizedBox(
        width: size.width,
        child: ReactiveFormBuilder(
            form: formUser,
            builder: (context, form, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ButtonClose(),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                    child: Text(
                      'Registra nuevo usuario',
                      textAlign: TextAlign.left,
                      style: AppTheme.textStyle['subtitle2'],
                    ),
                  ),
                  const InputBase(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    label: 'Nombre usuario',
                    formControl: 'name_user',
                  ),
                  const InputBase(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    label: 'Celular de contacto',
                    keyboardType: TextInputType.phone,
                    formControl: 'phone_user',
                  ),
                  const InputBase(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    label: 'Correo electronico',
                    formControl: 'email_user',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Button(
                        title: 'Guardar',
                        onTap: (() {
                          context
                              .read<UsersBloc>()
                              .add(NewUserEvent(data: form));
                        })),
                  )
                ],
              );
            }),
      ),
    );
  }
}
