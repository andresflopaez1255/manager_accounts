// ignore: file_names
import 'package:flutter/material.dart';
import 'package:manager_accounts/utils/config/AppTheme.dart';
import 'package:manager_accounts/presentation/widgets/commons/commons.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final items = [
    const DropdownMenuItem(
      value: 'item2',
      child: Text('item2'),
    ),
  ];

  Future<dynamic> sucessDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) => _sucessModalContent());
  }

  AlertDialog _sucessModalContent() {
    return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Flex(
                    mainAxisAlignment: MainAxisAlignment.end,
                    direction: Axis.horizontal,
                    children: [
                      CloseButton(),
                    ]),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child:
                      Icon( Icons.check_circle, size: 95, color: Colors.green,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Column(
                    children: [
                      Text(
                        'Usuario creado correctamente.',
                        style: AppTheme.textStyle['titleModal'],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Recuerda activar tu suscripcion con nuestro servicio de soporte.',
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset('assets/images/ovalo.png'),
                Positioned(
                  left: size.width / 2.8,
                  top: 50,
                  child: Text(
                    'Eliane',
                    style: AppTheme.textStyle['bigTitle'],
                  ),
                )
              ],
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Registro de usuario ',
                      style: AppTheme.textStyle['subtitle2'],
                      textAlign: TextAlign.left,
                    ),
                    InputBase(
                      padding: const EdgeInsets.only(top: 23),
                      formControl: "user_name",
                      label: 'Nombre de usuario',
                      onChanged: (String text) {},
                    ),
                    InputBase(
                      padding: const EdgeInsets.only(top: 23),
                      formControl: "email",
                      label: 'Correo electronico',
                      onChanged: (String text) {},
                    ),
                    SelectInput(
                      formControl: '',
                      padding: const EdgeInsets.only(top: 23),
                      items: items,
                      label: 'Tipo de documento',
                      onChanged: (Object result) {},
                    ),
                    InputBase(
                      padding: const EdgeInsets.only(top: 23),
                      formControl: "numID",
                      label: 'Numero de documento',
                      onChanged: (String text) {},
                    ),
                    InputPasswordBase(
                      padding: const EdgeInsets.only(top: 23),
                      formControl: "password",
                      label: 'Contraseña',
                      onChanged: (String text) {},
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: InputPasswordBase(
                        padding: const EdgeInsets.only(top: 23),
                        formControl: "confirmPaswword",
                        label: 'Confirmar contraseña',
                        onChanged: (String text) {},
                      ),
                    ),
                    Button(
                      
                      onTap: () {
                        //Navigator.pushReplacementNamed(context, '/home');
                        sucessDialog(context);
                      },
                      title: 'Registrar',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 22, bottom: 22),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/signIn');
                        },
                        child: Text(
                           '¿Ya tienes usuario?,Ingresa aqui',
                          textAlign: TextAlign.center,
                         
                          style: AppTheme.textStyle['subtitle2']?.copyWith(
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              decorationColor: AppTheme.colors['secondary']),
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
