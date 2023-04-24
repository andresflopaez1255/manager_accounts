import 'package:flutter/material.dart';
import 'package:manager_accounts/utils/config/AppTheme.dart';
import 'package:manager_accounts/presentation/widgets/commons/commons.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  FormGroup buildForm() => fb.group(<String, Object>{
        'email': FormControl<String>(
          validators: [Validators.required, Validators.email],
        ),
        'password': [
          '',
          Validators.required,
          Validators.minLength(8),
        ],
        'rememberMe': false,
      });
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
            ReactiveFormBuilder(
                form: buildForm,
                builder: (context, form, child) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          Text(
                            'Inicio de sesion ',
                            style: AppTheme.textStyle['subtitle2'],
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          InputBase(
                            formControl: "email",
                            label: 'Correo electronico',
                            onChanged: (String text) {},
                          ),
                          const SizedBox(
                            height: 34,
                          ),
                          InputPasswordBase(
                            formControl: "password",
                            label: 'Contraseña',
                            onChanged: (String text) {},
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 30),
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                '¿No recuerdas tu contraseña?, recuperarla aqui',
                                style: AppTheme.textStyle['smallText']
                                    ?.copyWith(
                                        decoration: TextDecoration.underline,
                                        decorationColor:
                                            AppTheme.colors['secondary']),
                              ),
                            ),
                          ),
                          Button(
                            onTap: () {
                             Navigator.pushReplacementNamed(context, '/home');
                            },
                            title: 'Ingresar',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 22),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/signUp');
                              },
                              child: Text(
                                textAlign: TextAlign.center,
                                '¿No tienes usuario? unete ',
                                style: AppTheme.textStyle['subtitle2']
                                    ?.copyWith(
                                        fontSize: 16,
                                        decoration: TextDecoration.underline,
                                        decorationColor:
                                            AppTheme.colors['secondary']),
                              ),
                            ),
                          )
                        ],
                      ));
                }),
          ],
        ),
      ),
    );
  }
}
